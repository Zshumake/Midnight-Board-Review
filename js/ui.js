import { ICONS } from './icons.js';

export const ui = {
    // Elements
    audio: document.getElementById('audio'),
    playBtn: document.getElementById('play'),
    prevBtn: document.getElementById('prev'),
    nextBtn: document.getElementById('next'),
    skipBackBtn: document.getElementById('skip-back'),
    skipFwdBtn: document.getElementById('skip-fwd'),
    speedSelect: document.getElementById('speed-select'),
    progressContainer: document.getElementById('progress-container'),
    progressBar: document.getElementById('progress-bar'),
    title: document.getElementById('current-track-title'),
    copyRssBtn: document.getElementById('copy-rss'),
    rssUrlText: document.getElementById('rss-url'),
    searchInput: document.getElementById('search-input'),
    episodeList: document.getElementById('episode-list'),

    // Sticky Player Elements
    stickyPlayer: document.getElementById('sticky-player'),
    stickyPlayBtn: document.getElementById('sticky-play'),
    stickySkipBack: document.getElementById('sticky-skip-back'),
    stickySkipFwd: document.getElementById('sticky-skip-fwd'),
    stickyTitle: document.getElementById('sticky-title'),
    stickyProgressBar: document.getElementById('sticky-progress-bar'),
    stickyProgressContainer: document.getElementById('sticky-progress-container'),
    stickySpeedSelect: document.getElementById('sticky-speed-select'),
    errorToast: document.getElementById('error-toast'),

    /**
     * Show Error Toast
     */
    showError(message) {
        if (this.errorToast) {
            this.errorToast.innerText = message;
            this.errorToast.classList.add('visible');
            setTimeout(() => {
                this.errorToast.classList.remove('visible');
            }, 3000);
        }
    },

    /**
     * Render the episode list grouped by category
     */
    renderLibrary(episodes, activeIndex, state, onEpisodeClick) {
        this.episodeList.innerHTML = '';

        // Group by category
        const groups = episodes.reduce((acc, ep, index) => {
            if (!acc[ep.category]) acc[ep.category] = [];
            // Use originalIndex if passed (from filtering), otherwise use index
            const effectiveIndex = (ep.originalIndex !== undefined) ? ep.originalIndex : index;
            acc[ep.category].push({ ...ep, effectiveIndex });
            return acc;
        }, {});

        for (const [category, items] of Object.entries(groups)) {
            const groupDiv = document.createElement('div');
            groupDiv.className = 'category-group';

            const catTitle = document.createElement('div');
            catTitle.className = 'category-title';
            catTitle.innerText = category;
            groupDiv.appendChild(catTitle);

            items.forEach(item => {
                const epDiv = document.createElement('div');
                const isFinished = state.isListened(item.title);
                const isActive = (item.effectiveIndex === activeIndex);

                // Only mark as 'finished' (Solid Orange) if it is NOT currently active/playing.
                // If it is active, we want to show the transparent progress bar.
                epDiv.className = `episode-item ${isActive ? 'active' : ''} ${isFinished && !isActive ? 'finished' : ''}`;
                const listened = state.isListened(item.title);

                // Progress Fill Overlay
                const progressFill = document.createElement('div');
                progressFill.className = 'episode-progress-fill';

                // Calculate width
                let percent = 0;
                if (isFinished && !isActive) {
                    percent = 100; // Finished and not playing -> Full Solid
                } else {
                    percent = state.getProgressPercentage(item.title);
                }
                progressFill.style.width = `${percent}%`;

                epDiv.appendChild(progressFill);

                const headerDiv = document.createElement('div');
                headerDiv.className = 'episode-header';

                // Play/Pause Button for List
                const listPlayBtn = document.createElement('button');
                listPlayBtn.className = 'list-play-btn';
                listPlayBtn.innerHTML = ICONS.play; // Default
                listPlayBtn.dataset.index = item.effectiveIndex;
                listPlayBtn.onclick = (e) => {
                    e.stopPropagation(); // Prevent accordion toggle
                    onEpisodeClick(item.effectiveIndex, 'play');
                };

                const titleSpan = document.createElement('span');
                titleSpan.className = 'episode-title-text';
                titleSpan.innerText = item.title;

                const statusSpan = document.createElement('span');
                statusSpan.className = 'status-icon';
                // Use checkmark if listened
                statusSpan.innerText = listened ? '✓' : '';

                headerDiv.appendChild(listPlayBtn);
                headerDiv.appendChild(titleSpan);
                headerDiv.appendChild(statusSpan);

                // Description Container (Hidden until clicked)
                const descDiv = document.createElement('div');
                descDiv.className = 'episode-description';
                descDiv.innerText = item.description || 'No description available.';

                epDiv.appendChild(headerDiv);
                epDiv.appendChild(descDiv);

                // Row Click Handler: Toggle Accordion Only
                epDiv.onclick = (e) => {
                    // Prevent collapse if clicking inside description
                    if (e.target.closest('.episode-description')) return;

                    // Close ALL other open accordions
                    const allExpanded = document.querySelectorAll('.episode-item.expanded');
                    allExpanded.forEach(el => {
                        if (el !== epDiv) el.classList.remove('expanded');
                    });

                    // Toggle Current
                    epDiv.classList.toggle('expanded');
                };

                groupDiv.appendChild(epDiv);
            });

            this.episodeList.appendChild(groupDiv);
        }
    },

    /**
     * Update the track metadata and title
     */
    updateTrack(episode, isListened) {
        this.title.innerHTML = `${episode.title} ${isListened ? '<span style="color: green; font-size: 0.8em;">✓</span>' : ''}`;

        // Update Sticky Player
        if (this.stickyTitle) {
            this.stickyTitle.innerText = episode.title;
        }
        if (this.stickyPlayer) {
            this.stickyPlayer.classList.add('visible');
        }

        // Dynamically update the specific list item status
        this.updateEpisodeStatus(episode.title, isListened);
    },

    /**
     * Helper to update the status icon and finished state of a specific row
     */
    updateEpisodeStatus(title, isListened) {
        const allRows = document.querySelectorAll('.episode-item');
        allRows.forEach(row => {
            const titleEl = row.querySelector('.episode-title-text');
            if (titleEl && titleEl.innerText === title) {
                // Update Badge
                const statusIcon = row.querySelector('.status-icon');
                if (statusIcon) {
                    statusIcon.innerText = isListened ? '✓' : '';
                }
                // Update Finished Class (only if not active)
                if (isListened && !row.classList.contains('active')) {
                    row.classList.add('finished');
                }
            }
        });
    },

    /**
     * Update the progress bar visually
     */
    updateProgress(currentTime, duration) {
        if (duration) {
            const percent = (currentTime / duration) * 100;
            this.progressBar.style.width = `${percent}%`;

            if (this.stickyProgressBar) {
                this.stickyProgressBar.style.width = `${percent}%`;
            }

            // Update the active item's progress fill in real-time
            const activeItem = document.querySelector('.episode-item.active');
            if (activeItem) {
                const fill = activeItem.querySelector('.episode-progress-fill');
                // Ensure we are in "progress mode" (transparent) not "finished mode" (solid)
                if (fill) {
                    fill.style.width = `${percent}%`;
                }
            }
        }
    },

    /**
     * Update play/pause button state
     */
    setPlaying(isPlaying) {
        const icon = isPlaying ? ICONS.pause : ICONS.play;
        this.playBtn.innerHTML = icon;

        if (this.stickyPlayBtn) {
            this.stickyPlayBtn.innerHTML = icon;
        }
    },

    /**
     * Update the Icons AND Class States in the List
     */
    updateListPlayStates(currentTitle, isPlaying, state) {
        // 1. Reset all buttons to Play
        const allBtns = document.querySelectorAll('.list-play-btn');
        allBtns.forEach(btn => btn.innerHTML = ICONS.play);

        // 2. Manage Active/Finished classes for ALL rows
        const allRows = document.querySelectorAll('.episode-item');
        allRows.forEach(row => {
            const titleEl = row.querySelector('.episode-title-text');
            if (!titleEl) return;
            const rowTitle = titleEl.innerText;

            // Ensure status icon is up to date regardless of play state
            const isListened = state ? state.isListened(rowTitle) : false;
            const statusIcon = row.querySelector('.status-icon');
            if (statusIcon) {
                statusIcon.innerText = isListened ? '✓' : '';
            }

            if (rowTitle === currentTitle) {
                // ACTIVE ROW
                row.classList.add('active');
                // Active row CANNOT be visually finished (solid), it must show progress bar
                row.classList.remove('finished');

                // Update Play Icon for this row
                const btn = row.querySelector('.list-play-btn');
                if (btn && isPlaying) {
                    btn.innerHTML = ICONS.pause;
                }
            } else {
                // INACTIVE ROW
                row.classList.remove('active');
                // If inactive AND listened, mark as finished (Solid)
                if (isListened) {
                    row.classList.add('finished');
                    // Ensure bar is full width for solid efffect
                    const fill = row.querySelector('.episode-progress-fill');
                    if (fill) fill.style.width = '100%';
                }
            }
        });
    }
};

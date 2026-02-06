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
                epDiv.className = `episode-item ${item.effectiveIndex === activeIndex ? 'active' : ''}`;
                const listened = state.isListened(item.title);

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
    },

    /**
     * Update the progress bar visually
     */
    updateProgress(currentTime, duration) {
        if (duration) {
            const percent = (currentTime / duration) * 100;
            this.progressBar.style.width = `${percent}%`;
        }
    },

    /**
     * Update play/pause button state
     */
    setPlaying(isPlaying) {
        this.playBtn.innerHTML = isPlaying ? ICONS.pause : ICONS.play;
    },

    /**
     * Update the Icons in the List
     */
    updateListPlayStates(currentTitle, isPlaying) {
        // 1. Reset all buttons to Play and remove active class from all rows
        const allBtns = document.querySelectorAll('.list-play-btn');
        const allRows = document.querySelectorAll('.episode-item');

        allBtns.forEach(btn => btn.innerHTML = ICONS.play);
        allRows.forEach(row => row.classList.remove('active'));

        // 2. Find the row/button for the current title
        // We can match by text content of the title span
        let foundBtn = null;
        let foundRow = null;

        allRows.forEach(row => {
            const titleEl = row.querySelector('.episode-title-text');
            if (titleEl && titleEl.innerText === currentTitle) {
                foundRow = row;
                foundBtn = row.querySelector('.list-play-btn');
            }
        });

        // 3. Update the specific one
        if (foundRow) {
            foundRow.classList.add('active');
        }

        if (foundBtn && isPlaying) {
            foundBtn.innerHTML = ICONS.pause;
        }
    }
};

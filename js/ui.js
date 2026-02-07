import { ICONS } from './icons.js';
import { state } from './state.js';

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
    currentTimeLabel: document.getElementById('current-time'), // New
    durationLabel: document.getElementById('duration'), // New
    episodeList: document.getElementById('episode-list'),
    shareBtn: document.getElementById('share-btn'), // New
    categoryTabs: document.getElementById('category-tabs'), // New

    // State
    isDragging: false,

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
     * Helper to create the badge container DOM
     */
    createBadgeContainer(count) {
        const container = document.createElement('div');
        container.className = 'status-container';
        if (count > 0) {
            for (let i = 0; i < count; i++) {
                const badge = document.createElement('span');
                badge.className = 'status-badge';
                badge.innerText = '✓';
                container.appendChild(badge);
            }
        }
        return container;
    },

    /**
     * Render the Category Filter Pills
     */
    renderCategoryTabs(categories, activeCategory, onSelect) {
        if (!this.categoryTabs) return;
        this.categoryTabs.innerHTML = '';

        // Dynamic Tabs (includes 'All' if passed in array)
        categories.forEach(cat => {
            const tab = document.createElement('div');
            tab.className = `category-tab ${activeCategory === cat ? 'active' : ''}`;
            tab.innerText = this.formatCategoryName(cat); // Use short name
            tab.onclick = () => onSelect(cat);
            this.categoryTabs.appendChild(tab);
        });
    },

    /**
     * Shorten specific long category names for UI pills
     */
    formatCategoryName(cat) {
        if (!cat) return '';
        // Musculoskeletal
        if (cat.includes('Upper Extremity')) return 'Upper Extremity';
        if (cat.includes('Lower Extremity')) return 'Lower Extremity';
        if (cat.startsWith('Musculoskeletal:')) return cat.replace('Musculoskeletal:', 'MSK:'); // Fallback for others

        // Neurology
        if (cat.includes('TBI')) return 'TBI';
        if (cat.includes('SCI')) return 'SCI';
        if (cat.includes('CVA') || cat.includes('Cerebrovascular')) return 'CVA';
        if (cat === 'Neurology: Miscellaneous') return 'Neuro: Misc'; // Strict match
        if (cat.startsWith('Neurology:')) return cat.replace('Neurology:', 'Neuro:'); // Fallback

        // Others
        if (cat.includes('Cardiopulmonary')) return 'Cancer/Pulm/Cardiac';
        if (cat.includes('Electrodiagnostic')) return 'EDX';
        if (cat.includes('Prosthetics')) return 'P&O';
        if (cat.includes('Physical Modalities')) return 'Modalities';
        if (cat.includes('Pediatrics')) return 'Peds';
        if (cat.includes('Pain Medicine')) return 'Pain';
        if (cat.includes('Rheumatology')) return 'Rheum';

        return cat;
    },

    /**
     * Render the episode list grouped by category
     */
    renderLibrary(episodes, activeIndex, state, onEpisodeClick, onEpisodeHover, searchTerm = '') {
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

            // Category Header with "Master All" option
            const header = document.createElement('div');
            header.className = 'category-header-group';

            const title = document.createElement('h4');
            title.innerText = category;
            header.appendChild(title);

            if (category !== 'All') {
                const masterBtn = document.createElement('button');
                masterBtn.className = 'category-master-btn';
                masterBtn.title = `Mark all in ${category} as mastered`;
                masterBtn.innerHTML = `
                    <svg viewBox="0 0 24 24" width="16" height="16">
                        <path fill="currentColor" d="M9 16.17L4.83 12l-1.42 1.41L9 19 21 7l-1.41-1.41z"/>
                    </svg>
                    Master All
                `;
                masterBtn.onclick = (e) => {
                    e.stopPropagation();
                    if (confirm(`Mark all ${items.length} episodes in "${category}" as mastered?`)) {
                        document.dispatchEvent(new CustomEvent('master-category', {
                            detail: { category: category, episodes: items }
                        }));
                    }
                };
                header.appendChild(masterBtn);
            }

            groupDiv.appendChild(header);

            items.forEach(item => {
                const epDiv = document.createElement('div');
                const isFinished = state.isListened(item.title);
                const isActive = (item.effectiveIndex === activeIndex);

                // Only mark as 'finished' (Solid Orange) if it is NOT currently active/playing.
                // If it is active, we want to show the transparent progress bar.
                // UPDATE: Per user request, we NO LONGER use 'finished' solid style.
                // Instead we let it match the active state or reset to 0 for animation.
                epDiv.className = `episode-item ${isActive ? 'active' : ''}`;
                const listened = state.isListened(item.title);

                // Progress Fill Overlay
                const progressFill = document.createElement('div');
                progressFill.className = 'episode-progress-fill';

                // Calculate width
                let percent = 0;
                if (isFinished && !isActive) {
                    percent = 0; // Finished -> Slide back to 0 (Gray)
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
                titleSpan.innerHTML = this.highlightText(item.title, searchTerm);

                const statusSpan = document.createElement('span');
                statusSpan.className = 'status-icon';

                // Get badge count (legacy 'isListened' check handled inside getCompletionCount wrapper or direct state check)
                // We need extended state method or direct check
                let badgeCount = state.getCompletionCount(item.title);

                // If 0 but marked as listened in legacy history, treat as 1 (handled by migration but safe to assume)
                if (badgeCount === 0 && state.isListened(item.title)) badgeCount = 1;

                // Generate Badges
                statusSpan.innerHTML = '✓'.repeat(badgeCount);

                headerDiv.appendChild(listPlayBtn);
                headerDiv.appendChild(titleSpan);
                headerDiv.appendChild(statusSpan);

                // Description Container (Hidden until clicked)
                const descDiv = document.createElement('div');
                descDiv.className = 'episode-description';
                descDiv.innerHTML = this.highlightText(item.description || 'No description available.', searchTerm);

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

                // Context Menu: Mark as Mastered (Manual Badge)
                epDiv.addEventListener('contextmenu', (e) => {
                    e.preventDefault(); // Block default browser menu

                    // Simple Confirm Dialog
                    if (confirm(`Mark "${item.title}" as Mastered? 🏅\n(This will award 1 badge)`)) {
                        // We need a callback or direct state access. 
                        // Since we are in renderLibrary, we can pass a callback or just use the state object if exposed?
                        // Ideally pass 'onMastery' callback. But to save refactoring 5 tiers, we'll dispatch a custom event or check if we can access logic.
                        // For now, let's dispatch a custom event on the document.
                        const event = new CustomEvent('manual-mastery', { detail: { title: item.title } });
                        document.dispatchEvent(event);
                    }
                });

                // Hover Preload Logic (Debounced)
                let hoverTimer = null;
                epDiv.addEventListener('mouseenter', () => {
                    if (onEpisodeHover) {
                        hoverTimer = setTimeout(() => {
                            onEpisodeHover(item.url);
                        }, 200); // Wait 200ms before requesting
                    }
                });

                epDiv.addEventListener('mouseleave', () => {
                    if (hoverTimer) {
                        clearTimeout(hoverTimer);
                        hoverTimer = null;
                    }
                });

                groupDiv.appendChild(epDiv);
            });

            this.episodeList.appendChild(groupDiv);
        }
    },

    /**
     * Update the track metadata and title
     */
    updateTrack(episode, isListened, nextEpisode = null) {
        // Calculate badges
        let badgeCount = state.getCompletionCount(episode.title);
        if (badgeCount === 0 && isListened) badgeCount = 1;

        // 1. Update Main Title
        this.title.innerHTML = ''; // Clear
        const textNode = document.createTextNode(episode.title + ' ');
        this.title.appendChild(textNode);

        if (badgeCount > 0) {
            const container = this.createBadgeContainer(badgeCount);
            container.style.display = 'inline-flex';
            container.style.marginLeft = '12px';
            container.style.verticalAlign = 'middle';
            this.title.appendChild(container);
        }

        // 2. Update Sticky Player Title
        if (this.stickyTitle) {
            this.stickyTitle.innerHTML = '';
            const stickyText = document.createTextNode(episode.title + ' ');
            this.stickyTitle.appendChild(stickyText);

            if (badgeCount > 0) {
                const stickyContainer = this.createBadgeContainer(badgeCount);
                stickyContainer.style.display = 'inline-flex';
                stickyContainer.style.marginLeft = '12px';
                stickyContainer.style.verticalAlign = 'middle';
                this.stickyTitle.appendChild(stickyContainer);
            }
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
                let statusContainer = row.querySelector('.status-container');
                // Backwards compat if refactoring live DOM (unlikely but safe)
                if (!statusContainer) {
                    const oldIcon = row.querySelector('.status-icon');
                    if (oldIcon) {
                        statusContainer = document.createElement('div');
                        statusContainer.className = 'status-container';
                        oldIcon.replaceWith(statusContainer);
                    }
                }

                if (statusContainer) {
                    statusContainer.innerHTML = ''; // Clear

                    let badgeCount = state.getCompletionCount(title);
                    if (badgeCount === 0 && isListened) badgeCount = 1;

                    for (let i = 0; i < badgeCount; i++) {
                        const badge = document.createElement('span');
                        badge.className = 'status-badge';
                        badge.innerText = '✓';
                        statusContainer.appendChild(badge);
                    }
                }
                // Update Finished Class: REMOVED per user request (no solid orange)
                if (isListened && !row.classList.contains('active')) {
                    // Ensure progress bar slides back to 0
                    const fill = row.querySelector('.episode-progress-fill');
                    if (fill) fill.style.width = '0%';
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

            // Update Numeric Labels
            if (this.currentTimeLabel) this.currentTimeLabel.innerText = this.formatTime(currentTime);
            if (this.durationLabel) this.durationLabel.innerText = this.formatTime(duration);

            // Update the active item's progress fill in real-time
            const activeItem = document.querySelector('.episode-item.active');
            if (activeItem) {
                const fill = activeItem.querySelector('.episode-progress-fill');
                if (fill) fill.style.width = `${percent}%`;
            }
        }
    },

    /**
     * Highlight matching text in a string
     */
    highlightText(text, term) {
        if (!term || !term.trim()) return text;
        const normalizedTerm = term.trim().toLowerCase();

        // Escape regex special chars
        const escaped = normalizedTerm.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
        const regex = new RegExp(`(${escaped})`, 'gi');

        return text.replace(regex, '<mark class="highlight">$1</mark>');
    },

    /**
     * Format seconds into M:SS or H:MM:SS
     */
    formatTime(seconds) {
        if (isNaN(seconds)) return '0:00';
        const h = Math.floor(seconds / 3600);
        const m = Math.floor((seconds % 3600) / 60);
        const s = Math.floor(seconds % 60);
        if (h > 0) {
            return `${h}:${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
        }
        return `${m}:${s.toString().padStart(2, '0')}`;
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
            let badgeCount = state ? state.getCompletionCount(rowTitle) : 0;
            if (badgeCount === 0 && isListened) badgeCount = 1;

            const statusContainer = row.querySelector('.status-container');
            if (statusContainer) {
                // Only rebuild if count changed
                if (statusContainer.childElementCount !== badgeCount) {
                    statusContainer.innerHTML = '';
                    for (let i = 0; i < badgeCount; i++) {
                        const badge = document.createElement('span');
                        badge.className = 'status-badge';
                        badge.innerText = '✓';
                        statusContainer.appendChild(badge);
                    }
                }
            }

            if (rowTitle === currentTitle) {
                // ACTIVE ROW
                row.classList.add('active');

                // Update Play Icon for this row
                const btn = row.querySelector('.list-play-btn');
                if (btn && isPlaying) {
                    btn.innerHTML = ICONS.pause;
                }
            } else {
                // INACTIVE ROW
                row.classList.remove('active');

                // If inactive AND listened:
                // Prior Logic: Add 'finished' (Solid Orange).
                // New Logic: Ensure width is 0% (Clean Gray).
                if (isListened) {
                    const fill = row.querySelector('.episode-progress-fill');
                    if (fill) fill.style.width = '0%';
                }
            }
        });
    }
};

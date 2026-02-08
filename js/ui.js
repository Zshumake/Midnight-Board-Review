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
    currentTimeLabel: document.getElementById('current-time'),
    durationLabel: document.getElementById('duration'),
    episodeList: document.getElementById('episode-list'),
    categoryTabs: document.getElementById('category-tabs'),
    trackDescription: document.getElementById('current-track-description'),
    reportBtn: document.getElementById('report-issue-btn'),

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
    loadingDisclaimer: document.getElementById('loading-disclaimer'),

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
     * Show/Hide Loading States
     */
    setLoading(isLoading) {
        if (this.loadingDisclaimer) {
            this.loadingDisclaimer.style.display = isLoading ? 'block' : 'none';
        }
        if (this.playBtn) {
            if (isLoading) this.playBtn.classList.add('loading');
            else this.playBtn.classList.remove('loading');
        }

        const activeRow = document.querySelector('.episode-item.active');
        if (activeRow) {
            const rowDisclaimer = activeRow.querySelector('.list-loading-disclaimer');
            if (rowDisclaimer) rowDisclaimer.style.display = isLoading ? 'block' : 'none';
        }
    },

    /**
     * Helper to create the badge container DOM
     */
    createBadgeContainer(count) {
        const container = document.createElement('div');
        container.className = 'status-container';

        if (count > 0) {
            const badgeRow = document.createElement('div');
            badgeRow.className = 'badge-row';

            for (let i = 0; i < count; i++) {
                const badge = document.createElement('span');
                badge.className = 'status-badge';
                badge.innerText = '✓';
                badgeRow.appendChild(badge);
            }
            container.appendChild(badgeRow);

            if (count >= 3) {
                const masterLabel = document.createElement('div');
                masterLabel.className = 'master-label';
                masterLabel.innerText = 'MASTER';
                container.appendChild(masterLabel);
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

        categories.forEach(cat => {
            const tab = document.createElement('div');
            tab.className = `category-tab pill ${activeCategory === cat ? 'active' : ''}`;
            tab.innerText = this.formatCategoryName(cat);
            tab.onclick = () => onSelect(cat);
            this.categoryTabs.appendChild(tab);
        });
    },

    /**
     * More descriptive names for Section Headers (h4)
     */
    formatCategoryHeader(cat) {
        if (!cat) return '';
        if (cat.includes('SCI')) return 'Spinal Cord Injury';
        if (cat.includes('TBI')) return 'Traumatic Brain Injury';
        if (cat.includes('CVA') || cat.includes('Cerebrovascular')) return 'Stroke';
        if (cat === 'Neurology: Miscellaneous') return 'Neuro: Misc';

        return cat.replace('Neurology:', 'Neuro:')
            .replace('Musculoskeletal:', 'MSK:');
    },

    /**
     * Shorten specific long category names for UI pills
     */
    formatCategoryName(cat) {
        if (!cat) return '';
        if (cat.includes('Upper Extremity')) return 'Upper Extremity';
        if (cat.includes('Lower Extremity')) return 'Lower Extremity';
        if (cat.startsWith('Musculoskeletal:')) return cat.replace('Musculoskeletal:', 'MSK:');
        if (cat.includes('TBI')) return 'TBI';
        if (cat.includes('SCI')) return 'SCI';
        if (cat.includes('CVA') || cat.includes('Cerebrovascular')) return 'CVA';
        if (cat === 'Neurology: Miscellaneous') return 'Neuro: Misc';
        if (cat.startsWith('Neurology:')) return cat.replace('Neurology:', 'Neuro:');
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
            const effectiveIndex = (ep.originalIndex !== undefined) ? ep.originalIndex : index;
            acc[ep.category].push({ ...ep, effectiveIndex });
            return acc;
        }, {});

        for (const [category, items] of Object.entries(groups)) {
            const groupDiv = document.createElement('div');
            groupDiv.className = 'category-group';

            const header = document.createElement('div');
            header.className = 'category-header-group';

            const title = document.createElement('h4');
            title.innerText = this.formatCategoryHeader(category);
            header.appendChild(title);
            groupDiv.appendChild(header);

            items.forEach(item => {
                const epDiv = document.createElement('div');
                epDiv.dataset.index = item.effectiveIndex;
                epDiv.dataset.title = item.title;

                const isFinished = state.isListened(item.title);
                const isActive = (item.effectiveIndex === activeIndex);
                const hasSearch = searchTerm && searchTerm.trim().length > 0;
                const isExpanded = hasSearch;

                epDiv.className = `episode-item ${isActive ? 'active' : ''} ${isExpanded ? 'expanded' : ''}`;

                // Progress Fill Overlay
                const progressFill = document.createElement('div');
                progressFill.className = 'episode-progress-fill';
                let percent = state.getProgressPercentage(item.title);
                progressFill.style.width = `${percent}%`;
                epDiv.appendChild(progressFill);

                const headerDiv = document.createElement('div');
                headerDiv.className = 'episode-header';

                const listPlayBtn = document.createElement('button');
                listPlayBtn.className = 'list-play-btn';
                listPlayBtn.innerHTML = (isActive && !this.audio.paused) ? ICONS.pause : ICONS.play;
                listPlayBtn.onclick = (e) => {
                    e.stopPropagation();
                    onEpisodeClick(item.effectiveIndex, 'play');
                };

                const listDisclaimer = document.createElement('div');
                listDisclaimer.className = 'list-loading-disclaimer';
                listDisclaimer.innerText = 'Loading Episode...';
                listDisclaimer.style.display = 'none';

                const titleSpan = document.createElement('span');
                titleSpan.className = 'episode-title-text';
                titleSpan.innerHTML = this.highlightText(item.title, searchTerm);

                const statusSpan = document.createElement('span');
                statusSpan.className = 'status-icon';
                let badgeCount = state.getCompletionCount(item.title);
                if (badgeCount === 0 && isFinished) badgeCount = 1;

                // Debug Log
                if (badgeCount > 0) console.log(`Rendering Badge for "${item.title}": ${badgeCount}`);

                if (badgeCount > 0) {
                    statusSpan.appendChild(this.createBadgeContainer(badgeCount));
                    statusSpan.classList.add('visible');
                } else {
                    statusSpan.classList.remove('visible');
                }

                headerDiv.appendChild(listPlayBtn);
                headerDiv.appendChild(listDisclaimer);
                headerDiv.appendChild(titleSpan);
                headerDiv.appendChild(statusSpan);

                const descDiv = document.createElement('div');
                descDiv.className = 'episode-description';
                descDiv.innerHTML = this.highlightText(item.description || 'No description available.', searchTerm);

                epDiv.appendChild(headerDiv);
                epDiv.appendChild(descDiv);

                epDiv.onclick = (e) => {
                    if (e.target.closest('.episode-description')) return;
                    const allExpanded = document.querySelectorAll('.episode-item.expanded');
                    allExpanded.forEach(el => { if (el !== epDiv) el.classList.remove('expanded'); });
                    epDiv.classList.toggle('expanded');
                };

                epDiv.addEventListener('contextmenu', (e) => {
                    e.preventDefault();
                    if (confirm(`Mark "${item.title}" as Mastered? 🏅\n(This will award 1 badge)`)) {
                        const event = new CustomEvent('manual-mastery', { detail: { title: item.title } });
                        document.dispatchEvent(event);
                    }
                });

                let hoverTimer = null;
                epDiv.addEventListener('mouseenter', () => {
                    if (onEpisodeHover) hoverTimer = setTimeout(() => onEpisodeHover(item.url), 200);
                });
                epDiv.addEventListener('mouseleave', () => {
                    if (hoverTimer) { clearTimeout(hoverTimer); hoverTimer = null; }
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
        let badgeCount = state.getCompletionCount(episode.title);
        if (badgeCount === 0 && isListened) badgeCount = 1;

        // Update Main Title
        this.title.innerHTML = '';
        this.title.appendChild(document.createTextNode(episode.title + ' '));
        if (badgeCount > 0) {
            const container = this.createBadgeContainer(badgeCount);
            container.style.display = 'inline-flex';
            container.style.marginLeft = '12px';
            container.style.verticalAlign = 'middle';
            this.title.appendChild(container);
        }

        // Update Sticky Player Title
        if (this.stickyTitle) {
            this.stickyTitle.innerHTML = '';
            this.stickyTitle.appendChild(document.createTextNode(episode.title + ' '));
            if (badgeCount > 0) {
                const stickyContainer = this.createBadgeContainer(badgeCount);
                stickyContainer.style.display = 'inline-flex';
                stickyContainer.style.marginLeft = '12px';
                stickyContainer.style.verticalAlign = 'middle';
                this.stickyTitle.appendChild(stickyContainer);
            }
        }

        if (this.stickyPlayer) this.stickyPlayer.classList.add('visible');

        if (this.trackDescription) {
            this.trackDescription.innerText = episode.description || 'No description available.';
        }

        // We use title here because updateTrack is global UI, not list-specific, 
        // but we'll try to find the row by title + index if possible.
        this.syncListStatus(episode.title, isListened);
    },

    /**
     * Efficiently sync status using title (global check)
     */
    syncListStatus(title, isListened) {
        const rows = document.querySelectorAll(`.episode-item[data-title="${title.replace(/"/g, '\\"')}"]`);
        rows.forEach(row => {
            const statusIcon = row.querySelector('.status-icon');
            if (!statusIcon) return;
            let badgeCount = state.getCompletionCount(title);
            if (badgeCount === 0 && isListened) badgeCount = 1;

            if (badgeCount > 0) console.log(`Syncing Badge for "${title}": ${badgeCount}`);

            statusIcon.innerHTML = '';
            if (badgeCount > 0) {
                statusIcon.appendChild(this.createBadgeContainer(badgeCount));
                statusIcon.classList.add('visible');
            } else {
                statusIcon.classList.remove('visible');
            }
        });
    },

    /**
     * Update the progress bar visually
     */
    updateProgress(currentTime, duration) {
        if (!duration) return;
        const percent = (currentTime / duration) * 100;
        this.progressBar.style.width = `${percent}%`;
        if (this.stickyProgressBar) this.stickyProgressBar.style.width = `${percent}%`;

        if (this.currentTimeLabel) this.currentTimeLabel.innerText = this.formatTime(currentTime);
        if (this.durationLabel) this.durationLabel.innerText = this.formatTime(duration);

        const activeItem = document.querySelector('.episode-item.active');
        if (activeItem) {
            const fill = activeItem.querySelector('.episode-progress-fill');
            if (fill) fill.style.width = `${percent}%`;
        }
    },

    /**
     * Highlight matching text in a string
     */
    highlightText(text, term) {
        if (!term || !term.trim()) return text;
        const escaped = term.trim().replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
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
        return h > 0 ? `${h}:${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}` : `${m}:${s.toString().padStart(2, '0')}`;
    },

    /**
     * Update play/pause button state
     */
    setPlaying(isPlaying) {
        const icon = isPlaying ? ICONS.pause : ICONS.play;
        this.playBtn.innerHTML = icon;
        if (this.stickyPlayBtn) this.stickyPlayBtn.innerHTML = icon;
    },

    /**
     * Update Icons and Active states using numeric index (The Shoulder Bug Fix)
     */
    updateListPlayStates(currentIndex, isPlaying, state) {
        const activeIdx = Number(currentIndex);
        const allRows = document.querySelectorAll('.episode-item');

        allRows.forEach(row => {
            const rowIdx = Number(row.dataset.index);
            const rowTitle = row.dataset.title;
            const isCurrent = (rowIdx === activeIdx);

            const btn = row.querySelector('.list-play-btn');
            if (btn) btn.innerHTML = (isCurrent && isPlaying) ? ICONS.pause : ICONS.play;

            if (isCurrent) {
                row.classList.add('active');
            } else {
                row.classList.remove('active');
                // Persist progress for non-active episodes
                const percent = state.getProgressPercentage(rowTitle);
                const fill = row.querySelector('.episode-progress-fill');
                if (fill) fill.style.width = `${percent}%`;

                const rowDisclaimer = row.querySelector('.list-loading-disclaimer');
                if (rowDisclaimer) rowDisclaimer.style.display = 'none';
            }
        });
    }
};

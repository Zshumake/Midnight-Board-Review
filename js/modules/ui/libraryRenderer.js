/**
 * LibraryRenderer.js
 * Handles the generation of the Episode List DOM.
 */

import { ICONS } from '../../icons.js';
import { state } from '../../state.js';

export const LibraryRenderer = {
    elements: {
        list: document.getElementById('episode-list'),
        audio: document.getElementById('audio'), // Still needed for paused check? Or pass in state?
        categoryTabs: document.getElementById('category-tabs'),
        searchInput: document.getElementById('search-input')
    },

    init(callbacks) {
        this.callbacks = callbacks || {}; // { onPlay, onHover, onClick }

        // Setup Search Listener
        if (this.elements.searchInput) {
            this.elements.searchInput.addEventListener('input', (e) => {
                if (this.callbacks.onSearch) this.callbacks.onSearch(e.target.value);
            });
        }
    },

    renderCategories(categories, activeCategory, onSelect) {
        if (!this.elements.categoryTabs) return;
        this.elements.categoryTabs.innerHTML = '';

        const allTab = document.createElement('div');
        allTab.className = `category-tab pill ${activeCategory === 'All' ? 'active' : ''}`;
        allTab.innerText = 'All';
        allTab.onclick = () => onSelect('All');
        this.elements.categoryTabs.appendChild(allTab);

        categories.forEach(cat => {
            const tab = document.createElement('div');
            tab.className = `category-tab pill ${activeCategory === cat ? 'active' : ''}`;
            tab.innerText = this._formatCategoryName(cat);
            tab.onclick = () => onSelect(cat);
            this.elements.categoryTabs.appendChild(tab);
        });
    },

    render(episodes, activeIndex, onEpisodeClick, onEpisodeHover, searchTerm = '') {
        if (!this.elements.list) return;
        this.elements.list.innerHTML = '';

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
            title.innerText = this._formatCategoryHeader(category);
            header.appendChild(title);
            groupDiv.appendChild(header);

            items.forEach(item => {
                const epDiv = this._createEpisodeItem(item, activeIndex, searchTerm, onEpisodeClick, onEpisodeHover);
                groupDiv.appendChild(epDiv);
            });
            this.elements.list.appendChild(groupDiv);
        }
    },

    updatePlayStates(activeIndex, isPlaying) {
        const allRows = document.querySelectorAll('.episode-item');
        allRows.forEach(row => {
            const rowIdx = Number(row.dataset.index);
            const isCurrent = (rowIdx === activeIndex);

            // Icon
            const btn = row.querySelector('.list-play-btn');
            if (btn) btn.innerHTML = (isCurrent && isPlaying) ? ICONS.pause : ICONS.play;

            // Active Class & Progress Line
            if (isCurrent) {
                row.classList.add('active');
            } else {
                row.classList.remove('active');
                // Ensure persistence for inactive rows
                const rowTitle = row.dataset.title;
                const percent = state.getProgressPercentage(rowTitle);
                const fill = row.querySelector('.episode-progress-fill');
                if (fill) fill.style.width = `${percent}%`;

                // Hide loading spinner if it was showing
                const spinner = row.querySelector('.list-loading-disclaimer');
                if (spinner) spinner.style.display = 'none';
            }
        });
    },

    _updateBadgeForTitle(title, count) {
        // Find row by title
        // Note: dataset.title values might need escaping in selector
        const safeTitle = title.replace(/"/g, '\\"');
        const rows = document.querySelectorAll(`.episode-item[data-title="${safeTitle}"]`);

        rows.forEach(row => {
            const statusSpan = row.querySelector('.status-icon');
            if (statusSpan) {
                statusSpan.innerHTML = '';
                if (count > 0) {
                    statusSpan.appendChild(this._createBadgeContainer(count));
                    statusSpan.classList.add('visible');
                } else {
                    statusSpan.classList.remove('visible');
                }
            }
        });
    },

    _createEpisodeItem(item, activeIndex, searchTerm, onEpisodeClick, onEpisodeHover) {
        const epDiv = document.createElement('div');
        epDiv.dataset.index = item.effectiveIndex;
        epDiv.dataset.title = item.title;

        const isFinished = state.isListened(item.title);
        const isActive = (item.effectiveIndex === activeIndex);
        const hasSearch = searchTerm && searchTerm.trim().length > 0;

        epDiv.className = `episode-item ${isActive ? 'active' : ''} ${hasSearch ? 'expanded' : ''}`;

        // Progress Fill
        const progressFill = document.createElement('div');
        progressFill.className = 'episode-progress-fill';
        let percent = state.getProgressPercentage(item.title);
        progressFill.style.width = `${percent}%`;
        epDiv.appendChild(progressFill);

        // Header
        const headerDiv = document.createElement('div');
        headerDiv.className = 'episode-header';

        const listPlayBtn = document.createElement('button');
        listPlayBtn.className = 'list-play-btn';
        // Note: Initial render state might be inaccurate regarding global play/pause, 
        // relying on updatePlayStates to fix it immediately after or caller to handle.
        listPlayBtn.innerHTML = ICONS.play;
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
        titleSpan.innerHTML = this._highlightText(item.title, searchTerm);

        // Status / Badges
        const statusSpan = document.createElement('span');
        statusSpan.className = 'status-icon';
        let badgeCount = state.getCompletionCount(item.title);
        if (badgeCount === 0 && isFinished) badgeCount = 1;

        if (badgeCount > 0) {
            statusSpan.appendChild(this._createBadgeContainer(badgeCount));
            statusSpan.classList.add('visible');
        }

        headerDiv.appendChild(listPlayBtn);
        headerDiv.appendChild(listDisclaimer);
        headerDiv.appendChild(titleSpan);
        headerDiv.appendChild(statusSpan);

        // Description
        const descDiv = document.createElement('div');
        descDiv.className = 'episode-description';
        descDiv.innerHTML = this._highlightText(item.description || 'No description available.', searchTerm);

        epDiv.appendChild(headerDiv);
        epDiv.appendChild(descDiv);

        // Interaction
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

        return epDiv;
    },

    _createBadgeContainer(count) {
        const container = document.createElement('div');
        container.className = 'status-container';
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
        return container;
    },

    _formatCategoryHeader(cat) {
        if (!cat) return '';
        if (cat.includes('SCI')) return 'Spinal Cord Injury';
        if (cat.includes('TBI')) return 'Traumatic Brain Injury';
        if (cat.includes('CVA') || cat.includes('Cerebrovascular')) return 'Stroke';
        if (cat === 'Neurology: Miscellaneous') return 'Neuro: Misc';
        return cat.replace('Neurology:', 'Neuro:').replace('Musculoskeletal:', 'MSK:');
    },

    _formatCategoryName(cat) {
        if (!cat) return '';
        if (cat.includes('Upper Extremity')) return 'Upper Extremity';
        if (cat.includes('Lower Extremity')) return 'Lower Extremity';
        if (cat.startsWith('Musculoskeletal:')) return cat.replace('Musculoskeletal:', 'MSK:');
        if (cat.includes('TBI')) return 'TBI';
        if (cat.includes('SCI')) return 'SCI';
        if (cat.includes('CVA')) return 'CVA';
        if (cat === 'Neurology: Miscellaneous') return 'Neuro: Misc';
        if (cat.startsWith('Neurology:')) return cat.replace('Neurology:', 'Neuro:');
        if (cat.includes('Cardiopulmonary')) return 'Cancer/Pulm/Cardiac';
        if (cat.includes('Electrodiagnostic')) return 'EDX';
        if (cat.includes('Prosthetics')) return 'P&O';
        return cat;
    },

    _highlightText(text, term) {
        if (!term || !term.trim()) return text;
        const escaped = term.trim().replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
        const regex = new RegExp(`(${escaped})`, 'gi');
        return text.replace(regex, '<mark class="highlight">$1</mark>');
    }
};

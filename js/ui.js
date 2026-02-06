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

                epDiv.innerHTML = `
                    <span>${item.title}</span>
                    <span class="status-icon">${listened ? '✓' : ''}</span>
                `;

                epDiv.onclick = () => onEpisodeClick(item.effectiveIndex);
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
        this.playBtn.innerText = isPlaying ? '⏸' : '▶';
    }
};

/**
 * Library Module
 * Handles Category Logic and Episode Filtering
 */

export const Library = {
    activeCategory: 'All',

    /**
     * Initialize Category Tabs
     */
    initCategories(episodes, ui, onFilterChange) {
        // Extract Unique Categories (remove null/empty)
        const categories = ['All', ...new Set(episodes.map(e => e.category))].filter(Boolean);

        // Initial Render
        ui.renderCategoryTabs(categories, this.activeCategory, (selected) => {
            this.activeCategory = selected;
            // Update Tab UI
            ui.renderCategoryTabs(categories, this.activeCategory, (cat) => this.activeCategory = cat);
            // Trigger Filter Callback
            onFilterChange();
        });
    },

    /**
     * Filter Episodes based on Search and Active Category
     */
    filterEpisodes(episodes, searchTerm = '') {
        return episodes
            .map((ep, index) => ({ ...ep, originalIndex: index }))
            .filter(ep => {
                // 1. Category Filter
                if (this.activeCategory !== 'All' && ep.category !== this.activeCategory) return false;

                // 2. Search Filter
                const term = searchTerm.toLowerCase();
                return ep.title.toLowerCase().includes(term) ||
                    ep.category.toLowerCase().includes(term) ||
                    (ep.description && ep.description.toLowerCase().includes(term));
            });
    }
};

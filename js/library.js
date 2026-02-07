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

        // Define Handler to be used recursively
        const handleSelect = (selected) => {
            this.activeCategory = selected;
            // Update Tab UI (Pass SAME handler)
            ui.renderCategoryTabs(categories, this.activeCategory, handleSelect);
            // Trigger Filter Callback
            onFilterChange();
        };

        // Initial Render
        ui.renderCategoryTabs(categories, this.activeCategory, handleSelect);
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

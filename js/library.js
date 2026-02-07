import { SearchEngine } from './modules/searchEngine.js';

export const Library = {
    activeCategory: 'All',

    /**
     * Initialize Category Tabs
     */
    initCategories(episodes, ui, onFilterChange) {
        if (!ui.categoryTabs) return;

        // Extract Unique Categories
        const categories = ['All', ...new Set(episodes.map(e => e.category))].filter(Boolean);

        // Define Handler to be used recursively
        const handleSelect = (selected) => {
            this.activeCategory = selected;
            // Update Tab UI
            ui.renderCategoryTabs(categories, this.activeCategory, handleSelect);
            // Trigger Filter Callback (which usually calls renderLibrary)
            onFilterChange();
        };

        // Initial Render
        ui.renderCategoryTabs(categories, this.activeCategory, handleSelect);
    },

    /**
     * Filter Episodes based on Search and Active Category using modular SearchEngine
     */
    filterEpisodes(episodes, searchTerm = '') {
        return SearchEngine.filter(episodes, this.activeCategory, searchTerm);
    }
};

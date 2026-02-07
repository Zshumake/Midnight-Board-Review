import { SYNONYMS } from './modules/synonyms.js';

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
        const term = searchTerm.toLowerCase().trim();

        // Expansion: If the term is a known synonym key, add the expansion to search space.
        // e.g. "tbi" -> searches for "tbi" OR "traumatic brain injury"
        const expansion = SYNONYMS[term] || "";

        return episodes
            .map((ep, index) => ({ ...ep, originalIndex: index }))
            .filter(ep => {
                // 1. Category Filter
                if (this.activeCategory !== 'All' && ep.category !== this.activeCategory) return false;

                // 2. Search Filter
                if (!term) return true;

                const searchSpace = `${ep.title} ${ep.category} ${ep.description || ''}`.toLowerCase();

                return searchSpace.includes(term) || (expansion && searchSpace.includes(expansion));
            });
    }
};

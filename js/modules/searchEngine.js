import { SYNONYMS } from './synonyms.js';

export const SearchEngine = {
    /**
     * Filter episodes based on category and search term.
     * @param {Array} episodes - The full list of episodes.
     * @param {string} activeCategory - The current active category filter.
     * @param {string} searchTerm - The user's search string.
     * @returns {Array} - The filtered and indexed episodes.
     */
    filter(episodes, activeCategory, searchTerm = '') {
        const term = searchTerm.toLowerCase().trim();
        const expansion = SYNONYMS[term] || "";

        return episodes
            .map((ep, index) => ({ ...ep, originalIndex: index }))
            .filter(ep => {
                // 1. Category Filter
                if (activeCategory !== 'All' && ep.category !== activeCategory) return false;

                // 2. Search Filter
                if (!term) return true;

                const searchSpace = `${ep.title} ${ep.category} ${ep.description || ''}`.toLowerCase();

                // Match original term OR expansion (synonym)
                return searchSpace.includes(term) || (expansion && searchSpace.includes(expansion));
            });
    }
};

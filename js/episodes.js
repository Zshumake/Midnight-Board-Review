import { pmrSeries } from './series/pmr_board_review.js';

// Aggregate all series here.
// When adding a new book/series:
// 1. Create a new file in js/series/ (e.g., new_book.js)
// 2. Import it here
// 3. Add it to the allSeries array

const allSeries = [
    pmrSeries,
    // futureSeries1,
    // futureSeries2
];

// Flatten all episodes into a single list for the player, 
// or keep them separate if we want series selection later.
// For now, flattening to maintain current functionality.

export const episodes = allSeries.flatMap(series => series.episodes);

export const seriesMetadata = allSeries.map(s => ({
    id: s.id,
    title: s.title,
    author: s.author
}));

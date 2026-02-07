import { episodes } from './js/episodes.js';
import fs from 'fs';

// Export the aggregated episodes list to a static JSON file
fs.writeFileSync('./js/modules/episodes.json', JSON.stringify(episodes, null, 2));
console.log('Successfully exported episodes to episodes.json');

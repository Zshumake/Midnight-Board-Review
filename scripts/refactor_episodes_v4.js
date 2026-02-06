const fs = require('fs');

// Read the current episodes.js file
let epFileContent = fs.readFileSync('js/episodes.js', 'utf8');

// regex capture existing data
const extractedEpisodes = [];
const regex = /{ title: "(.*?)", url: "(.*?)", category: "(.*?)", description: descriptions\["(.*?)"\] },?/;

const lines = epFileContent.split('\n');
for (let line of lines) {
    const match = line.match(regex);
    if (match) {
        extractedEpisodes.push({
            title: match[1],
            url: match[2],
            currentCategory: match[3],
            descriptionKey: match[4]
        });
    }
}

// Helper to determine sort order for Lower Extremity
// Desired: Hip -> Knee -> Lower Leg -> Ankle -> Foot
function getLowerExtremitySortIndex(title) {
    const t = title.toLowerCase();
    if (t.includes('hip')) return 1;
    if (t.includes('knee')) return 2;
    if (t.includes('lower leg')) return 3;
    if (t.includes('ankle')) return 4;
    if (t.includes('foot')) return 5;
    return 10;
}

// Helper for Upper Extremity
// Desired: Shoulder -> Elbow -> Wrist/Hand -> Spine
function getUpperExtremitySortIndex(title) {
    const t = title.toLowerCase();
    if (t.includes('shoulder')) return 1;
    if (t.includes('elbow')) return 2;
    if (t.includes('wrist') || t.includes('hand')) return 3; // Group Wrist/Hand together?
    if (t.includes('spine')) return 4;
    return 10;
}

// Helper for Neuro Group (CVA first)
function getNeuroSortIndex(title) {
    const t = title.toLowerCase();
    if (t.includes('stroke') || t.includes('cerebrovascular')) return 1;
    if (t.includes('multiple sclerosis')) return 2;
    if (t.includes('spasticity')) return 3;
    return 10;
}

// Helper for Cardiopulmonary/Cancer (Cancer -> Cardiac -> Pulmonary)
function getCardioSortIndex(title) {
    const t = title.toLowerCase();
    if (t.includes('cancer')) return 1;
    if (t.includes('cardiac')) return 2;
    if (t.includes('pulmonary')) return 3;
    return 10;
}


// New Category Logic
function getNewCategory(title) {
    const t = title.toLowerCase();

    // 1. Miscellaneous (Bioethics, Biostats, Board Exam, Osteoporosis, Physical Modalities)
    if (t.includes('bioethics') || t.includes('biostatistics') || t.includes('board exam') ||
        t.includes('osteoporosis') || t.includes('physical modalities')) {
        return "Miscellaneous";
    }

    // 2. Musculoskeletal: Lower Extremity
    if (t.includes('hip') || t.includes('knee') || t.includes('ankle') || t.includes('foot') || t.includes('lower leg')) {
        return "Musculoskeletal: Lower Extremity";
    }

    // 3. Musculoskeletal: Upper Extremity & Spine
    if (t.includes('shoulder') || t.includes('elbow') || t.includes('wrist') || t.includes('hand') || t.includes('spine')) {
        return "Musculoskeletal: Upper Extremity & Spine";
    }

    // 4. Neurology: Brain & Spasticity
    if (t.includes('multiple sclerosis') || t.includes('spasticity') || t.includes('stroke') || t.includes('cva')) {
        return "Neurology: Brain & Spasticity";
    }

    // 5. Neurology: TBI
    if (t.includes('traumatic brain injury')) {
        return "Neurology: TBI";
    }

    // 6. Neurology: SCI
    if (t.includes('spinal cord injury')) {
        return "Neurology: SCI";
    }

    // 7. Prosthetics & Orthotics (Wheelchair included)
    if (t.includes('prosthetics') || t.includes('wheelchair') || t.includes('orthotics')) { // "Prosthetics & Orthotics" covers P&O
        return "Prosthetics & Orthotics";
    }

    // 8. Cardiopulmonary & Cancer Rehabilitation
    if (t.includes('burns')) {
        // User didn't explicitly move Burns to Cardio/Cancer, but listed Cancer/Pulm/Cardiac together.
        // Burns usually goes with Specialized.
        // Wait, user said "Cancer, Pulmonary and Cardiac section".
        // Where does Burns go?
        // User didn't mention Burns in the "move to Misc" or "move to Neuro".
        // Let's keep it in "Specialized Rehab" or its own group?
        // Or maybe "Specialized Rehab: Burns"?
        // Let's create a separate group "Burns" as it's an orphan now if not in Misc.
        // Or put in Misc? No, it's clinical.
        // I'll leave it as "Burns Rehabilitation".
        return "Burns Rehabilitation";
    }
    if (t.includes('cancer') || t.includes('cardiac') || t.includes('pulmonary')) {
        return "Cardiopulmonary & Cancer Rehabilitation";
    }

    // 9. Electrodiagnostic Medicine
    if (t.includes('electrodiagnostic')) {
        return "Electrodiagnostic Medicine (EDX)";
    }

    // 10. Pediatrics
    if (t.includes('pediatrics')) {
        return "Pediatrics";
    }

    // 11. Pain Medicine
    if (t.includes('pain')) {
        return "Pain Medicine";
    }

    // 12. Rheumatology
    if (t.includes('rheumatology')) {
        return "Rheumatology";
    }

    return "General";
}

// Process titles (Renaming Logic)
function getNewTitle(title) {
    if (title.startsWith('Stroke')) {
        return title.replace('Stroke', 'Cerebrovascular Accident');
    }
    if (title.startsWith('Pulmonary') && !title.includes('Rehab')) {
        // User said "Make pulmonary be pulmonary rehab"
        // If already "Pulmonary Rehab", fine.
        // My current titles are "Pulmonary 1", "Pulmonary 2", "Pulmonary 3".
        // Rename to "Pulmonary Rehab 1", etc.
        return title.replace('Pulmonary', 'Pulmonary Rehab');
    }
    return title;
}

// Prepare items
let items = extractedEpisodes.map(ep => {
    return {
        ...ep,
        title: getNewTitle(ep.title),
        category: getNewCategory(ep.title)
    };
});

// Sort items within categories
// We need a stable sort for the whole list, but grouped by category.
// Let's group them first.
const groups = {};
items.forEach(item => {
    if (!groups[item.category]) groups[item.category] = [];
    groups[item.category].push(item);
});

// Sort inside specific groups
if (groups["Musculoskeletal: Lower Extremity"]) {
    groups["Musculoskeletal: Lower Extremity"].sort((a, b) => {
        const scoreA = getLowerExtremitySortIndex(a.title);
        const scoreB = getLowerExtremitySortIndex(b.title);
        if (scoreA !== scoreB) return scoreA - scoreB;
        return a.title.localeCompare(b.title, undefined, { numeric: true });
    });
}

if (groups["Musculoskeletal: Upper Extremity & Spine"]) {
    groups["Musculoskeletal: Upper Extremity & Spine"].sort((a, b) => {
        const scoreA = getUpperExtremitySortIndex(a.title);
        const scoreB = getUpperExtremitySortIndex(b.title);
        if (scoreA !== scoreB) return scoreA - scoreB;
        return a.title.localeCompare(b.title, undefined, { numeric: true });
    });
}

if (groups["Neurology: Brain & Spasticity"]) {
    groups["Neurology: Brain & Spasticity"].sort((a, b) => {
        const scoreA = getNeuroSortIndex(a.title);
        const scoreB = getNeuroSortIndex(b.title);
        if (scoreA !== scoreB) return scoreA - scoreB;
        return a.title.localeCompare(b.title, undefined, { numeric: true });
    });
}

if (groups["Cardiopulmonary & Cancer Rehabilitation"]) {
    groups["Cardiopulmonary & Cancer Rehabilitation"].sort((a, b) => {
        const scoreA = getCardioSortIndex(a.title);
        const scoreB = getCardioSortIndex(b.title);
        if (scoreA !== scoreB) return scoreA - scoreB;
        return a.title.localeCompare(b.title, undefined, { numeric: true });
    });
}

// Rebuild the main list order based on category priority?
// Or just iterate standard categories.

// Define Category Order
const catOrder = [
    "Musculoskeletal: Upper Extremity & Spine",
    "Musculoskeletal: Lower Extremity",
    "Neurology: Brain & Spasticity",
    "Neurology: TBI",
    "Neurology: SCI",
    "Electrodiagnostic Medicine (EDX)",
    "Pediatrics",
    "Prosthetics & Orthotics",
    "Cardiopulmonary & Cancer Rehabilitation",
    "Burns Rehabilitation",
    "Pain Medicine",
    "Rheumatology",
    "Miscellaneous"
];

// Flatten back to list
const finalEpisodes = [];
catOrder.forEach(cat => {
    if (groups[cat]) {
        // Sort others alphanumerically if not already sorted
        if (!["Musculoskeletal: Lower Extremity", "Musculoskeletal: Upper Extremity & Spine", "Neurology: Brain & Spasticity", "Cardiopulmonary & Cancer Rehabilitation"].includes(cat)) {
            groups[cat].sort((a, b) => a.title.localeCompare(b.title, undefined, { numeric: true }));
        }
        finalEpisodes.push(...groups[cat]);
    }
});

// Output
let newEpContent = `import { descriptions } from './descriptions.js';\n\nexport const episodes = [\n`;
finalEpisodes.forEach(ep => {
    // Need to update the descriptionMap key if the title changed?
    // No, the map key in descriptions.js matches the OLD title because we didn't rewrite descriptions.js.
    // So we must use the original descriptionKey.
    // The 'title' field in episodes.js will be the NEW display title.
    // The description lookup uses the OLD key.
    newEpContent += `    { title: "${ep.title}", url: "${ep.url}", category: "${ep.category}", description: descriptions["${ep.descriptionKey}"] },\n`;
});
newEpContent += `];\n`;

fs.writeFileSync('js/episodes.js', newEpContent);
console.log('Updated js/episodes.js with v4 categories and sorting');

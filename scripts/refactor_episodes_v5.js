const fs = require('fs');

// Read the current episodes.js file (already has v4 categories, but we re-process titles)
// Actually, v4 script renamed Stroke -> CVA. So if we run v5 on the OUTPUT of v4, titles are already changed.
// We should rely on the v4 logic but just change the category function.
// Let's copy v4 logic but fix the Physical Modalities part.

let epFileContent = fs.readFileSync('js/episodes.js', 'utf8');

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

// Order Helpers (Same as v4)
function getLowerExtremitySortIndex(title) {
    const t = title.toLowerCase();
    if (t.includes('hip')) return 1;
    if (t.includes('knee')) return 2;
    if (t.includes('lower leg')) return 3;
    if (t.includes('ankle')) return 4;
    if (t.includes('foot')) return 5;
    return 10;
}

function getUpperExtremitySortIndex(title) {
    const t = title.toLowerCase();
    if (t.includes('shoulder')) return 1;
    if (t.includes('elbow')) return 2;
    if (t.includes('wrist') || t.includes('hand')) return 3;
    if (t.includes('spine')) return 4;
    return 10;
}

function getNeuroSortIndex(title) {
    const t = title.toLowerCase();
    if (t.includes('stroke') || t.includes('cerebrovascular')) return 1;
    if (t.includes('multiple sclerosis')) return 2;
    if (t.includes('spasticity')) return 3;
    return 10;
}

function getCardioSortIndex(title) {
    const t = title.toLowerCase();
    if (t.includes('cancer')) return 1;
    if (t.includes('cardiac')) return 2;
    if (t.includes('pulmonary')) return 3;
    return 10;
}

// Updated Category Logic (v5)
function getNewCategory(title) {
    const t = title.toLowerCase();

    // 1. Physical Modalities (Explicitly separate now)
    if (t.includes('physical modalities')) {
        return "Physical Modalities";
    }

    // 2. Miscellaneous (Bioethics, Biostats, Board Exam, Osteoporosis)
    // Removed Physical Modalities from here
    if (t.includes('bioethics') || t.includes('biostatistics') || t.includes('board exam') ||
        t.includes('osteoporosis')) {
        return "Miscellaneous";
    }

    // 3. Musculoskeletal: Lower Extremity
    if (t.includes('hip') || t.includes('knee') || t.includes('ankle') || t.includes('foot') || t.includes('lower leg')) {
        return "Musculoskeletal: Lower Extremity";
    }

    // 4. Musculoskeletal: Upper Extremity & Spine
    if (t.includes('shoulder') || t.includes('elbow') || t.includes('wrist') || t.includes('hand') || t.includes('spine')) {
        return "Musculoskeletal: Upper Extremity & Spine";
    }

    // 5. Neurology: Brain & Spasticity
    if (t.includes('multiple sclerosis') || t.includes('spasticity') || t.includes('stroke') || t.includes('cerebrovascular')) {
        return "Neurology: Brain & Spasticity";
    }

    // 6. Neurology: TBI
    if (t.includes('traumatic brain injury')) {
        return "Neurology: TBI";
    }

    // 7. Neurology: SCI
    if (t.includes('spinal cord injury')) {
        return "Neurology: SCI";
    }

    // 8. Prosthetics & Orthotics
    if (t.includes('prosthetics') || t.includes('wheelchair') || t.includes('orthotics')) {
        return "Prosthetics & Orthotics";
    }

    // 9. Cardiopulmonary & Cancer Rehabilitation
    if (t.includes('cancer') || t.includes('cardiac') || t.includes('pulmonary')) {
        return "Cardiopulmonary & Cancer Rehabilitation";
    }

    // 10. Burns
    if (t.includes('burns')) {
        return "Burns Rehabilitation";
    }

    // 11. Electrodiagnostic Medicine
    if (t.includes('electrodiagnostic')) {
        return "Electrodiagnostic Medicine (EDX)";
    }

    // 12. Pediatrics
    if (t.includes('pediatrics')) {
        return "Pediatrics";
    }

    // 13. Pain Medicine
    if (t.includes('pain')) {
        return "Pain Medicine";
    }

    // 14. Rheumatology
    if (t.includes('rheumatology')) {
        return "Rheumatology";
    }

    return "General";
}

// Apply Logic
let items = extractedEpisodes.map(ep => {
    return {
        ...ep,
        category: getNewCategory(ep.title) // Title is already renamed (CVA) from previous run, or we should re-check rename?
        // Note: In v4 we renamed Stroke -> Cerebrovascular Accident.
        // If we run this on v4 output, title is already 'Cerebrovascular Accident 1'.
        // getNewCategory checks for 'cerebrovascular' so it should work.
    };
});

// Grouping and Sort
const groups = {};
items.forEach(item => {
    if (!groups[item.category]) groups[item.category] = [];
    groups[item.category].push(item);
});

// Apply Sorts existing in v4
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

// Category Order
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
    "Physical Modalities", // New separate spot
    "Miscellaneous"
];

// Rebuild List
const finalEpisodes = [];
catOrder.forEach(cat => {
    if (groups[cat]) {
        // Sort others alphanumerically
        if (!["Musculoskeletal: Lower Extremity", "Musculoskeletal: Upper Extremity & Spine", "Neurology: Brain & Spasticity", "Cardiopulmonary & Cancer Rehabilitation"].includes(cat)) {
            groups[cat].sort((a, b) => a.title.localeCompare(b.title, undefined, { numeric: true }));
        }
        finalEpisodes.push(...groups[cat]);
    }
});

let newEpContent = `import { descriptions } from './descriptions.js';\n\nexport const episodes = [\n`;
finalEpisodes.forEach(ep => {
    newEpContent += `    { title: "${ep.title}", url: "${ep.url}", category: "${ep.category}", description: descriptions["${ep.descriptionKey}"] },\n`;
});
newEpContent += `];\n`;

fs.writeFileSync('js/episodes.js', newEpContent);
console.log('Updated js/episodes.js with v5 categories (Phy Modalities separate)');

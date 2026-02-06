const fs = require('fs');

// Read the current episodes.js file
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

// Order Helpers (Same as previous)
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

function getCardioSortIndex(title) {
    const t = title.toLowerCase();
    if (t.includes('cancer')) return 1;
    if (t.includes('cardiac')) return 2;
    if (t.includes('pulmonary')) return 3;
    return 10;
}

// Updated Category Logic (v6)
function getNewCategory(title) {
    const t = title.toLowerCase();

    // 1. Physical Modalities
    if (t.includes('physical modalities')) {
        return "Physical Modalities";
    }

    // 2. Miscellaneous
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

    // 5. Neurology: Cerebrovascular Accident (CVA)
    // Separate CVA from others
    if (t.includes('stroke') || t.includes('cerebrovascular')) {
        return "Neurology: Cerebrovascular Accident (CVA)";
    }

    // 6. Neurology: TBI
    if (t.includes('traumatic brain injury')) {
        return "Neurology: TBI";
    }

    // 7. Neurology: SCI
    if (t.includes('spinal cord injury')) {
        return "Neurology: SCI";
    }

    // 8. Neurology: Miscellaneous (MS & Spasticity)
    if (t.includes('on multiple sclerosis') || t.includes('multiple sclerosis') || t.includes('spasticity')) {
        return "Neurology: Miscellaneous";
    }

    // 9. Prosthetics & Orthotics
    if (t.includes('prosthetics') || t.includes('wheelchair') || t.includes('orthotics')) {
        return "Prosthetics & Orthotics";
    }

    // 10. Cardiopulmonary & Cancer Rehabilitation
    if (t.includes('cancer') || t.includes('cardiac') || t.includes('pulmonary')) {
        return "Cardiopulmonary & Cancer Rehabilitation";
    }

    // 11. Burns
    if (t.includes('burns')) {
        return "Burns Rehabilitation";
    }

    // 12. Electrodiagnostic Medicine
    if (t.includes('electrodiagnostic')) {
        return "Electrodiagnostic Medicine (EDX)";
    }

    // 13. Pediatrics
    if (t.includes('pediatrics')) {
        return "Pediatrics";
    }

    // 14. Pain Medicine
    if (t.includes('pain')) {
        return "Pain Medicine";
    }

    // 15. Rheumatology
    if (t.includes('rheumatology')) {
        return "Rheumatology";
    }

    return "General";
}

// Apply Logic
let items = extractedEpisodes.map(ep => {
    return {
        ...ep,
        category: getNewCategory(ep.title)
    };
});

// Grouping and Sort
const groups = {};
items.forEach(item => {
    if (!groups[item.category]) groups[item.category] = [];
    groups[item.category].push(item);
});

// Apply Sorts
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
if (groups["Cardiopulmonary & Cancer Rehabilitation"]) {
    groups["Cardiopulmonary & Cancer Rehabilitation"].sort((a, b) => {
        const scoreA = getCardioSortIndex(a.title);
        const scoreB = getCardioSortIndex(b.title);
        if (scoreA !== scoreB) return scoreA - scoreB;
        return a.title.localeCompare(b.title, undefined, { numeric: true });
    });
}

// Category Order
// User wants Neuro Misc "below" the others. Assuming Standard Neuro Top -> Bottom.
// Typically TBI/SCI/CVA are big 3.
// Let's do: Brain (TBI/CVA) -> Cord (SCI) -> Misc. Or alphabetical.
// User listed: TBI, CVA, SCI.
// I'll group them: TBI, CVA, SCI, Misc.
const catOrder = [
    "Musculoskeletal: Upper Extremity & Spine",
    "Musculoskeletal: Lower Extremity",
    "Neurology: TBI",
    "Neurology: Cerebrovascular Accident (CVA)",
    "Neurology: SCI",
    "Neurology: Miscellaneous", // MS & Spasticity
    "Electrodiagnostic Medicine (EDX)",
    "Pediatrics",
    "Prosthetics & Orthotics",
    "Cardiopulmonary & Cancer Rehabilitation",
    "Burns Rehabilitation",
    "Pain Medicine",
    "Rheumatology",
    "Physical Modalities",
    "Miscellaneous"
];

// Rebuild List
const finalEpisodes = [];
catOrder.forEach(cat => {
    if (groups[cat]) {
        // Sort others alphanumerically
        if (!["Musculoskeletal: Lower Extremity", "Musculoskeletal: Upper Extremity & Spine", "Cardiopulmonary & Cancer Rehabilitation"].includes(cat)) {
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
console.log('Updated js/episodes.js with v6 categories (Neuro Misc separate)');

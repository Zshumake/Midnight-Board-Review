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

// Category Logic v3
function getNewCategory(title) {
    const t = title.toLowerCase();

    // 1. Miscellaneous
    if (t.includes('bioethics') || t.includes('biostatistics') || t.includes('board exam')) {
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

    // 4. Neurology: MS & Spasticity
    if (t.includes('multiple sclerosis') || t.includes('spasticity')) {
        return "Neurology: MS & Spasticity";
    }

    // 5. Neurology: Stroke
    if (t.includes('stroke') || t.includes('cva')) {
        return "Neurology: Stroke";
    }

    // 6. Neurology: TBI
    if (t.includes('traumatic brain injury')) {
        return "Neurology: TBI";
    }

    // 7. Neurology: SCI
    if (t.includes('spinal cord injury')) {
        return "Neurology: SCI";
    }

    // 8. Prosthetics, Orthotics & Wheelchairs
    if (t.includes('prosthetics & orthotics') || t.includes('wheelchair')) {
        return "Prosthetics, Orthotics & Wheelchairs";
    }

    // 9. Specialized Rehab (Burns, Cancer)
    if (t.includes('burns') || t.includes('cancer')) {
        return "Specialized Rehab (Burns & Cancer)";
    }

    // 10. Cardiopulmonary Rehabilitation
    if (t.includes('cardiac') || t.includes('pulmonary')) {
        return "Cardiopulmonary Rehabilitation";
    }

    // 11. Electrodiagnostic Medicine
    if (t.includes('electrodiagnostic')) {
        return "Electrodiagnostic Medicine (EDX)";
    }

    // 12. Peds
    if (t.includes('pediatrics')) {
        return "Pediatrics";
    }

    // 13. Pain
    if (t.includes('pain')) {
        return "Pain Medicine";
    }

    // 14. Rheumatology
    if (t.includes('rheumatology')) {
        return "Rheumatology";
    }

    // 15. Physical Modalities
    if (t.includes('physical modalities')) {
        return "Physical Modalities";
    }

    // 16. Osteoporosis (Neurology?)
    if (t.includes('osteoporosis')) {
        return "Osteoporosis";
    }

    return "General";
}

let newEpContent = `import { descriptions } from './descriptions.js';\n\nexport const episodes = [\n`;

extractedEpisodes.forEach(ep => {
    const newCat = getNewCategory(ep.title);
    newEpContent += `    { title: "${ep.title}", url: "${ep.url}", category: "${newCat}", description: descriptions["${ep.descriptionKey}"] },\n`;
});

newEpContent += `];\n`;

fs.writeFileSync('js/episodes.js', newEpContent);
console.log('Updated js/episodes.js with v3 categories');

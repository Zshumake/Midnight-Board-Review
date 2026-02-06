const fs = require('fs');

// Read the current episodes.js file which ALREADY has descriptions injected
let epFileContent = fs.readFileSync('js/episodes.js', 'utf8');

// We need to parse this file. Since it is 'export const episodes = [...]', we can try to eval it or regex it.
// Eval is risky if not clean JSON, but we can try to strip the export.
// Actually, regex extraction is safer for this format.

// Helper to extract objects
const episodes = [];
const lines = epFileContent.split('\n');
let currentObj = null;

for (let line of lines) {
    line = line.trim();
    if (line.startsWith('{')) {
        // Simple single line check
        if (line.endsWith('},')) {
            try {
                // Make it JSON-like
                let jsonStr = line.replace(/title:/, '"title":')
                    .replace(/url:/, '"url":')
                    .replace(/category:/, '"category":')
                    .replace(/description:/, '"description":')
                    .replace(/,$/, '');
                // Handle quotes inside string values... this is tricky with robust descriptions.
                // let's rely on node module evaluation?
            } catch (e) { }
        }
    }
}

// Better approach: Let's use the node runtime to require the file!
// But it is ES module. We can write a wrapper.
// Or just regex capture.

// "title": "(.*?)", "url": "(.*?)", "category": "(.*?)", (optional "description": "(.*?)")
// The description might have escaped quotes.

// Actually, I can just use the descriptions from my previous map in 'Podcast descriptions.txt' 
// and the list of titles from episodes.js?
// No, I need the descriptions I already verified.
// Let's use basic string parsing.

const extractedEpisodes = [];
const regex = /{ title: "(.*?)", url: "(.*?)", category: "(.*?)",?(?: description: "(.*?)")? },?/;

for (let line of lines) {
    const match = line.match(regex);
    if (match) {
        extractedEpisodes.push({
            title: match[1],
            url: match[2],
            originalCategory: match[3],
            description: match[4] || "" // Capture group 4 might be undefined
        });
    }
}

// Now we have the data.
// Let's build descriptions map.
const descriptionsMap = {};
extractedEpisodes.forEach(ep => {
    // Unescape quotes if needed (the regex captured the raw string inside quotes)
    // In the file, quotes were escaped as \".
    // We want the clean string for descriptions.js, and we will export it as string literal.
    if (ep.description) {
        descriptionsMap[ep.title] = ep.description;
    }
});

// Write js/descriptions.js
let descFileContent = `export const descriptions = {\n`;
for (const [title, desc] of Object.entries(descriptionsMap)) {
    // We need to escape double quotes for the file content
    // ensure backslashes are preserved? The regex captured raw characters. 
    // If original line was: description: "Foo \"bar\" baz"
    // Match[4] is: Foo \"bar\" baz
    // So distinct characters are: F o o (space) \ " b a r \ " ...
    // So checks out.
    descFileContent += `    "${title}": "${desc}",\n`;
}
descFileContent += `};\n`;
fs.writeFileSync('js/descriptions.js', descFileContent);
console.log('Created js/descriptions.js');


// Now rebuild episodes.js with new categories
// Category Logic
function getNewCategory(title) {
    const t = title.toLowerCase();

    // 1. Lower Extremity & General Clinical (Ankle, Biostats, Hip)
    if (t.includes('ankle') || t.includes('biostatistics') || t.includes('hip')) {
        return "Lower Extremity & General Clinical";
    }

    // 2. Burns & Cancer Rehabilitation (Burns, Cancer)
    if (t.includes('burns') || t.includes('cancer')) {
        return "Burns & Cancer Rehabilitation";
    }

    // 3. Cardiac Rehabilitation
    if (t.includes('cardiac')) {
        return "Cardiac Rehabilitation";
    }

    // 4. Electrodiagnostic Medicine (EDX)
    if (t.includes('electrodiagnostic')) {
        return "Electrodiagnostic Medicine (EDX)";
    }

    // 5. MSK (Elbow, Foot, Hand, Knee, Lower Leg... Shoulder? Spine? Wrist?)
    // Text file group: "MSK (Elbow, Foot, Hand, Hip, Knee, Lower Leg)"
    // We moved Hip to group 1.
    // What about Shoulder, Spine, Wrist? They are in episodes.js.
    // I'll put them in MSK as well.
    if (t.includes('shoulder') || t.includes('elbow') || t.includes('foot') ||
        t.includes('hand') || t.includes('knee') || t.includes('lower leg') ||
        t.includes('spine') || t.includes('wrist') || t.includes('musculoskeletal')) {
        // Note: all these start with "Musculoskeletal: ..."
        return "Musculoskeletal (MSK)";
    }

    // 6. Neurology (MS, Osteoporosis, P&O)
    // Note: P&O title is "Prosthetics & Orthotics"
    if (t.includes('multiple sclerosis') || t.includes('osteoporosis') || t.includes('prosthetics & orthotics')) {
        return "Neurology (MS, Osteoporosis, P&O)";
    }

    // 7. Pain Medicine
    if (t.includes('pain')) {
        return "Pain Medicine";
    }

    // 8. Pediatrics
    if (t.includes('pediatrics')) {
        return "Pediatrics";
    }

    // 9. Physical Modalities
    if (t.includes('physical modalities')) {
        return "Physical Modalities";
    }

    // 10. Pulmonary Rehabilitation
    if (t.includes('pulmonary')) {
        return "Pulmonary Rehabilitation";
    }

    // 11. Rheumatology
    if (t.includes('rheumatology')) {
        return "Rheumatology";
    }

    // 12. Spinal Cord Injury (SCI)
    if (t.includes('spinal cord injury')) {
        return "Spinal Cord Injury (SCI)";
    }

    // 13. Spasticity & Movement Disorders
    if (t.includes('spasticity')) {
        return "Spasticity & Movement Disorders";
    }

    // 14. Stroke (CVA)
    if (t.includes('stroke')) {
        return "Stroke (CVA)";
    }

    // 15. Traumatic Brain Injury (TBI)
    if (t.includes('traumatic brain injury')) {
        return "Traumatic Brain Injury (TBI)";
    }

    // 16. Wheelchairs & Bioethics
    if (t.includes('wheelchair') || t.includes('bioethics') || t.includes('board exam')) {
        return "Wheelchairs & Bioethics";
    }

    return "General";
}

let newEpContent = `import { descriptions } from './descriptions.js';\n\nexport const episodes = [\n`;

extractedEpisodes.forEach(ep => {
    const newCat = getNewCategory(ep.title);
    newEpContent += `    { title: "${ep.title}", url: "${ep.url}", category: "${newCat}", description: descriptions["${ep.title}"] },\n`;
});

newEpContent += `];\n`;

fs.writeFileSync('js/episodes.js', newEpContent);
console.log('Updated js/episodes.js');

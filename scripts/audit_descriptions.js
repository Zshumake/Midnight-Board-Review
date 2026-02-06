const fs = require('fs');
const { episodes } = require('../js/episodes.js');

// Read the text file
const descText = fs.readFileSync('Podcast descriptions_full.txt', 'utf8');
const lines = descText.split('\n').map(l => l.trim()).filter(l => l.length > 0);

// Parse text file into a map
const textMap = {};
let currentTitle = null;

// Normalize function (same as in inject_descriptions.js)
function normalizeTitle(t) {
    if (!t) return null;
    let norm = t
        .replace("MSK", "Musculoskeletal:")
        .replace("P&O", "Prosthetics & Orthotics")
        .replace("SCI", "Spinal Cord Injury")
        .replace("TBI", "Traumatic Brain Injury")
        .replace("EDX", "Electrodiagnostic")
        .replace("Peds", "Pediatrics")
        .replace("Rhue", "Rheumatology")
        .replace("Rheum", "Rheumatology")
        .replace("Neuro", "Neurology")
        .replace("Cardio", "Cardiac Rehab")
        .trim();

    // Fix specific spacing issues found previously
    if (norm === "Prosthetics & Orthotics10") norm = "Prosthetics & Orthotics 10";
    return norm;
}

lines.forEach(line => {
    // If line is short and looks like a title (contains digit or known keyword)
    if (line.length < 50 && (/\d/.test(line) || /MSK|SCI|TBI|Stroke|Pain|Burn|Peds|Neuro|Cardio|Pulm|Rheum|Prosthetics/.test(line))) {
        currentTitle = normalizeTitle(line);
    } else if (currentTitle) {
        if (!textMap[currentTitle]) textMap[currentTitle] = "";
        textMap[currentTitle] += line + " ";
    }
});

// 1. Check for Missing (App has it, Text does not)
const appKeys = episodes.map(e => e.title);
const missingInText = appKeys.filter(k => !textMap[k]);

// 2. Check for Unused (Text has it, App does not)
const textKeys = Object.keys(textMap);
const unusedInText = textKeys.filter(k => !appKeys.includes(k));

console.log("=== AUDIT REPORT ===");
console.log(`Total App Episodes: ${appKeys.length}`);
console.log(`Total Text Descriptions: ${textKeys.length}`);

console.log("\n--- MISSING DESCRIPTIONS (In App, Not in Text) ---");
if (missingInText.length > 0) {
    missingInText.forEach(k => console.log(`[MISSING] ${k}`));
} else {
    console.log("NONE - All app episodes have descriptions.");
}

console.log("\n--- UNUSED DESCRIPTIONS (In Text, Not in App) ---");
if (unusedInText.length > 0) {
    unusedInText.forEach(k => console.log(`[UNUSED]  ${k}`));
} else {
    console.log("NONE - All text descriptions were used.");
}

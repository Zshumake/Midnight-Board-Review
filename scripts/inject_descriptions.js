const fs = require('fs');

// Read the text file
const descText = fs.readFileSync('Podcast descriptions_full.txt', 'utf8');
const lines = descText.split('\n').map(l => l.trim()).filter(l => l.length > 0);

// Parse text file into a map: key -> description
const descMap = {};
let currentTitle = null;

// Normalize title to match episodes.js
function normalizeTitle(t) {
    if (!t) return null;
    let norm = t
        .replace(/MSK/g, "Musculoskeletal:")
        .replace(/P&O/g, "Prosthetics & Orthotics")
        .replace(/SCI/g, "Spinal Cord Injury")
        .replace(/TBI/g, "Traumatic Brain Injury")
        .replace(/EDX/g, "Electrodiagnostic")
        .replace(/Peds/g, "Pediatrics")
        .replace(/Rhue/g, "Rheumatology")
        .replace(/Rheum(?!atology)/g, "Rheumatology") // Replace Rheum but not Rheumatology
        .replace(/Neuro/g, "Neurology")
        .replace(/Cardio/g, "Cardiac Rehab")
        .replace(/CVA/g, "Cerebrovascular Accident")
        .replace(/Biostats/g, "Biostatistics")
        .trim();

    // Specific Fixes
    if (norm.startsWith("Ankle")) norm = "Musculoskeletal: " + norm;
    if (norm === "Prosthetics & Orthotics10") norm = "Prosthetics & Orthotics 10";
    if (norm.startsWith("Pulmonary Rehab")) norm = norm.replace("Pulmonary Rehab", "Pulmonary");

    // Formatting cleanup
    norm = norm.replace("Musculoskeletal:", "Musculoskeletal: ");
    norm = norm.replace("  ", " "); // Fix double spaces

    return norm.trim();
}

lines.forEach(line => {
    // Detect Titles:
    // 1. Contains a digit AND a known keyword
    // 2. OR is exactly one of the known non-numbered titles (or looks like one)
    const knownKeywords = /MSK|SCI|TBI|Stroke|Pain|Burn|Peds|Neuro|Cardio|Pulm|Rheum|Prosthetics|CVA|Ankle|Biostats/;

    // Check if line is a likely header
    const isKeywordTitle = (line.length < 60 && (/\d/.test(line) || knownKeywords.test(line)));
    const isSpecialTitle = ["Bioethics", "Biostatistics", "The Board Exam"].includes(line.replace(/[^a-zA-Z ]/g, "").trim());

    if (isKeywordTitle || isSpecialTitle) {
        currentTitle = normalizeTitle(line);
    } else if (currentTitle) {
        if (!descMap[currentTitle]) descMap[currentTitle] = "";
        descMap[currentTitle] += line + " ";
    }
});

// Generate Output File Content
let output = `export const descriptions = {\n`;
const finalKeys = Object.keys(descMap).sort();

for (const key of finalKeys) {
    let val = descMap[key].trim();
    const safeVal = val.replace(/"/g, '\\"');
    output += `    "${key}": "${safeVal}",\n`;
}

// Check against episodes.js usage to inject placeholders
const epContent = fs.readFileSync('js/episodes.js', 'utf8');
const usedKeys = [];
const regex = /descriptions\["(.*?)"\]/g;
let match;
while ((match = regex.exec(epContent)) !== null) {
    usedKeys.push(match[1]);
}

const missing = usedKeys.filter(k => !descMap[k]);
if (missing.length > 0) {
    console.warn("\nWARNING: The following keys used in episodes.js were NOT found in the descriptions map. Injecting placeholders...");
    const unique = [...new Set(missing)]; // Deduplicate
    unique.forEach(k => {
        console.warn(` - ${k}`);
        // Add to output string directly
        output += `    "${k}": "Description coming soon...",\n`;
    });
} else {
    console.log("\nSUCCESS: All keys used in episodes.js are present in descriptions.");
}

output += `};\n`;

fs.writeFileSync('js/descriptions.js', output);
console.log(`Generated js/descriptions.js`);

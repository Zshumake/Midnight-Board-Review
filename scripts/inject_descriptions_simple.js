const fs = require('fs');

// Read the text file
const descText = fs.readFileSync('Podcast descriptions_full.txt', 'utf8');
const lines = descText.split('\n').map(l => l.trim()).filter(l => l.length > 0);

const descMap = {};
let currentTitle = null;

lines.forEach(line => {
    // If line looks like a title (short, contains digits or specific keywords)
    const isTitle = line.length < 60 && (/\d|Bioethics|Biostatistics|The Board Exam|Musculoskeletal:/.test(line));

    if (isTitle) {
        currentTitle = line.replace(/:$/, '').trim(); // Remove trailing colons if any
        console.log("Detected Title:", currentTitle);
    } else if (currentTitle) {
        if (!descMap[currentTitle]) descMap[currentTitle] = "";
        descMap[currentTitle] += line + " ";
    }
});

// Verify and Inject Placeholders
const epContent = fs.readFileSync('js/episodes.js', 'utf8');
const usedKeys = [];
const regex = /descriptions\[['"](.*?)['"]\]/g;
let match;
while ((match = regex.exec(epContent)) !== null) {
    usedKeys.push(match[1]);
}

const missing = usedKeys.filter(k => !descMap[k]);

if (missing.length > 0) {
    console.warn("\nWARNING: Missing descriptions for the following keys (injecting placeholders):");
    const uniqueMissing = [...new Set(missing)];
    uniqueMissing.forEach(k => {
        console.warn(` - ${k}`);
        descMap[k] = "Description coming soon.";
    });
} else {
    console.log("SUCCESS: All keys matched!");
}

// Generate Output
let output = `export const descriptions = {\n`;
for (const [key, val] of Object.entries(descMap)) {
    const safeVal = val.trim().replace(/"/g, '\\"').replace(/\n/g, '\\n');
    output += `    "${key}": "${safeVal}",\n`;
}
output += `};\n`;

fs.writeFileSync('js/descriptions.js', output);
console.log(`Generated js/descriptions.js with ${Object.keys(descMap).length} entries.`);

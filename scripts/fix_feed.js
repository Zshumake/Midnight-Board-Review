import fs from 'fs';
import https from 'https';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const xmlPath = path.join(__dirname, '../feed/v1_8zX9s2_secure.xml');
let xmlContent = fs.readFileSync(xmlPath, 'utf8');

// Regex to find enclosure tags
// <enclosure url="..." length="0" type="..." />
const enclosureRegex = /<enclosure url="([^"]+)" length="([^"]+)" type="([^"]+)" \/>/g;
let match;

console.log("Analyzing Feed...");

// Extract all matches first to avoid regex state issues during async
const matches = [];
while ((match = enclosureRegex.exec(xmlContent)) !== null) {
    matches.push({
        fullTag: match[0],
        url: match[1],
        currentLength: match[2],
        currentType: match[3]
    });
}

console.log(`Found ${matches.length} episodes. Fetching headers...`);

// Function to fetch headers
const fetchHead = (item) => {
    return new Promise((resolve) => {
        const req = https.request(item.url, { method: 'HEAD' }, (res) => {
            if (res.statusCode >= 200 && res.statusCode < 400) {
                const newLength = res.headers['content-length'] || '0';
                // Trust the server's content type or derive from extension if server is generic
                let newType = res.headers['content-type'];

                // R2 might return application/octet-stream, so let's force expected types for Apple
                if (item.url.endsWith('.m4a')) newType = 'audio/x-m4a';
                if (item.url.endsWith('.mp3')) newType = 'audio/mpeg';

                resolve({ ...item, newLength, newType });
            } else {
                console.error(`Failed ${item.url}: ${res.statusCode}`);
                resolve(item); // Return original if fail
            }
        });
        req.on('error', (e) => {
            console.error(`Error ${item.url}: ${e.message}`);
            resolve(item);
        });
        req.end();
    });
};

// Process in chunks to avoid rate limits
async function processBatch() {
    let updatedXml = xmlContent;

    // Process 10 at a time
    for (let i = 0; i < matches.length; i += 10) {
        const batch = matches.slice(i, Math.min(i + 10, matches.length));
        console.log(`Processing ${i} to ${i + batch.length}...`);

        const results = await Promise.all(batch.map(fetchHead));

        results.forEach(res => {
            if (res.newLength && res.newLength !== '0') {
                const newTag = `<enclosure url="${res.url}" length="${res.newLength}" type="${res.newType}" />`;
                // Use strict replacement to ensure we don't double replace if URLs are identical (which they rarely are)
                updatedXml = updatedXml.replace(res.fullTag, newTag);
            }
        });
    }

    fs.writeFileSync(xmlPath, updatedXml);
    console.log("Done! XML Updated.");
}

processBatch();

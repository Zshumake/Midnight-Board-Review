
import { pmrSeries } from './js/series/pmr_board_review.js';
import https from 'https';

console.log(`Verifying ${pmrSeries.episodes.length} episodes...`);

let pending = 0;
const failures = [];

pmrSeries.episodes.forEach((ep, index) => {
    pending++;
    const req = https.request(ep.url, { method: 'HEAD' }, (res) => {
        if (res.statusCode !== 200) {
            console.error(`❌ [${res.statusCode}] ${ep.title}: ${ep.url}`);
            failures.push({ title: ep.title, url: ep.url, status: res.statusCode });
        } else {
            // Success - mostly silent to reduce noise, or print a dot
            process.stdout.write('.');
        }
        pending--;
        checkDone();
    });

    req.on('error', (e) => {
        console.error(`❌ [Error] ${ep.title}: ${e.message}`);
        failures.push({ title: ep.title, url: ep.url, error: e.message });
        pending--;
        checkDone();
    });

    req.end();
});

function checkDone() {
    if (pending === 0) {
        console.log('\n\n--- Verification Complete ---');
        if (failures.length === 0) {
            console.log('✅ All links are valid!');
        } else {
            console.log(`⚠️ Found ${failures.length} broken links:`);
            failures.forEach(f => console.log(`- ${f.title}: ${f.url}`));
        }
    }
}

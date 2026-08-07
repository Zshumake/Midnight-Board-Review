const fs = require('fs');
const path = require('path');

/**
 * RSS Feed Generator for Midnight Board Review
 *
 * Usage:
 *   1. dart run scripts/export_episodes_json.dart   (exports Dart data to JSON)
 *   2. node generate_rss.cjs                        (generates the feed XML)
 */

function escapeXml(unsafe) {
    if (typeof unsafe !== 'string') return '';
    return unsafe
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&apos;');
}

async function generate() {
    console.log('🚀 Generating RSS Feed...');

    // Load episode data (exported from Dart via export_episodes_json.dart)
    const episodesPath = path.join(__dirname, 'scripts', 'episodes.json');
    if (!fs.existsSync(episodesPath)) {
        console.error('❌ scripts/episodes.json not found.');
        console.error('   Run first: dart run scripts/export_episodes_json.dart');
        process.exit(1);
    }

    const episodes = JSON.parse(fs.readFileSync(episodesPath, 'utf8'));

    // Load media sizes if available (optional — falls back to estimate)
    let sizes = {};
    const sizesPath = path.join(__dirname, 'scripts', 'mediaSizes.json');
    if (fs.existsSync(sizesPath)) {
        sizes = JSON.parse(fs.readFileSync(sizesPath, 'utf8'));
    }

    const config = {
        title: "Midnight Board Review (Private)",
        link: "https://shuhub.xyz/Midnight-Board-Review/",
        author: "Midnight Review",
        summary: `A ${episodes.length}-episode podcast covering everything in the PM&R board review.`,
        category: "Health & Fitness",
        subCategory: "Medicine",
        ownerName: "Zachary Shumaker",
        ownerEmail: "zacharyshumaker@gmail.com",
        coverUrl: "https://shuhub.xyz/Midnight-Board-Review/cover.jpg",
        feedUrl: "https://shuhub.xyz/Midnight-Board-Review/feed/v1_8zX9s2_secure.xml"
    };

    let xml = `<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>${escapeXml(config.title)}</title>
    <atom:link href="${config.feedUrl}" rel="self" type="application/rss+xml" />
    <link>${config.link}</link>
    <language>en-us</language>
    <copyright>&#169; 2026 ${escapeXml(config.author)}</copyright>
    <itunes:author>${escapeXml(config.author)}</itunes:author>
    <description>${escapeXml(config.summary)}</description>
    <itunes:image href="${config.coverUrl}" />
    <image>
        <url>${config.coverUrl}</url>
        <title>${escapeXml(config.title)}</title>
        <link>${config.link}</link>
    </image>
    <itunes:category text="${escapeXml(config.category)}">
        <itunes:category text="${escapeXml(config.subCategory)}" />
    </itunes:category>
    <itunes:type>serial</itunes:type>
    <itunes:explicit>false</itunes:explicit>
    <itunes:owner>
        <itunes:name>${escapeXml(config.ownerName)}</itunes:name>
        <itunes:email>${escapeXml(config.ownerEmail)}</itunes:email>
    </itunes:owner>\n`;

    const totalEpisodes = episodes.length;
    const now = Date.now();

    episodes.forEach((ep, i) => {
        const filename = ep.url.split('/').pop();
        const length = sizes[filename] || "60000000";
        const episodeNumber = i + 1;

        // Serial order: Ep 1 = oldest, Ep N = newest
        const daysAgo = totalEpisodes - i;
        const pubDate = new Date(now - (daysAgo * 86400000)).toUTCString();

        xml += `    <item>
      <title>${escapeXml(ep.title)}</title>
      <link>${config.link}</link>
      <itunes:episode>${episodeNumber}</itunes:episode>
      <itunes:season>1</itunes:season>
      <description>${escapeXml(ep.description)}</description>
      <enclosure url="${escapeXml(ep.url)}" length="${length}" type="audio/x-m4a" />
      <guid isPermaLink="false">${escapeXml(ep.url)}</guid>
      <pubDate>${pubDate}</pubDate>
      <itunes:summary>${escapeXml(ep.description)}</itunes:summary>
      <itunes:episodeType>full</itunes:episodeType>
      <itunes:image href="${config.coverUrl}" />
    </item>\n`;
    });

    xml += `  </channel>
</rss>`;

    // Write both copies. GitHub Pages publishes from docs/, so a feed written
    // only to feed/ is never actually served — that is how this feed went dark
    // when the Flutter migration rebuilt docs/ without it.
    const targets = [
        path.join(__dirname, 'feed', 'v1_8zX9s2_secure.xml'),
        path.join(__dirname, 'docs', 'feed', 'v1_8zX9s2_secure.xml'),
    ];

    targets.forEach((targetFile) => {
        fs.mkdirSync(path.dirname(targetFile), { recursive: true });
        fs.writeFileSync(targetFile, xml);
        console.log(`✅ Generated feed with ${episodes.length} episodes → ${targetFile}`);
    });
}

generate().catch(console.error);

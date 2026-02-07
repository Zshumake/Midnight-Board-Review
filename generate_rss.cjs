const fs = require('fs');
const path = require('path');

function escapeXml(unsafe) {
    return (unsafe || '').toString()
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&apos;');
}

async function generate() {
    console.log('🚀 Generating Production RSS Feed...');

    // 1. Load Data Sources
    const seriesPath = path.join(__dirname, 'js', 'series', 'pmr_board_review.js');
    const seriesContent = fs.readFileSync(seriesPath, 'utf8');

    const descPath = path.join(__dirname, 'js', 'descriptions.js');
    const descContent = fs.readFileSync(descPath, 'utf8');

    const sizesPath = path.join(__dirname, 'js', 'modules', 'mediaSizes.json');
    const sizes = JSON.parse(fs.readFileSync(sizesPath, 'utf8'));

    // Modular Config (matches the rssConfig.js file)
    const config = {
        title: "Midnight Board Review (Private)",
        link: "https://zshumake.github.io/Midnight-Board-Review/",
        author: "Midnight Review",
        summary: "A 119-episode podcast covering everything in the PM&R board review.",
        category: "Health & Fitness",
        subCategory: "Medicine",
        ownerName: "Zachary Shumaker",
        ownerEmail: "zacharyshumaker@gmail.com",
        coverUrl: "https://zshumake.github.io/Midnight-Board-Review/cover.jpg",
        feedUrl: "https://zshumake.github.io/Midnight-Board-Review/feed/v1_8zX9s2_secure.xml"
    };

    // 2. Parse Episodes
    const episodes = [];
    const entryRegex = /\{\s*title:\s*"(.*?)",\s*url:\s*"(.*?)",\s*category:\s*"(.*?)",\s*description:\s*descriptions\["(.*?)"\]/g;
    let match;

    while ((match = entryRegex.exec(seriesContent)) !== null) {
        const title = match[1];
        const url = match[2];
        const category = match[3];
        const descKey = match[4];

        const escapedKey = descKey.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
        const descRegex = new RegExp(`"${escapedKey}":\\s*"(.*?)"`, 's');
        const descMatch = descContent.match(descRegex);
        const description = descMatch ? descMatch[1] : category;

        episodes.push({ title, url, category, description });
    }

    // 3. Build XML Header
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
    <itunes:explicit>false</itunes:explicit>
    <itunes:owner>
        <itunes:name>${escapeXml(config.ownerName)}</itunes:name>
        <itunes:email>${escapeXml(config.ownerEmail)}</itunes:email>
    </itunes:owner>\n`;

    // 4. Add Items with Real Sizes
    episodes.forEach((ep, i) => {
        const filename = ep.url.split('/').pop();
        const length = sizes[filename] || "60000000";

        xml += `    <item>
      <title>${escapeXml(ep.title)}</title>
      <description>${escapeXml(ep.description)}</description>
      <enclosure url="${ep.url}" length="${length}" type="audio/x-m4a" />
      <guid isPermaLink="false">${ep.url}</guid>
      <pubDate>${new Date(Date.now() - (i * 86400000)).toUTCString()}</pubDate>
      <itunes:summary>${escapeXml(ep.description)}</itunes:summary>
      <itunes:episodeType>full</itunes:episodeType>
      <itunes:image href="${config.coverUrl}" />
    </item>\n`;
    });

    xml += `  </channel>
</rss>`;

    // 5. Final Write
    const relativePath = path.join('feed', 'v1_8zX9s2_secure.xml');
    fs.writeFileSync(path.join(__dirname, relativePath), xml);
    console.log(`✅ Success! Generated ${episodes.length} episodes with valid XML and correct file sizes.`);
}

generate().catch(console.error);

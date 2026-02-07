const fs = require('fs');
const path = require('path');

/**
 * Utility to escape XML special characters
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
    console.log('🚀 Generating Production RSS Feed from JSON...');

    // 1. Load Data Sources (JSON is much more reliable)
    const episodes = JSON.parse(fs.readFileSync(path.join(__dirname, 'js', 'modules', 'episodes.json'), 'utf8'));
    const sizes = JSON.parse(fs.readFileSync(path.join(__dirname, 'js', 'modules', 'mediaSizes.json'), 'utf8'));

    // Modular Config
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

    // 2. Build XML Header
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

    // 3. Add Items
    // Reverse episodes for RSS chronicity (newest first)
    [...episodes].reverse().forEach((ep, i) => {
        const filename = ep.url.split('/').pop();
        const length = sizes[filename] || "60000000";

        xml += `    <item>
      <title>${escapeXml(ep.title)}</title>
      <link>${config.link}</link>
      <description>${escapeXml(ep.description)}</description>
      <enclosure url="${escapeXml(ep.url)}" length="${length}" type="audio/x-m4a" />
      <guid isPermaLink="false">${escapeXml(ep.url)}</guid>
      <pubDate>${new Date(Date.now() - (i * 86400000)).toUTCString()}</pubDate>
      <itunes:summary>${escapeXml(ep.description)}</itunes:summary>
      <itunes:episodeType>full</itunes:episodeType>
      <itunes:image href="${config.coverUrl}" />
    </item>\n`;
    });

    xml += `  </channel>
</rss>`;

    // 4. Final Write
    const targetFile = path.join(__dirname, 'feed', 'v1_8zX9s2_secure.xml');
    fs.writeFileSync(targetFile, xml);
    console.log(`✅ Success! Rebuilt feed with ${episodes.length} episodes.`);
}

generate().catch(console.error);

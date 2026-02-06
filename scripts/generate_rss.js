
import fs from 'fs';
import { episodes } from '../js/episodes.js';

const RSS_FILENAME = 'feed.xml';
const SITE_URL = 'https://zshumake.github.io/Midnight-Board-Review';
const IMAGE_URL = 'https://zshumake.github.io/Midnight-Board-Review/cover.jpg';
const AUTHOR = 'Cuccurullo / Midnight Board Review';
const EMAIL = 'placeholder@example.com';

const generateRSS = () => {
    let xml = `<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" 
    xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" 
    xmlns:a10="http://www.w3.org/2005/Atom"
    xmlns:content="http://purl.org/rss/1.0/modules/content/"
    xmlns:googleplay="http://www.google.com/schemas/play-podcasts/1.0">
  <channel>
    <title>Midnight Board Review</title>
    <link>${SITE_URL}</link>
    <language>en-us</language>
    <copyright>2026 Midnight Board Review</copyright>
    <itunes:author>${AUTHOR}</itunes:author>
    <itunes:summary>Comprehensive PM&amp;R Board Review covering Musculoskeletal, Neurology, Electrodiagnostics, and more.</itunes:summary>
    <description>Comprehensive PM&amp;R Board Review covering Musculoskeletal, Neurology, Electrodiagnostics, and more.</description>
    <itunes:owner>
        <itunes:name>${AUTHOR}</itunes:name>
        <itunes:email>${EMAIL}</itunes:email>
    </itunes:owner>
    <itunes:image href="${IMAGE_URL}" />
    <itunes:category text="Health &amp; Fitness">
        <itunes:category text="Medicine" />
    </itunes:category>
    <itunes:explicit>no</itunes:explicit>
`;

    const now = new Date();

    episodes.forEach((ep, index) => {
        // Create a fake pubDate based on index to ensure sorting
        const pubDate = new Date(now.getTime() - (episodes.length - index) * 86400000).toUTCString();
        const safeTitle = ep.title.replace(/&/g, '&amp;');
        const safeDesc = (ep.description || "Description coming soon.").replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
        const duration = "10:00"; // Placeholder duration if unknown, or can remove if optional

        xml += `
    <item>
      <title>${safeTitle}</title>
      <description>${safeDesc}</description>
      <itunes:summary>${safeDesc}</itunes:summary>
      <enclosure url="${ep.url}" type="audio/x-m4a" />
      <guid isPermaLink="true">${ep.url}</guid>
      <pubDate>${pubDate}</pubDate>
      <itunes:duration>${duration}</itunes:duration>
      <itunes:image href="${IMAGE_URL}" />
    </item>`;
    });

    xml += `
  </channel>
</rss>`;

    fs.writeFileSync(RSS_FILENAME, xml);
    console.log(`Successfully generated ${RSS_FILENAME} with ${episodes.length} episodes.`);
};

generateRSS();

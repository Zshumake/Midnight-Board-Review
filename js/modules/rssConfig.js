/**
 * RSS Configuration Module
 * Centralizes the podcast channel metadata for the RSS/XML generator.
 */
export const rssConfig = {
    // Channel Metadata
    title: "Midnight Board Review (Private)",
    link: "https://zshumake.github.io/Midnight-Board-Review/",
    language: "en-us",
    copyright: "2026 Midnight Review",
    author: "Midnight Review",
    summary: "A 119-episode podcast covering everything in the PM&R board review.",

    // Apple / iTunes Specifics
    category: "Health & Fitness",
    subCategory: "Medicine",
    explicit: "false",
    ownerName: "Zachary Shumaker",
    ownerEmail: "zacharyshumaker@gmail.com",

    // Media
    coverUrl: "https://zshumake.github.io/Midnight-Board-Review/cover.jpg",

    // Feed Technicals
    feedUrl: "https://zshumake.github.io/Midnight-Board-Review/feed/v1_8zX9s2_secure.xml",
    baseMediaUrl: "https://pub-a42279514b124e9085d9969a57978062.r2.dev/"
};

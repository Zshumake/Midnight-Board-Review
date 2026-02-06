
export const ICONS = {
    play: `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="24" height="24"><path d="M8 5v14l11-7z"/></svg>`,
    pause: `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="24" height="24"><path d="M6 19h4V5H6v14zm8-14v14h4V5h-4z"/></svg>`,
    next: `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="24" height="24"><path d="M6 18l8.5-6L6 6v12zM16 6v12h2V6h-2z"/></svg>`,
    prev: `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="24" height="24"><path d="M6 6h2v12H6zm3.5 6l8.5 6V6z"/></svg>`,
    skipBack: `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="24" height="24"><path d="M12.5 8c-2.65 0-5.05.99-6.9 2.6L2 7v9h9l-3.62-3.62c1.39-1.16 3.16-1.88 5.12-1.88 3.54 0 6.55 2.31 7.6 5.5l2.37-.78C21.08 11.03 17.15 8 12.5 8z"/></svg>`,
    skipFwd: `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="24" height="24"><path d="M10 9V7h9l-3.62 3.62c1.39 1.16 3.16 1.88 5.12 1.88 3.54 0 6.55-2.31 7.6-5.5l2.37.78C29.08 11.53 25.15 14.5 20.5 14.5c-2.65 0-5.05-.99-6.9-2.6L10 16V9z" transform="scale(-1, 1) translate(-24, 0)"/><path d="M12.5 8c2.65 0 5.05.99 6.9 2.6L22 7v9h-9l3.62-3.62c-1.39-1.16-3.16-1.88-5.12-1.88-3.54 0-6.55 2.31-7.6 5.5l-2.37-.78C2.92 11.03 6.85 8 11.5 8z" transform="scale(-1, 1) translate(-24, 0)"/></svg>` // Mirroring skipBack for ease or finding standard path
};
// Simpler Skip Fwd path:
const SKIP_FWD = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" width="24" height="24"><path d="M11.5 8c4.65 0 8.58 3.03 9.96 7.22l-2.37.78c-1.05-3.19-4.06-5.5-7.6-5.5-1.95 0-3.73.72-5.12 1.88L10 16H1V7l3.6 3.6C6.45 8.99 8.85 8 11.5 8z"/></svg>`;
// Correcting Skip Fwd to be clockwise
ICONS.skipFwd = SKIP_FWD;

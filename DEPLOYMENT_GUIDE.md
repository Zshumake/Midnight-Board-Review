# Deployment & Upload Guide

To keep your website fast and **100% free**, we use a "Hybrid" model: **GitHub** hosts the code, and **Cloudflare R2** hosts the audio.

## Step 1: Upload Audio to Cloudflare R2
Since GitHub has strict file size limits and can be slow for streaming, your audio lives in your Cloudflare bucket.

1.  Log in to your [Cloudflare Dashboard](https://dash.cloudflare.com/).
2.  Go to **R2** in the sidebar.
3.  Open your `pmr-review` bucket (or create it if you haven't).
4.  **Drag and drop** your MP3 files here.
5.  **CRITICAL**: Make sure the filename exactly matches the URL in `js/episodes.js`.
    - *Example*: If the file is `Stroke1.mp3`, it should be at `https://media.shuhub.xyz/Stroke1.mp3`.

## Step 2: Push Website Code to GitHub
This is where the interface, the search bar, and the private RSS feed live.

1.  Make sure your local folder has these files:
    - `index.html`
    - `style.css`
    - `cover.jpg`
    - `js/` (containing `player.js`, `episodes.js`, etc.)
2.  Use **GitHub Desktop** (easier) or the terminal to push these to your repository.
3.  Once pushed, your site will be live at `https://shuhub.xyz/` (or your chosen path).

## Step 3: Updating Episodes
If you ever record a new episode or change a title:

1.  Open `js/episodes.js`.
2.  Find the relevant category and add/edit the entry:
    ```javascript
    { title: "New Episode", url: "https://media.shuhub.xyz/NewFile.mp3", category: "MSK/Sports" }
    ```
3.  Upload the new `NewFile.mp3` to Cloudflare R2 (Step 1).
4.  Push the updated `js/episodes.js` to GitHub (Step 2).

### Pro-Tip: File Names
Avoid spaces in filenames (e.g., use `Stroke_1.mp3` instead of `Stroke 1.mp3`). This prevents broken links and makes sorting much easier!

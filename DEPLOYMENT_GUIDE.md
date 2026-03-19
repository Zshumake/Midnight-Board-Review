# Deployment & Upload Guide

This is a Flutter Web app. Audio is hosted on **Cloudflare R2**, the site is served via **GitHub Pages**.

## Architecture

```
Flutter App (GitHub Pages)  ──▶  Audio Files (Cloudflare R2)
lib/data/episodes_data.dart       pub-a42279514b124e9085d9969a57978062.r2.dev
```

## Step 1: Upload Audio to Cloudflare R2

1. Log in to your [Cloudflare Dashboard](https://dash.cloudflare.com/).
2. Go to **R2** in the sidebar.
3. Open your `pmr-review` bucket.
4. **Drag and drop** your `.m4a` files.
5. The filename must match the URL in `lib/data/episodes_data.dart`.
   - Example: `Stroke_1.m4a` → `https://pub-a42279514b124e9085d9969a57978062.r2.dev/Stroke_1.m4a`

## Step 2: Build & Deploy the Flutter App

```bash
# Build the release web bundle
flutter build web --release

# The output is in build/web/ — push this to GitHub Pages
```

If using GitHub Pages from the repo root, copy `build/web/*` to the root or configure Pages to serve from `build/web`.

## Step 3: Adding / Editing Episodes

1. Open `lib/data/episodes_data.dart`.
2. Add or edit an entry in the `allEpisodes` list:
   ```dart
   Episode(
     title: 'New Episode Title',
     url: 'https://pub-a42279514b124e9085d9969a57978062.r2.dev/NewFile.m4a',
     category: 'Pain Medicine',
     description: descriptions['New Episode Title'] ?? '',
   ),
   ```
3. If adding a description, update `lib/data/descriptions_data.dart`.
4. Upload the audio file to R2 (Step 1).
5. Rebuild and deploy (Step 2).

## Step 4: Updating the RSS Feed

Run the RSS generator after any episode changes:

```bash
node generate_rss.cjs
```

This outputs `feed/v1_8zX9s2_secure.xml`. Commit and push it alongside the web build.

## File Names

Avoid spaces — use underscores (e.g., `Stroke_1.m4a` not `Stroke 1.m4a`).

const audio = document.getElementById('audio');
const playBtn = document.getElementById('play');
const prevBtn = document.getElementById('prev');
const nextBtn = document.getElementById('next');
const skipBackBtn = document.getElementById('skip-back');
const skipFwdBtn = document.getElementById('skip-fwd');
const speedSelect = document.getElementById('speed-select');
const progressContainer = document.getElementById('progress-container');
const progressBar = document.getElementById('progress-bar');
const title = document.getElementById('current-track-title');
const copyRssBtn = document.getElementById('copy-rss');
const rssUrlText = document.getElementById('rss-url');

const episodes = [
    { title: "MSK 1", url: "https://media.shuhub.xyz/MS1.mp3" },
    { title: "MSK 2", url: "https://media.shuhub.xyz/MS2.mp3" },
    { title: "Shoulder 1", url: "https://media.shuhub.xyz/Shoulder1.mp3" },
    { title: "Shoulder 2", url: "https://media.shuhub.xyz/Shoulder2.mp3" },
    { title: "Shoulder 3", url: "https://media.shuhub.xyz/Shoulder3.mp3" },
    { title: "Shoulder 4", url: "https://media.shuhub.xyz/Shoulder4.mp3" },
    { title: "Elbow 1", url: "https://media.shuhub.xyz/Elbow1.mp3" },
    { title: "Elbow 2", url: "https://media.shuhub.xyz/Elbow2.mp3" },
    { title: "Wrist 1", url: "https://media.shuhub.xyz/Wrist1.mp3" },
    { title: "Hand 1", url: "https://media.shuhub.xyz/Hand1.mp3" },
    { title: "Hip 1", url: "https://media.shuhub.xyz/Hip1.mp3" },
    { title: "Hip 2", url: "https://media.shuhub.xyz/Hip2.mp3" },
    { title: "Hip 3", url: "https://media.shuhub.xyz/Hip3.mp3" },
    { title: "Knee 1", url: "https://media.shuhub.xyz/Knee1.mp3" },
    { title: "Knee 2", url: "https://media.shuhub.xyz/Knee2.mp3" },
    { title: "Knee 3", url: "https://media.shuhub.xyz/Knee3.mp3" },
    { title: "Ankle 1", url: "https://media.shuhub.xyz/Ankle1.mp3" },
    { title: "Ankle 2", url: "https://media.shuhub.xyz/Ankle2.mp3" },
    { title: "Foot 1", url: "https://media.shuhub.xyz/Foot1.mp3" },
    { title: "Lower Leg 1", url: "https://media.shuhub.xyz/Lower%20Leg1.mp3" },
    { title: "Spine 1", url: "https://media.shuhub.xyz/Spine1.mp3" },
    { title: "Spine 2", url: "https://media.shuhub.xyz/Spine2.mp3" },
    { title: "Spine 3", url: "https://media.shuhub.xyz/Spine3.mp3" },
    { title: "Spine 4", url: "https://media.shuhub.xyz/Spine4.mp3" },
    { title: "Spine 5", url: "https://media.shuhub.xyz/Spine5.mp3" },
    { title: "Spine 6", url: "https://media.shuhub.xyz/Spine6.mp3" },
    { title: "Biostats", url: "https://media.shuhub.xyz/Biostats.mp3" },
    { title: "Burns 1", url: "https://media.shuhub.xyz/Burns1.mp3" },
    { title: "Burns 2", url: "https://media.shuhub.xyz/Burns2.mp3" },
    { title: "Cancer 1", url: "https://media.shuhub.xyz/Cancer1.mp3" },
    { title: "Cancer 2", url: "https://media.shuhub.xyz/Cancer2.mp3" },
    { title: "Cancer 3", url: "https://media.shuhub.xyz/Cancer3.mp3" },
    { title: "Cardiac 1", url: "https://media.shuhub.xyz/Cardiac1.mp3" },
    { title: "Cardiac 2", url: "https://media.shuhub.xyz/Cardiac2.mp3" },
    { title: "Cardiac 3", url: "https://media.shuhub.xyz/Cardiac3.mp3" },
    { title: "Cardiac 4", url: "https://media.shuhub.xyz/Cardiac4.mp3" },
    { title: "EDX 1", url: "https://media.shuhub.xyz/EDX1.mp3" },
    { title: "EDX 2", url: "https://media.shuhub.xyz/EDX2.mp3" },
    { title: "EDX 3", url: "https://media.shuhub.xyz/EDX3.mp3" },
    { title: "EDX 4", url: "https://media.shuhub.xyz/EDX4.mp3" },
    { title: "EDX 5", url: "https://media.shuhub.xyz/EDX5.mp3" },
    { title: "EDX 6", url: "https://media.shuhub.xyz/EDX6.mp3" },
    { title: "EDX 7", url: "https://media.shuhub.xyz/EDX7.mp3" },
    { title: "EDX 8", url: "https://media.shuhub.xyz/EDX8.mp3" },
    { title: "EDX 9", url: "https://media.shuhub.xyz/EDX9.mp3" },
    { title: "EDX 10", url: "https://media.shuhub.xyz/EDX10.mp3" },
    { title: "EDX 11", url: "https://media.shuhub.xyz/EDX11.mp3" },
    { title: "EDX 12", url: "https://media.shuhub.xyz/EDX12.mp3" },
    { title: "EDX 13", url: "https://media.shuhub.xyz/EDX13.mp3" },
    { title: "EDX 14", url: "https://media.shuhub.xyz/EDX14.mp3" },
    { title: "EDX 15", url: "https://media.shuhub.xyz/EDX15.mp3" },
    { title: "Ethics", url: "https://media.shuhub.xyz/Ethics.mp3" },
    { title: "Exam", url: "https://media.shuhub.xyz/Exam.mp3" },
    { title: "Osteoporosis 1", url: "https://media.shuhub.xyz/Osteoporosis1.mp3" },
    { title: "Osteoporosis 2", url: "https://media.shuhub.xyz/Osteoporosis2.mp3" },
    { title: "P&O 1", url: "https://media.shuhub.xyz/P%26O1.mp3" },
    { title: "P&O 2", url: "https://media.shuhub.xyz/P%26O2.mp3" },
    { title: "P&O 3", url: "https://media.shuhub.xyz/P%26O3.mp3" },
    { title: "P&O 4", url: "https://media.shuhub.xyz/P%26O4.mp3" },
    { title: "P&O 5", url: "https://media.shuhub.xyz/P%26O5.mp3" },
    { title: "P&O 6", url: "https://media.shuhub.xyz/P%26O6.mp3" },
    { title: "P&O 7", url: "https://media.shuhub.xyz/P%26O7.mp3" },
    { title: "P&O 8", url: "https://media.shuhub.xyz/P%26O8.mp3" },
    { title: "P&O 9", url: "https://media.shuhub.xyz/P%26O9.mp3" },
    { title: "P&O 10", url: "https://media.shuhub.xyz/P%26O10.mp3" },
    { title: "Pain 1", url: "https://media.shuhub.xyz/Pain1.mp3" },
    { title: "Pain 2", url: "https://media.shuhub.xyz/Pain2.mp3" },
    { title: "Pain 3", url: "https://media.shuhub.xyz/Pain3.mp3" },
    { title: "Pain 4", url: "https://media.shuhub.xyz/Pain4.mp3" },
    { title: "Peds 1", url: "https://media.shuhub.xyz/Peds1.mp3" },
    { title: "Peds 2", url: "https://media.shuhub.xyz/Peds2.mp3" },
    { title: "Peds 3", url: "https://media.shuhub.xyz/Peds3.mp3" },
    { title: "Peds 4", url: "https://media.shuhub.xyz/Peds4.mp3" },
    { title: "Peds 5", url: "https://media.shuhub.xyz/Peds5.mp3" },
    { title: "Peds 6", url: "https://media.shuhub.xyz/Peds6.mp3" },
    { title: "Peds 7", url: "https://media.shuhub.xyz/Peds7.mp3" },
    { title: "Peds 8", url: "https://media.shuhub.xyz/Peds8.mp3" },
    { title: "Peds 9", url: "https://media.shuhub.xyz/Peds9.mp3" },
    { title: "Peds 10", url: "https://media.shuhub.xyz/Peds10.mp3" },
    { title: "Peds 11", url: "https://media.shuhub.xyz/Peds11.mp3" },
    { title: "Physical Modalities 1", url: "https://media.shuhub.xyz/Physical%20Modalities1.mp3" },
    { title: "Physical Modalities 2", url: "https://media.shuhub.xyz/Physical%20Modalities2.mp3" },
    { title: "Physical Modalities 3", url: "https://media.shuhub.xyz/Physical%20Modalities3.mp3" },
    { title: "Physical Modalities 4", url: "https://media.shuhub.xyz/Physical%20Modalities4.mp3" },
    { title: "Pulm 1", url: "https://media.shuhub.xyz/Pulm1.mp3" },
    { title: "Pulm 2", url: "https://media.shuhub.xyz/Pulm2.mp3" },
    { title: "Pulm 3", url: "https://media.shuhub.xyz/Pulm3.mp3" },
    { title: "Rheum 1", url: "https://media.shuhub.xyz/Rheum1.mp3" },
    { title: "Rheum 2", url: "https://media.shuhub.xyz/Rheum2.mp3" },
    { title: "Rheum 3", url: "https://media.shuhub.xyz/Rheum3.mp3" },
    { title: "Rheum 4", url: "https://media.shuhub.xyz/Rheum4.mp3" },
    { title: "Rheum 5", url: "https://media.shuhub.xyz/Rheum5.mp3" },
    { title: "Rheum 6", url: "https://media.shuhub.xyz/Rheum6.mp3" },
    { title: "SCI 1", url: "https://media.shuhub.xyz/SCI1.mp3" },
    { title: "SCI 2", url: "https://media.shuhub.xyz/SCI2.mp3" },
    { title: "SCI 3", url: "https://media.shuhub.xyz/SCI3.mp3" },
    { title: "SCI 4", url: "https://media.shuhub.xyz/SCI4.mp3" },
    { title: "SCI 5", url: "https://media.shuhub.xyz/SCI5.mp3" },
    { title: "SCI 6", url: "https://media.shuhub.xyz/SCI6.mp3" },
    { title: "SCI 7", url: "https://media.shuhub.xyz/SCI7.mp3" },
    { title: "SCI 8", url: "https://media.shuhub.xyz/SCI8.mp3" },
    { title: "SCI 9", url: "https://media.shuhub.xyz/SCI9.mp3" },
    { title: "SCI 10", url: "https://media.shuhub.xyz/SCI10.mp3" },
    { title: "Spasticity 1", url: "https://media.shuhub.xyz/Spasticity1.mp3" },
    { title: "Spasticity 2", url: "https://media.shuhub.xyz/Spasticity2.mp3" },
    { title: "Spasticity 3", url: "https://media.shuhub.xyz/Spasticity3.mp3" },
    { title: "Stroke 1", url: "https://media.shuhub.xyz/Stroke1.mp3" },
    { title: "Stroke 2", url: "https://media.shuhub.xyz/Stroke2.mp3" },
    { title: "Stroke 3", url: "https://media.shuhub.xyz/Stroke3.mp3" },
    { title: "Stroke 4", url: "https://media.shuhub.xyz/Stroke4.mp3" },
    { title: "Stroke 5", url: "https://media.shuhub.xyz/Stroke5.mp3" },
    { title: "Stroke 6", url: "https://media.shuhub.xyz/Stroke6.mp3" },
    { title: "TBI 1", url: "https://media.shuhub.xyz/TBI1.mp3" },
    { title: "TBI 2", url: "https://media.shuhub.xyz/TBI2.mp3" },
    { title: "TBI 3", url: "https://media.shuhub.xyz/TBI3.mp3" },
    { title: "TBI 4", url: "https://media.shuhub.xyz/TBI4.mp3" },
    { title: "TBI 5", url: "https://media.shuhub.xyz/TBI5.mp3" },
    { title: "TBI 6", url: "https://media.shuhub.xyz/TBI6.mp3" },
    { title: "Wheelchairs 1", url: "https://media.shuhub.xyz/Wheelchairs1.mp3" },
    { title: "Wheelchairs 2", url: "https://media.shuhub.xyz/Wheelchairs2.mp3" }
];

let currentIndex = 0;

function loadEpisode(index) {
    const episode = episodes[index];
    title.innerText = episode.title;
    audio.src = episode.url;
    updateMediaSession(episode);
}

function updateMediaSession(episode) {
    if ('mediaSession' in navigator) {
        navigator.mediaSession.metadata = new MediaMetadata({
            title: episode.title,
            artist: 'Cuccurullo Review',
            album: 'Board Review Podcast',
            artwork: [
                { src: 'cover.jpg', sizes: '512x512', type: 'image/jpeg' }
            ]
        });

        navigator.mediaSession.setActionHandler('play', playAudio);
        navigator.mediaSession.setActionHandler('pause', pauseAudio);
        navigator.mediaSession.setActionHandler('previoustrack', prevEpisode);
        navigator.mediaSession.setActionHandler('nexttrack', nextEpisode);
        navigator.mediaSession.setActionHandler('seekbackward', () => skip(-10));
        navigator.mediaSession.setActionHandler('seekforward', () => skip(10));
    }
}

function skip(amount) {
    audio.currentTime = Math.max(0, Math.min(audio.duration || 0, audio.currentTime + amount));
}

function setSpeed() {
    audio.playbackRate = parseFloat(speedSelect.value);
}

function playAudio() {
    playBtn.innerText = '⏸';
    audio.play();
}

function pauseAudio() {
    playBtn.innerText = '▶';
    audio.pause();
}

function togglePlay() {
    if (audio.paused) {
        playAudio();
    } else {
        pauseAudio();
    }
}

function prevEpisode() {
    currentIndex = (currentIndex - 1 + episodes.length) % episodes.length;
    loadEpisode(currentIndex);
    playAudio();
}

function nextEpisode() {
    currentIndex = (currentIndex + 1) % episodes.length;
    loadEpisode(currentIndex);
    playAudio();
}

function updateProgress(e) {
    const { duration, currentTime } = e.srcElement;
    if (duration) {
        const progressPercent = (currentTime / duration) * 100;
        progressBar.style.width = `${progressPercent}%`;
    }
}

function setProgress(e) {
    const width = this.clientWidth;
    const clickX = e.offsetX;
    const duration = audio.duration;
    if (duration) {
        audio.currentTime = (clickX / width) * duration;
    }
}

playBtn.addEventListener('click', togglePlay);
prevBtn.addEventListener('click', prevEpisode);
nextBtn.addEventListener('click', nextEpisode);
skipBackBtn.addEventListener('click', () => skip(-10));
skipFwdBtn.addEventListener('click', () => skip(10));
speedSelect.addEventListener('change', setSpeed);
audio.addEventListener('timeupdate', updateProgress);
progressContainer.addEventListener('click', setProgress);

copyRssBtn.addEventListener('click', () => {
    navigator.clipboard.writeText(rssUrlText.innerText).then(() => {
        const originalText = copyRssBtn.innerText;
        copyRssBtn.innerText = 'Copied!';
        setTimeout(() => {
            copyRssBtn.innerText = originalText;
        }, 2000);
    });
});

loadEpisode(currentIndex);

/**
 * Tutorial Module
 * Handles the visual onboarding carousel for new users.
 */
export const Tutorial = {
    hasSeenTutorial: false,
    currentSlide: 0,
    slides: [
        {
            title: "Welcome to Midnight Board Review",
            desc: "A premium, focused PM&R study experience. Mastery at your fingertips.",
            img: "tutorial_welcome_1770474264962.png"
        },
        {
            title: "Smart Search & Synonyms",
            desc: "Search for 'TBI' or 'SCI' and the app understands exactly what you mean. Matches are highlighted for clarity.",
            img: "tutorial_search_demo_1770474285266.png"
        },
        {
            title: "Never Lose Your Spot",
            desc: "The app remembers exactly where you left off, even if you close the app or restart your phone.",
            img: "tutorial_persistence_1770474901212.png"
        },
        {
            title: "Jump to Any Chapter",
            desc: "Use the category tabs to instantly filter 60+ hours of content by high-yield board topics.",
            img: "tutorial_categories_1770474913238.png"
        },
        {
            title: "Mastery Badges",
            desc: "Listen to an episode multiple times to earn gold mastery badges. Right-click any episode to manually add a level.",
            img: "tutorial_badges_1770474699164.png"
        },
        {
            title: "Listen Anywhere",
            desc: "Copy the Feed URL to follow the board review on Apple Podcasts or your favorite podcatcher.",
            img: "tutorial_podcast_sync_1770474296691.png"
        },
        {
            title: "Add to Home Screen",
            desc: "For the best experience, add the app to your home screen. It keeps your progress and badges safe.",
            img: "tutorial_home_screen_fixed_1770474317036.png"
        }
    ],

    init() {
        this.hasSeenTutorial = localStorage.getItem('has_seen_tutorial_v1.2') === 'true';
        if (!this.hasSeenTutorial) {
            this.show();
        }
    },

    show() {
        const modal = document.getElementById('tutorial-modal');
        if (!modal) return;

        this.currentSlide = 0;
        this.renderSlide();
        modal.classList.add('visible');
    },

    hide() {
        const modal = document.getElementById('tutorial-modal');
        if (modal) {
            modal.classList.remove('visible');
            localStorage.setItem('has_seen_tutorial_v1.2', 'true');
            this.hasSeenTutorial = true;
        }
    },

    next() {
        if (this.currentSlide < this.slides.length - 1) {
            this.currentSlide++;
            this.renderSlide();
        } else {
            this.hide();
        }
    },

    prev() {
        if (this.currentSlide > 0) {
            this.currentSlide--;
            this.renderSlide();
        }
    },

    renderSlide() {
        const slide = this.slides[this.currentSlide];
        const container = document.getElementById('tutorial-content');
        const nextBtn = document.getElementById('tutorial-next');
        const prevBtn = document.getElementById('tutorial-prev');
        const dots = document.getElementById('tutorial-dots');

        if (!container) return;

        // Note: Images are in the appDataDir/brain/conversation-id folder. 
        // For the web app to see them, they need to be accessible.
        // In this environment, we assume the user will place them in /assets/ or similar.
        // I will use placeholders/paths that assume they are in the root for now, 
        // but the user might need to move them.

        container.innerHTML = `
            <div class="tutorial-slide-content">
                <img src="${slide.img}" alt="${slide.title}" class="tutorial-img">
                <h3>${slide.title}</h3>
                <p>${slide.desc}</p>
            </div>
        `;

        if (prevBtn) prevBtn.style.visibility = this.currentSlide === 0 ? 'hidden' : 'visible';
        if (nextBtn) nextBtn.innerText = this.currentSlide === this.slides.length - 1 ? "Finish" : "Next";

        if (dots) {
            dots.innerHTML = this.slides.map((_, i) => `<div class="dot ${i === this.currentSlide ? 'active' : ''}"></div>`).join('');
        }
    }
};

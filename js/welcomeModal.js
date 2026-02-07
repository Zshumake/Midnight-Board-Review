
export const WelcomeModal = {
    init() {
        this.injectStyles();
        this.injectHtml();
        this.setupEvents();
        this.checkFirstVisit();
    },

    injectStyles() {
        const style = document.createElement('style');
        style.textContent = `
            /* Welcome Modal & Info Button Styles */
            .info-btn {
                position: absolute;
                right: 0;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                color: var(--accent-gold);
                cursor: pointer;
                padding: 5px;
                opacity: 0.8;
                transition: opacity 0.2s;
            }
            .info-btn:hover { 
                opacity: 1; 
                transform: translateY(calc(-50% - 2px));
            }

            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(10, 10, 10, 0.85);
                backdrop-filter: blur(8px);
                z-index: 2000;
                display: flex;
                align-items: center;
                justify-content: center;
                opacity: 0;
                pointer-events: none;
                transition: opacity 0.3s ease;
            }

            .modal-overlay.active {
                opacity: 1;
                pointer-events: auto;
            }

            .modal-glass-card {
                background: rgba(30, 30, 30, 0.65);
                border: 1px solid rgba(217, 119, 6, 0.4);
                box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5), inset 0 0 0 1px rgba(255, 255, 255, 0.05);
                border-radius: 12px;
                padding: 3rem;
                max-width: 600px;
                width: 90%;
                max-height: 90vh;
                overflow-y: auto;
                transform: translateY(20px);
                transition: transform 0.3s cubic-bezier(0.18, 0.89, 0.32, 1.28);
            }

            .modal-overlay.active .modal-glass-card {
                transform: translateY(0);
            }

            .modal-header h2 {
                font-family: 'Merriweather', serif;
                color: var(--accent-gold);
                font-size: 1.8rem;
                margin-bottom: 0.5rem;
                text-align: center;
                text-shadow: 0 2px 4px rgba(0,0,0,0.3);
            }

            .modal-subtitle {
                display: block;
                text-align: center;
                font-family: 'Lato', sans-serif;
                color: var(--text-muted);
                font-size: 0.9rem;
                letter-spacing: 0.1em;
                text-transform: uppercase;
                margin-bottom: 2rem;
                border-bottom: 1px solid rgba(255,255,255,0.1);
                padding-bottom: 1.5rem;
            }

            .modal-body p {
                font-size: 1.05rem;
                line-height: 1.7;
                color: #e5e5e5;
                margin-bottom: 1.5rem;
            }

            .feature-list {
                list-style: none;
                padding: 0;
                margin: 2rem 0;
            }

            .feature-list li {
                margin-bottom: 1.2rem;
                display: flex;
                align-items: flex-start;
                gap: 1rem;
            }

            .feature-icon {
                color: var(--accent-gold);
                flex-shrink: 0;
                margin-top: 4px;
            }

            .feature-text strong {
                color: var(--accent-gold-light);
                display: block;
                margin-bottom: 2px;
                font-family: 'Merriweather', serif;
            }

            .feature-text {
                font-size: 0.95rem;
                color: #d1d1d1;
                line-height: 1.5;
            }

            .modal-footer {
                margin-top: 2.5rem;
                text-align: center;
            }

            .start-btn {
                background: linear-gradient(135deg, var(--accent-gold) 0%, var(--accent-orange) 100%);
                color: #000;
                font-family: 'Lato', sans-serif;
                font-weight: 800;
                text-transform: uppercase;
                letter-spacing: 0.15em;
                padding: 1rem 3rem;
                border-radius: 50px;
                border: none;
                cursor: pointer;
                transition: all 0.2s ease;
                box-shadow: 0 4px 15px rgba(217, 119, 6, 0.4);
                font-size: 0.9rem;
            }

            .start-btn:hover {
                transform: translateY(-2px) scale(1.02);
                box-shadow: 0 6px 20px rgba(217, 119, 6, 0.6);
            }

            .credits {
                margin-top: 1.5rem;
                font-size: 0.8rem;
                color: var(--text-muted);
                opacity: 0.6;
            }
        `;
        document.head.appendChild(style);
    },

    injectHtml() {
        // Inject Info Button into Header
        const headerContainer = document.querySelector('header .header-content') || document.querySelector('header');
        // Ensure header has relative positioning for absolute button
        if (headerContainer) {
            if (headerContainer.style.position !== 'relative') {
                headerContainer.style.position = 'relative';
            }
            if (!document.getElementById('info-btn')) {
                const btn = document.createElement('button');
                btn.id = 'info-btn';
                btn.className = 'info-btn';
                btn.title = 'About & Instructions';
                btn.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>`;
                headerContainer.appendChild(btn);
            }
        }

        // Inject Modal
        const modal = document.createElement('div');
        modal.id = 'welcome-modal';
        modal.className = 'modal-overlay';
        modal.innerHTML = `
            <div class="modal-glass-card">
                <div class="modal-header">
                    <h2>Midnight Board Review</h2>
                    <span class="modal-subtitle">Study Smarter, Not Longer</span>
                </div>
                <div class="modal-body">
                    <p>
                        Welcome to the new <strong>Midnight Board Review</strong>—a premium study platform designed for the modern PM&R resident. 
                        This tool transforms over 60 hours of high-yield audio into a surgical study experience, allowing you to master complex topics during commutes, gym sessions, or clinic downtime.
                    </p>
                    
                    <ul class="feature-list">
                        <li>
                            <div class="feature-icon">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                            </div>
                            <div class="feature-text">
                                <strong>Searchable Clinical Pearls</strong>
                                Instantly find specific breakdowns. Searching for "EMG" or "SCI" filters 120+ episodes to exactly what you need to hear right now.
                            </div>
                        </li>
                        <li>
                            <div class="feature-icon">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 11a9 9 0 0 1 9 9"></path><path d="M4 4a16 16 0 0 1 16 16"></path><circle cx="5" cy="19" r="1"></circle></svg>
                            </div>
                            <div class="feature-text">
                                <strong>Apple Podcasts & RSS Sync</strong>
                                Take the library with you. Use the secure RSS feed to follow the show in Apple Podcasts or any professional podcast player.
                            </div>
                        </li>
                        <li>
                            <div class="feature-icon">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>
                            </div>
                            <div class="feature-text">
                                <strong>Integrated Glassmorphism Player</strong>
                                A custom, low-latency audio engine with interactive progress tracking, designed to look stunning on both desktop and mobile.
                            </div>
                        </li>
                    </ul>

                    <div class="modal-footer">
                        <button id="close-modal-btn" class="start-btn">Begin Studying</button>
                        <div class="credits">Curated by <strong>Zach Shumake</strong> — A Board Prep Utility.</div>
                    </div>
                </div>
            </div>
        `;
        document.body.appendChild(modal);
    },

    setupEvents() {
        const modal = document.getElementById('welcome-modal');
        const closeBtn = document.getElementById('close-modal-btn');
        const infoBtn = document.getElementById('info-btn');
        const KEY = 'welcomeSeen_v1';

        const closeModal = () => {
            localStorage.setItem(KEY, 'true');
            modal.classList.remove('active');
        };

        const openModal = () => {
            modal.classList.add('active');
        };

        if (closeBtn) closeBtn.onclick = closeModal;
        if (infoBtn) infoBtn.onclick = openModal;

        // Close on clicking outside the card
        modal.onclick = (e) => {
            if (e.target === modal) closeModal();
        };
    },

    checkFirstVisit() {
        const KEY = 'welcomeSeen_v1';
        if (!localStorage.getItem(KEY)) {
            // Small delay to allow fade in transition to look nice after load
            setTimeout(() => {
                document.getElementById('welcome-modal').classList.add('active');
            }, 500);
        }
    }
};

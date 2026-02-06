
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
            .info-btn:hover { opacity: 1; }

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
                        This site hosts a comprehensive 120-episode (60-hour) audio breakdown of the <strong>PM&R Board Review</strong>. 
                        Whether you're prepping for SAEs, Part 1, or just surviving your rotation, this tool turns your "dead time"—commutes, gym sessions, pre-charting—into high-yield study time.
                    </p>
                    
                    <ul class="feature-list">
                        <li>
                            <div class="feature-icon">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                            </div>
                            <div class="feature-text">
                                <strong>Search Anything</strong>
                                Type "neurogenic bowel" or "L5 radiculopathy" to instantly find the exact clinical pearls you need.
                            </div>
                        </li>
                        <li>
                            <div class="feature-icon">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect x="5" y="2" width="14" height="20" rx="2" ry="2"></rect><line x1="12" y1="18" x2="12.01" y2="18"></line></svg>
                            </div>
                            <div class="feature-text">
                                <strong>Go Mobile</strong>
                                Use "Add to Home Screen" on your phone for a full app experience, or sync via RSS to your favorite podcast player.
                            </div>
                        </li>
                        <li>
                            <div class="feature-icon">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg>
                            </div>
                            <div class="feature-text">
                                <strong>Full Coverage</strong>
                                Content is organized by chapter to mirror the "Red Book" flow perfectly.
                            </div>
                        </li>
                    </ul>

                    <div class="modal-footer">
                        <button id="close-modal-btn" class="start-btn">Let's Study</button>
                        <div class="credits">Created by <strong>Zach Shumake</strong> — For residents, by a resident.</div>
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

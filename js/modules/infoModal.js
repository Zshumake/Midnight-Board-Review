/**
 * Info Modal Module
 * Dynamically injects and manages the Info/Features modal.
 */
export const InfoModal = {
    modalId: 'info-modal',
    storageKey: 'has_seen_info_v1.0',

    init() {
        // 1. Inject Styles
        this.injectStyles();

        // 2. Inject HTML if needed
        if (!document.getElementById(this.modalId)) {
            this.injectModal();
        }

        // 3. Check Auto-Show
        const hasSeen = localStorage.getItem(this.storageKey) === 'true';
        if (!hasSeen) {
            // Small delay to let page settle
            setTimeout(() => this.show(), 1000);
        }

        // 4. Setup Close Listener (Delegate)
        document.addEventListener('info-close', () => this.hide());

        // 5. Explicitly handle the 'Let's Study' button here if not using onclick attribute
        document.addEventListener('click', (e) => {
            if (e.target && e.target.id === 'close-modal-btn') {
                this.hide();
            }
        });
    },

    injectStyles() {
        const styleId = 'info-modal-styles';
        if (document.getElementById(styleId)) return;

        const style = document.createElement('style');
        style.id = styleId;
        style.textContent = `
            /* Welcome Modal & Info Button Styles (Migrated) */
            .modal-overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(10, 10, 10, 0.85);
                backdrop-filter: blur(8px);
                z-index: 3000;
                display: flex;
                align-items: center;
                justify-content: center;
                opacity: 0;
                pointer-events: none;
                transition: opacity 0.3s ease;
            }

            .modal-overlay.visible {
                opacity: 1;
                pointer-events: auto;
            }

            .modal-glass-card {
                background: rgba(30, 30, 30, 0.85); /* Slightly darker for readability */
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

            .modal-overlay.visible .modal-glass-card {
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
                margin-top: 2rem;
                font-size: 0.85rem;
                color: var(--text-muted);
                opacity: 0.8;
                font-family: 'Lato', sans-serif;
                letter-spacing: 0.05em;
                position: relative;
                padding-top: 1rem;
            }
            
            .credits::before {
                content: '';
                display: block;
                width: 40px;
                height: 2px;
                background: var(--accent-gold);
                margin: 0 auto 10px;
                opacity: 0.3;
            }

            .cool-credit {
               background: -webkit-linear-gradient(45deg, #a8a29e, #ffffff);
               -webkit-background-clip: text;
               -webkit-text-fill-color: transparent;
               font-weight: 700;
            }
        `;
        document.head.appendChild(style);
    },

    injectModal() {
        const modalHTML = `
            <div id="${this.modalId}" class="modal-overlay">
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
                                    <strong>Searchable Pearls</strong>
                                    Use the search bar to instantly find a specific podcast that discusses topics like "neurogenic bowel" or "autonomic dysreflexia."
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
                                    <strong>Advanced Mastering</strong>
                                    Earn gold badges by listening and tracking your progress across all devices.
                                </div>
                            </li>
                        </ul>

                        <div class="modal-footer">
                            <button id="close-modal-btn" class="start-btn">Let's Study</button>
                            <div class="credits">
                                Made by <span class="cool-credit">Zachary Shumaker</span><br>
                                Made for residents, by a resident.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        `;
        document.body.insertAdjacentHTML('beforeend', modalHTML);
    },

    show() {
        const modal = document.getElementById(this.modalId);
        if (modal) modal.classList.add('visible');
    },

    hide() {
        const modal = document.getElementById(this.modalId);
        if (modal) {
            modal.classList.remove('visible');
            localStorage.setItem(this.storageKey, 'true');
        }
    }
};

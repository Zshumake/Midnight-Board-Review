/**
 * Report Issue Modal Module
 * Allows users to report issues with specific episodes via email.
 */
export const ReportModal = {
    modalId: 'report-modal',
    email: 'shumaker.zach865@gmail.com',

    init(episodes) {
        this.injectStyles();
        if (!document.getElementById(this.modalId)) {
            this.injectModal(episodes);
        }
        this.setupEvents();
    },

    injectStyles() {
        const styleId = 'report-modal-styles';
        if (document.getElementById(styleId)) return;

        const style = document.createElement('style');
        style.id = styleId;
        style.textContent = `
            /* Report Modal Styles */
            .report-modal {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.85); /* Darker backdrop */
                backdrop-filter: blur(5px);
                z-index: 3100; /* Higher than Info Modal */
                display: flex;
                align-items: center;
                justify-content: center;
                opacity: 0;
                pointer-events: none;
                transition: opacity 0.3s ease;
            }

            .report-modal.visible {
                opacity: 1;
                pointer-events: auto;
            }

            .report-card {
                background: var(--bg-card);
                border: 1px solid var(--border-gold);
                box-shadow: var(--shadow-warm);
                border-radius: 12px;
                padding: 2rem;
                width: 90%;
                max-width: 500px;
                display: flex;
                flex-direction: column;
                gap: 1.5rem;
                transform: translateY(20px);
                transition: transform 0.3s cubic-bezier(0.18, 0.89, 0.32, 1.28);
            }

            .report-modal.visible .report-card {
                transform: translateY(0);
            }

            .report-card h3 {
                font-family: 'Merriweather', serif;
                color: var(--accent-gold);
                text-align: center;
                text-align: center;
                margin: 0;
            }

            .report-instructions {
                font-size: 0.9rem;
                color: var(--text-muted);
                text-align: center;
                line-height: 1.4;
                margin: -0.5rem 0 0.5rem 0;
            }

            .report-form {
                display: flex;
                flex-direction: column;
                gap: 1rem;
            }

            .form-group {
                display: flex;
                flex-direction: column;
                gap: 0.5rem;
            }

            .form-group label {
                color: var(--text-muted);
                font-size: 0.9rem;
                font-weight: 700;
            }

            .form-control {
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(255, 255, 255, 0.1);
                color: var(--text-main);
                padding: 10px;
                border-radius: 6px;
                font-family: 'Lato', sans-serif;
                font-size: 1rem;
            }

            .form-control:focus {
                outline: none;
                border-color: var(--accent-gold);
                background: rgba(255, 255, 255, 0.1);
            }

            textarea.form-control {
                resize: vertical;
                min-height: 100px;
            }

            .report-actions {
                display: flex;
                gap: 1rem;
                margin-top: 0.5rem;
            }

            .btn-report {
                flex: 1;
                padding: 12px;
                border: none;
                border-radius: 6px;
                font-weight: 700;
                cursor: pointer;
                transition: all 0.2s;
            }

            .btn-cancel {
                background: rgba(255, 255, 255, 0.1);
                color: var(--text-main);
            }

            .btn-submit {
                background: var(--accent-gold);
                color: #000;
            }

            .btn-gmail {
                background: #DB4437; /* Google Red */
                color: white;
            }

            .btn-submit:hover {
                background: var(--accent-gold-light);
                transform: translateY(-1px);
            }
             .btn-cancel:hover {
                background: rgba(255, 255, 255, 0.2);
            }
            .btn-gmail:hover {
                background: #c53929;
                transform: translateY(-1px);
            }
        `;
        document.head.appendChild(style);
    },

    injectModal(episodes) {
        // Generate options for dropdown
        const options = episodes.map(ep => `<option value="${ep.title.replace(/"/g, '&quot;')}">${ep.title}</option>`).join('');

        const modalHTML = `
            <div id="${this.modalId}" class="report-modal">
                <div class="report-card">
                    <h3>Report Issue</h3>
                    <p class="report-instructions">
                        Report audio glitches, incorrect medical info, or pronunciation errors (e.g. AI butchering terms).<br>
                        Your feedback helps improve the quality for everyone!
                    </p>
                    <form id="report-form" class="report-form">
                        <div class="form-group">
                            <label for="report-type">Issue Type</label>
                            <select id="report-type" class="form-control" required>
                                <option value="" disabled selected>Select issue type...</option>
                                <option value="Audio Glitch">Audio Glitch / Cut Out</option>
                                <option value="Pronunciation Error">Speaker Pronunciation Error</option>
                                <option value="Medical Inaccuracy">Incorrect Medical Info</option>
                                <option value="App Bug">App Bug / Crash</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="report-episode">Episode</label>
                            <select id="report-episode" class="form-control" required>
                                <option value="" disabled selected>Select an episode...</option>
                                <option value="General App Issue">General App Issue (No specific episode)</option>
                                ${options}
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="report-desc">What's wrong?</label>
                            <textarea id="report-desc" class="form-control" placeholder="Audio cuts out, wrong title, etc..." required></textarea>
                        </div>

                        <div class="report-actions">
                            <button type="button" id="report-cancel" class="btn-report btn-cancel">Cancel</button>
                            <button type="button" id="report-gmail" class="btn-report btn-gmail">Open in Gmail</button>
                            <button type="submit" class="btn-report btn-submit">Default Email</button>
                        </div>
                    </form>
                </div>
            </div>
        `;
        document.body.insertAdjacentHTML('beforeend', modalHTML);
    },

    setupEvents() {
        const form = document.getElementById('report-form');
        const cancelBtn = document.getElementById('report-cancel');
        const gmailBtn = document.getElementById('report-gmail');
        const modal = document.getElementById(this.modalId);

        if (cancelBtn) cancelBtn.onclick = () => this.hide();
        if (gmailBtn) gmailBtn.onclick = () => this.openGmail();

        // Close on backdrop click
        if (modal) {
            modal.onclick = (e) => {
                if (e.target === modal) this.hide();
            };
        }

        if (form) {
            form.onsubmit = (e) => {
                e.preventDefault();
                this.sendEmail();
            };
        }
    },

    show(currentEpisodeTitle = null) {
        const modal = document.getElementById(this.modalId);
        const select = document.getElementById('report-episode');

        if (currentEpisodeTitle && select) {
            // Try to select current episode
            // Normalize for loose matching if needed
            select.value = currentEpisodeTitle;
        }

        if (modal) modal.classList.add('visible');
    },

    hide() {
        const modal = document.getElementById(this.modalId);
        if (modal) modal.classList.remove('visible');
    },

    sendEmail() {
        const episode = document.getElementById('report-episode').value;
        const type = document.getElementById('report-type').value;
        const description = document.getElementById('report-desc').value;

        if (!episode || !type || !description) return;

        const { subject, body } = this.buildEmailContent(episode, type, description);
        window.location.href = `mailto:${this.email}?subject=${subject}&body=${body}`;
        setTimeout(() => this.hide(), 500);
    },

    openGmail() {
        const episode = document.getElementById('report-episode').value;
        const type = document.getElementById('report-type').value;
        const description = document.getElementById('report-desc').value;

        if (!episode || !type || !description) {
            alert('Please fill out all fields first.');
            return;
        }

        const { subject, body } = this.buildEmailContent(episode, type, description);
        const gmailUrl = `https://mail.google.com/mail/?view=cm&fs=1&to=${this.email}&su=${subject}&body=${body}`;

        window.open(gmailUrl, '_blank');
        setTimeout(() => this.hide(), 500);
    },

    buildEmailContent(episode, type, description) {
        let subjectText = `Issue Report: ${type} - ${episode}`;
        if (episode === 'General App Issue') {
            subjectText = `Issue Report: ${type} (General App Issue)`;
        }

        const subject = encodeURIComponent(subjectText);
        const body = encodeURIComponent(`Episode: ${episode}\nIssue Type: ${type}\n\nDescription:\n${description}\n\n(Sent from Midnight Board Review App)`);

        return { subject, body };
    }
};

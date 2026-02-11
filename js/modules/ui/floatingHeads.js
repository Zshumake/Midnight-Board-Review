/**
 * FloatingHeads.js
 * Manages the floating Bockenek heads background animation.
 * - Spawns N heads
 * - Handles physics (velocity, wall bounce, head-to-head bounce)
 * - Manages DOM elements
 */

export const FloatingHeads = {
    container: null,
    heads: [],
    animationId: null,
    HEAD_COUNT: 8,
    HEAD_SIZE: 60,
    SPEED: 1.5, // Pixels per frame approx

    init() {
        if (this.container) return; // Already running

        // Create Container
        this.container = document.createElement('div');
        this.container.id = 'bockenek-heads-container';
        Object.assign(this.container.style, {
            position: 'fixed',
            top: '0',
            left: '0',
            width: '100%',
            height: '100%',
            pointerEvents: 'none', // Click-through
            zIndex: '0', // Behind content (assuming content is z-index > 0)
            overflow: 'hidden'
        });
        document.body.prepend(this.container);

        // Spawn Heads
        for (let i = 0; i < this.HEAD_COUNT; i++) {
            this.heads.push(this._createHead());
        }

        // Start Loop
        this._animate();
    },

    destroy() {
        if (this.animationId) {
            cancelAnimationFrame(this.animationId);
            this.animationId = null;
        }
        if (this.container) {
            this.container.remove();
            this.container = null;
        }
        this.heads = [];
    },

    _createHead() {
        const el = document.createElement('img');
        el.src = 'Bockenek.png';
        el.className = 'floating-head';
        Object.assign(el.style, {
            position: 'absolute',
            width: `${this.HEAD_SIZE}px`,
            height: `${this.HEAD_SIZE}px`,
            borderRadius: '50%',
            opacity: '0.4', // Subtle
            filter: 'drop-shadow(0 0 10px rgba(217, 119, 6, 0.5))'
        });
        this.container.appendChild(el);

        // Random Position & Velocity
        const startX = Math.random() * (window.innerWidth - this.HEAD_SIZE);
        const startY = Math.random() * (window.innerHeight - this.HEAD_SIZE);
        const angle = Math.random() * Math.PI * 2;

        return {
            el,
            x: startX,
            y: startY,
            vx: Math.cos(angle) * this.SPEED,
            vy: Math.sin(angle) * this.SPEED
        };
    },

    _animate() {
        const maxX = window.innerWidth - this.HEAD_SIZE;
        const maxY = window.innerHeight - this.HEAD_SIZE;

        this.heads.forEach((head, i) => {
            // Update Position
            head.x += head.vx;
            head.y += head.vy;

            // Wall Collision
            if (head.x <= 0 || head.x >= maxX) {
                head.vx *= -1;
                head.x = Math.max(0, Math.min(head.x, maxX));
            }
            if (head.y <= 0 || head.y >= maxY) {
                head.vy *= -1;
                head.y = Math.max(0, Math.min(head.y, maxY));
            }

            // Head-to-Head Collision (Simple Distance Check)
            for (let j = i + 1; j < this.heads.length; j++) {
                const other = this.heads[j];
                const dx = other.x - head.x;
                const dy = other.y - head.y;
                const dist = Math.sqrt(dx * dx + dy * dy);

                if (dist < this.HEAD_SIZE) {
                    // Elastic Bounce (fileswap velocities)
                    const tempVx = head.vx;
                    const tempVy = head.vy;
                    head.vx = other.vx;
                    head.vy = other.vy;
                    other.vx = tempVx;
                    other.vy = tempVy;

                    // Separate to prevent sticking
                    const angle = Math.atan2(dy, dx);
                    const push = (this.HEAD_SIZE - dist) / 2 + 1;
                    head.x -= Math.cos(angle) * push;
                    head.y -= Math.sin(angle) * push;
                    other.x += Math.cos(angle) * push;
                    other.y += Math.sin(angle) * push;
                }
            }

            // Apply to DOM
            head.el.style.transform = `translate(${head.x}px, ${head.y}px)`;
        });

        this.animationId = requestAnimationFrame(() => this._animate());
    }
};

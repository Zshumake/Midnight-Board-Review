import 'package:flutter/material.dart';
import '../../utils/theme.dart';

class AppChip extends StatefulWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? accentColor;
  final Widget? leading;
  final bool compact;

  const AppChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.accentColor,
    this.leading,
    this.compact = false,
  });

  @override
  State<AppChip> createState() => _AppChipState();
}

class _AppChipState extends State<AppChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.93).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = widget.accentColor ?? AppColors.accentAmber;
    final hPad = widget.compact ? 8.0 : 12.0;
    final vPad = widget.compact ? 4.0 : 6.0;
    final fontSize = widget.compact ? 11.0 : 12.0;

    return Semantics(
      button: true,
      selected: widget.selected,
      label: widget.label,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTapDown: (_) => _controller.forward(),
          onTapUp: (_) {
            _controller.reverse();
            widget.onTap();
          },
          onTapCancel: () => _controller.reverse(),
          child: AnimatedBuilder(
            animation: _scale,
            builder: (context, child) => Transform.scale(
              scale: _scale.value,
              child: child,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
              decoration: BoxDecoration(
                color: widget.selected
                    ? accent.withValues(alpha: 0.15)
                    : _hovering
                        ? AppColors.bgCardHover
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(Radii.pill),
                border: Border.all(
                  color: widget.selected
                      ? accent.withValues(alpha: 0.7)
                      : _hovering
                          ? AppColors.borderMedium
                          : AppColors.borderSubtle,
                  width: widget.selected ? 1.5 : 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.leading != null) ...[
                    widget.leading!,
                    const SizedBox(width: 3),
                  ],
                  Text(
                    widget.label,
                    style: TextStyle(
                      color:
                          widget.selected ? accent : AppColors.textSecondary,
                      fontSize: fontSize,
                      fontWeight: widget.selected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      letterSpacing: widget.selected ? 0.2 : 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

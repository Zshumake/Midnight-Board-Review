import 'package:flutter/material.dart';
import '../../utils/theme.dart';

class AppIconButton extends StatefulWidget {
  final IconData icon;
  final double size;
  final Color? color;
  final VoidCallback? onPressed;
  final String? tooltip;
  final bool prominent;

  const AppIconButton({
    super.key,
    required this.icon,
    this.size = 28,
    this.color,
    this.onPressed,
    this.tooltip,
    this.prominent = false,
  });

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scale = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        widget.color ?? AppColors.textSecondary;

    Widget button = AnimatedBuilder(
      animation: _scale,
      builder: (context, child) => Transform.scale(
        scale: _scale.value,
        child: child,
      ),
      child: Icon(
        widget.icon,
        size: widget.size,
        color: effectiveColor,
      ),
    );

    if (widget.prominent) {
      button = Container(
        padding: const EdgeInsets.all(Spacing.md),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppColors.amberGradient,
          boxShadow: AppShadows.glow,
        ),
        child: AnimatedBuilder(
          animation: _scale,
          builder: (context, child) => Transform.scale(
            scale: _scale.value,
            child: child,
          ),
          child: Icon(
            widget.icon,
            size: widget.size,
            color: Colors.white,
          ),
        ),
      );
    }

    Widget result = GestureDetector(
      onTapDown: (_) => _scaleController.forward(),
      onTapUp: (_) {
        _scaleController.reverse();
        widget.onPressed?.call();
      },
      onTapCancel: () => _scaleController.reverse(),
      child: button,
    );

    if (widget.tooltip != null) {
      result = Tooltip(message: widget.tooltip!, child: result);
    }

    return Semantics(
      button: true,
      label: widget.tooltip,
      child: result,
    );
  }
}

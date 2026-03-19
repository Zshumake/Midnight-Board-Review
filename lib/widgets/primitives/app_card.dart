import 'package:flutter/material.dart';
import '../../utils/theme.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool glow;
  final bool gradient;
  final Color? borderColor;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.glow = false,
    this.gradient = false,
    this.borderColor,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      gradient: gradient ? AppColors.cardGradient : null,
      color: gradient ? null : AppColors.bgCard,
      borderRadius: BorderRadius.circular(Radii.lg),
      border: Border.all(
        color: borderColor ?? AppColors.borderSubtle,
        width: 1,
      ),
      boxShadow: glow ? AppShadows.glow : AppShadows.card,
    );

    final container = Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: Spacing.lg),
      padding: padding ?? const EdgeInsets.all(Spacing.xl),
      decoration: decoration,
      child: child,
    );

    if (onTap != null || onLongPress != null) {
      return GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: container,
      );
    }
    return container;
  }
}

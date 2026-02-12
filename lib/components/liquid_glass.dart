import 'dart:ui';
import 'package:flutter/material.dart';

/// Widget que simula el efecto Liquid Glass translúcido de iOS 26.
class LiquidGlass extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final Color? color;
  final BorderRadius? borderRadius;
  final BoxBorder? border;

  const LiquidGlass({
    super.key,
    required this.child,
    this.blur = 30,
    this.opacity = 0.25,
    this.color,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(20),
      child: Stack(
        children: [
          // Fondo borroso
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(),
          ),
          // Capa translúcida con color
          Container(
            decoration: BoxDecoration(
              color: (color ?? Colors.white).withValues(alpha: opacity),
              borderRadius: borderRadius ?? BorderRadius.circular(20),
              border: border,
            ),
          ),
          // Contenido
          child,
        ],
      ),
    );
  }
}

import 'dart:math' as math;
import 'package:flutter/material.dart';

class JumpingDotsLoader extends StatefulWidget {
  final Color dotColor;
  final double dotSize;
  final Duration duration;

  const JumpingDotsLoader({
    super.key,
    this.dotColor = Colors.blue,
    this.dotSize = 10.0,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  State<JumpingDotsLoader> createState() => _JumpingDotsLoaderState();
}

class _JumpingDotsLoaderState extends State<JumpingDotsLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animationOne;
  late Animation<double> _animationTwo;
  late Animation<double> _animationThree;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat(); // Repite la animación indefinidamente

    // Definiciones de animaciones con retrasos y curvas
    _animationOne = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOut),
      ),
    );

    _animationTwo = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.8, curve: Curves.easeOut),
      ),
    );

    _animationThree = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.9, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildDot(_animationOne),
              SizedBox(width: widget.dotSize / 2),
              _buildDot(_animationTwo),
              SizedBox(width: widget.dotSize / 2),
              _buildDot(_animationThree),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDot(Animation<double> animation) {
    // Mapea el valor de animación (0.0 a 1.0) a un desplazamiento vertical (0.0 a -20.0)
    final double displacement = math.sin(animation.value * math.pi) * 20.0;

    return Transform.translate(
      offset: Offset(0, -displacement),
      child: Container(
        width: widget.dotSize,
        height: widget.dotSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.dotColor,
        ),
      ),
    );
  }
}

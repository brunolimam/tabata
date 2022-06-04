import 'package:flutter/material.dart';

class GestureTap extends StatefulWidget {
  const GestureTap({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onPressed;

  @override
  State<StatefulWidget> createState() => GestureTapState();
}

class GestureTapState extends State<GestureTap> {
  double opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        opacity = 0.5;
        setState(() {});
      },
      onTapUp: (details) {
        opacity = 1.0;
        setState(() {});
      },
      onTapCancel: () {
        opacity = 1.0;
        setState(() {});
      },
      onTap: widget.onPressed,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 150),
        opacity: opacity,
        child: widget.child,
      ),
    );
  }
}

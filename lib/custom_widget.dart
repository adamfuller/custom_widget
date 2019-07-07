library custom_widget;

import 'package:flutter/material.dart';

part 'easy_painter.dart';

class CustomWidget extends StatefulWidget {
  /// Method where painting should be done
  final Function(Canvas, Size, double) onPaint;
  /// Height and width of the widget if null, this expands to fill parent
  final double size;
  /// Length of time for the widget to reanimate
  final Duration duration;

  CustomWidget({
    @required this.onPaint,
    this.size,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<StatefulWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  _CustomWidgetState();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.linear),
      ),
    )..addListener(() => setState(() {}));

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: widget.size != null ? SizedBox.fromSize(
        size: Size.square(widget.size),
      ): SizedBox.expand(),
      painter: EasyPainter(
        onPaint: widget.onPaint ?? () {},
        size: widget.size,
        animation: _animation,
      ),
    );
  }
}


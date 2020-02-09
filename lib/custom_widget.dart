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

  /// Does the widget constantly repaint
  final bool doesRepaint;

  /// Callback when the user presses down on the widget
  ///
  /// Calculated considering the top left corner of the CustomWidget being 0,0
  /// and the bottom right corner being `size.width`,`size.height`
  ///
  /// onPressDown(xPosition,yPosition)
  final void Function(double, double) onPointerDown;

  /// Callback when the user releases their press on the widget
  ///
  /// Calculated considering the top left corner of the CustomWidget being 0,0
  /// and the bottom right corner being `size.width`,`size.height`
  ///
  /// onPressRelease(xPosition,yPosition)
  final void Function(double, double) onPointerUp;

  /// Callback when the user drags their finger/cursor after a press down
  ///
  /// Calculated considering the top left corner of the CustomWidget being 0,0
  /// and the bottom right corner being `size.width`,`size.height`
  ///
  /// onDrag(xPosition,yPosition)
  final void Function(double, double) onPointerMove;

  CustomWidget({
    @required this.onPaint,
    this.size,
    this.duration = const Duration(seconds: 2),
    this.doesRepaint = true,
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerMove,
  });

  @override
  State<StatefulWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  GlobalKey _key = GlobalKey();

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

    if (widget.doesRepaint) _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: widget.onPointerMove != null
          ? (PointerEvent event) {
              RenderBox box = _key.currentContext.findRenderObject();
              Offset offset = box.globalToLocal(event.position);
              widget.onPointerMove(offset.dx, offset.dy);
            }
          : null,
      onPointerDown: widget.onPointerDown != null
          ? (PointerEvent event) {
              RenderBox box = _key.currentContext.findRenderObject();
              Offset offset = box.globalToLocal(event.position);
              widget.onPointerDown(offset.dx, offset.dy);
            }
          : null,
      onPointerUp: widget.onPointerUp != null
          ? (PointerEvent event) {
              RenderBox box = _key.currentContext.findRenderObject();
              Offset offset = box.globalToLocal(event.position);
              widget.onPointerUp(offset.dx, offset.dy);
            }
          : null,
      child: CustomPaint(
        key: _key,
        child: widget.size != null
            ? SizedBox.fromSize(
                size: Size.square(widget.size),
              )
            : SizedBox.expand(),
        painter: EasyPainter(
          onPaint: widget.onPaint ?? () {},
          size: widget.size,
          animation: _animation,
        ),
      ),
    );
  }
}

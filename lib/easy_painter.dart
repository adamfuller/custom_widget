part of custom_widget;

class EasyPainter extends CustomPainter {
  /// Function to be called when painting the widget
  final Function(Canvas, Size, double) onPaint;
  /// Width and Height of the CustomPainter
  final double size;
  /// Animation Listenable used to keep track of progress in onPaint
  final Animation<double> animation;

  EasyPainter({
    @required this.onPaint,
    @required this.size,
    @required this.animation,
  });

  /// Return a CustomPaint widget which is a [size]x[size] square
  static CustomPaint customPaint(Function(Canvas, Size, double) onPaint, double size, Animation<double> animation) {
    return CustomPaint(
      child: SizedBox.fromSize(
        size: Size.square(size),
      ),
      painter: EasyPainter(onPaint: (_, __, ___) => onPaint(_, __, ___), size: size, animation: animation),
    );
  }

  @override
  void paint(Canvas canvas, Size size) => this.onPaint(canvas, size, animation.value);

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
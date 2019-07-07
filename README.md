# Custom Widget

A CustomPainter and CustomPaint wrapper that simplifies and streamlines the process of creating 
unique widgets in flutter.

## How to use
The following will produce a widget 50 pixels wide and 50 pixels tall with a white
arc rotating in the center of it.
This arc will complete 1 rotation every 5 seconds

```dart
CustomWidget(
    duration: Duration(seconds: 5),
    size: 50,
    onPaint: (canvas, size, progress) {
        Paint p = Paint();
        p.color = Colors.white;
        p.strokeWidth = 5.0;
        p.style = PaintingStyle.stroke;

        Rect rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 10);

        canvas.drawArc(
            rect,
            2 * progress * 3.14159265,
            3.14159265 / 2,
            false,
            p,
        );
    },
)
```

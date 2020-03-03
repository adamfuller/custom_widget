# Custom Widget v0.1.1

A CustomPainter and CustomPaint wrapper that simplifies and streamlines the process of creating 
unique widgets in Flutter.

## How to install
Add the following to **`pubspec.yaml`**
```yaml
dependencies:
  custom_widget:
    git:
      url: git://github.com/adamfuller/custom_widget.git
```


## How to use

Import the CustomWidget package
```dart
import 'package:custom_widget/custom_widget.dart' as cw;
```
Use CustomWidget as you would any other widget.
The only major difference is its onPaint parameter.


```dart
cw.CustomWidget(
    duration: Duration(seconds: 5),
    size: Size.square(50),
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
Produces the following with a transparent background instead of a black one
</br>
<img src="https://raw.githubusercontent.com/adamfuller/custom_widget/master/example/spinner.gif" width="145px">

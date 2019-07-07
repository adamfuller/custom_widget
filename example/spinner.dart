import 'package:flutter/material.dart';
import 'package:custom_widget/custom_widget.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _getBody()),
    );
  }

  Widget _getBody() {
    Paint p = Paint();
    p.color = Colors.white;
    p.strokeWidth = 5.0;
    p.style = PaintingStyle.stroke;

    return CustomWidget(
      duration: Duration(seconds: 5),
      onPaint: (canvas, size, progress) {
        double radiusUpToSide = size.shortestSide/2 * math.sin(progress * math.pi)-5;

        Rect rect = Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: radiusUpToSide,
        );

        double startAngle = 2 * progress * 3.14159265;
        double sweepAngle = 3.14159265 / 2;

        canvas.drawArc(
          rect,
          startAngle,
          sweepAngle,
          false,
          p,
        );
        
      },
    );
  }
}

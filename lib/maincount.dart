import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    );

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

class _State extends State<MyApp> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animation = Tween(begin: 10.0, end: 10.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CustomPaint Test'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: RaisedButton(
                child: Text('Start/Stop'),
                onPressed: () {
                  if (_animationController.isAnimating) {
                    _animationController.reset();
                  } else {
                    _animationController.repeat();
                  }
                },
              ),
            ),
            Opacity(
              opacity: _animationController.isAnimating ? 1.0 : 0.00,
              child: CustomPaint(
                painter: _CirclePainter(_animation.value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  double radius;

  _CirclePainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    var c = Offset(0, 150.0);
    var paint = Paint()
      ..isAntiAlias = true
      ..color = Colors.blue
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(
      c,
      radius,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

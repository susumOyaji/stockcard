import 'dart:math' as math;
import 'package:flutter/material.dart';

/*
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CountDownTimer(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        accentColor: Colors.red,
      ),
    );
  }
}
*/
class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SafeArea(
      //backgroundColor: Colors.grey,
      child: Column(
        //body:
        children: [
          AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Stack(
                  //alignment: Alignment.bottomRight,
                  children: <Widget>[
                    //Padding(
                    //  padding: EdgeInsets.all(8.0),
                    //  child:
                    //Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    //children: <Widget>[
                    //Expanded(
                    //child:
                    Positioned(
                      //right: 0.0,
                      //top: 20.0,
                      //width: 100.0,
                      //height: 200.0,
                      child: Container(
                        //color: Colors.indigo,
                        child: ButtonTheme(
                          minWidth: 40.0,
                          height: 40.0,
                          child: RaisedButton(
                            child: Text("index",
                                style: TextStyle(
                                    fontSize: 10.0, color: Colors.grey)),
                            color: Colors.orange,
                            shape: CircleBorder(
                              side: BorderSide(
                                color: Colors.black,
                                width: 0.0,
                                style: BorderStyle.solid,
                              ),
                            ),
                            onPressed: () {
                              if (controller.isAnimating)
                                controller.stop();
                              else {
                                controller.reverse(
                                    from: controller.value == 0.0
                                        ? 1.0
                                        : controller.value);
                              }
                              //_asyncEditDialog(context, index);
                            },
                            onLongPress: () {
                              //alertDialog(index);
                            },
                          ),
                        ),
                      ),
                    ),
/*
                    Positioned(
                      //right: 27.0,
                      //top: 320.0,
                      child: ButtonTheme(
                        minWidth: 30.0,
                        height: 30.0,
                        child: RaisedButton(
                          child: Text("index",
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.grey)),
                          color: Colors.purple,
                          shape: CircleBorder(
                            side: BorderSide(
                              color: Colors.black,
                              width: 0.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          onPressed: () {
                            if (controller.isAnimating)
                              controller.stop();
                            else {
                              controller.reverse(
                                  from: controller.value == 0.0
                                      ? 1.0
                                      : controller.value);
                            }
                            //_asyncEditDialog(context, index);
                          },
                          onLongPress: () {
                            //alertDialog(index);
                          },
                        ),
                      ),
                    ),
                    */
                    Positioned(
                      right: 29.0,
                      top: 24.0,
                      child: Align(
                        alignment: FractionalOffset.center,
                        //child: AspectRatio(
                        //  aspectRatio: 1.0,
                        //child: Stack(
                        //children: <Widget>[
                        //Positioned.fill(
                        child: CustomPaint(
                            painter: CustomTimerPainter(
                          animation: controller,
                          backgroundColor: Colors.white,
                          color: themeData.indicatorColor,
                        )),
                        //),
                        //],
                        //),
                      ),
                    ),
                  ],
                  //),
                  /*
                    Positioned(
                      left: 50.0,
                      top: 20.0,
                      child: Align(
                        alignment: FractionalOffset.center,
                        //child: AspectRatio(
                        //  aspectRatio: 1.0,
                        //child: Stack(
                        //children: <Widget>[
                        //Positioned.fill(
                        child: CustomPaint(
                            painter: CustomTimerPainter1(
                          progress: 0.0,
                          startColor: Colors.red,
                          endColor: Colors.yellow,
                          width: 1.0,
                          //animation: controller,
                          //backgroundColor: Colors.white,
                          //color: themeData.indicatorColor,
                        )),
                        //),
                        //],
                        //),
                      ),
                    ),
                    */

/*
                    Positioned(
                      //right: 0.0,
                      //top: 0.0,
                      child: AnimatedBuilder(
                          animation: controller,
                          builder: (context, child) {
                            return FloatingActionButton.extended(
                                onPressed: () {
                                  if (controller.isAnimating)
                                    controller.stop();
                                  else {
                                    controller.reverse(
                                        from: controller.value == 0.0
                                            ? 1.0
                                            : controller.value);
                                  }
                                },
                                icon: Icon(controller.isAnimating
                                    ? Icons.pause
                                    : Icons.play_arrow),
                                label: Text(
                                    controller.isAnimating ? "Pause" : "Play"));
                          }),
                    ),*/

                  // ),
                  //),
                  //],
                );
              }),
        ],
      ),
    );
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    var x_posi = 0.0;
    //size.width / 2.0;
    var y_posi = 0.0;
    //size.height / 2.0;
    var radius = 18.0;
    //size.width / 20.0;
    //Size(width, height)
    var c = size.center(Offset.zero); //Offset(x_posi, y_posi);
    //size.center(Offset.zero)
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(c, radius, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    //canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);

    canvas.drawArc(
        new Rect.fromLTWH(
            x_posi - radius, y_posi - radius, radius * 2, radius * 2),
        math.pi * 1.5,
        -progress,
        false,
        paint);
  }

  //rectは、完全な楕円形が内部に記されるものです。
  //startAngleラインから描画を開始することを楕円形上の場所です。
  //角度0は右側です。角度はラジアンであり、度ではありません。
  //上は3π/ 2（または-π/ 2）、左はπ、下はπ/ 2です
  //これsweepAngleは、円弧に含まれる楕円の大きさです。ここでも、角度はラジアンです。2πの値は、楕円全体を描画します。
  //useCentertrueに設定すると、円弧の両側から中心への直線になります。

/*
  void paint(Canvas canvas, Size size) {
    final rect =
        Rect.fromLTRB(250.0, 50.0, 270, 70.0 /*size.height*/); //Dot Address
    Paint paint = Paint()
      ..color = Colors.green //backgroundColor
      ..strokeWidth = 3.0 //CircleWidth
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;
    var c = Offset(250, 50.0);
    canvas.drawCircle(c, /*size.width / 2.0*/ 15.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(rect, math.pi * 1.5, progress, false, paint);
  }
*/
  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}

class CustomTimerPainter1 extends CustomPainter {
  const CustomTimerPainter1({
    @required this.progress,
    @required this.startColor,
    @required this.endColor,
    @required this.width,
  })  : assert(progress != null),
        assert(startColor != null),
        assert(endColor != null),
        assert(width != null),
        super();

  final double progress;
  final Color startColor;
  final Color endColor;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = new Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    final gradient = new SweepGradient(
      startAngle: 3 * math.pi / 2,
      endAngle: 7 * math.pi / 2,
      tileMode: TileMode.repeated,
      colors: [startColor, endColor],
    );

    final Paint paint = new Paint()
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.butt // StrokeCap.round is not recommended.
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    final center = new Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width / 2, size.height / 2) - (width / 2);
    final startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius),
        startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

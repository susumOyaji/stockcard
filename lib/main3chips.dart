import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() => runApp(BezierApp());

class BezierApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bezier Animation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CubicToClipper(), //AnimationPage(),
    );
  }
}

class CubicToClipper extends StatefulWidget {
  @override
  _CubicToClipperState createState() => _CubicToClipperState();
}

class _CubicToClipperState extends State<CubicToClipper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: ClipPath(
          clipper: MyCustomClipper(),
          child: Container(
            width: 200,
            height: 200,
            color: Colors.pink,
            child: Text("Stocks",
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 36,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  final double topLeftRadius = 10;
  final double topRightRadius = 10;
  final double bottomLeftRadius = 20;
  final double bottomRightRadius = 10;

  @override
  Path getClip(Size size) {
    double radius = 20.0;

    var path = Path();

    path.moveTo(0.0, 0.0); //P0

    path.lineTo(size.width - radius, 0.0); //P2
    path.arcToPoint(Offset(size.width, radius), //P2 to P3
        clockwise: false,
        radius: Radius.circular(radius));

    path.lineTo(size.width, size.height - radius); //P4
    path.arcToPoint(
      Offset(size.width - radius, size.height), //P4 to P5
      //clockwise: false,
      //radius: Radius.circular(radius)
    );

    path.lineTo(140.0, size.height); //P6
    path.arcToPoint(
      Offset(120.0, size.height - radius), // P7
      //clockwise: false,
      //radius: Radius.circular(radius)
    );
    path.lineTo(120.0, size.height / 2); //P8

    path.lineTo(20.0, size.height / 2); //P9
    path.arcToPoint(
      Offset(0.0, size.height / 2 - radius), //P10
      //clockwise: false,
      //radius: Radius.circular(radius)
    );

    path.lineTo(0.0, radius); //P11
    path.arcToPoint(
      Offset(20.0, 0.0), //P1
      //clockwise: false,
      //radius: Radius.circular(radius)
    );

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class AnimationPage extends StatefulWidget {
  AnimationPage({Key key}) : super(key: key);
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.2;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: BezierClipper(),
            child: Container(
              color: Color.fromRGBO(255, 91, 53, 1), //backcolor
              height: height,
            ),
          ),
          Positioned(
            left: 5.0,
            bottom: 35.0,
            child: Text("Stocks",
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 36,
                    fontWeight: FontWeight.bold)),
          ),
          Positioned(
            right: 5.0,
            bottom: 35.0,
            child: IconButton(
              icon: Icon(Icons.grain),
              color: Colors.blueGrey,
              iconSize: 40,
              onPressed: () {
                // _asyncInputDialog(context);
                //todayDate();

                //Navigator.push(
                //    context,
                //    MaterialPageRoute(
                //        builder:
                //            (context) => /*Stocks(codeItems: codeItems,stockItems:stockItems,valueItems:valueItems)));*/ NewRoutePage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BezierClipper extends CustomClipper<Path> {
  //@override
  //Path getClip(Size size) => null;
  /*
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, size.height * 0.85); //vertical line
    path.quadraticBezierTo(size.width / 2, size.height, size.width,
        size.height * 0.85); //quadratic curve
    path.lineTo(size.width, 0); //vertical line
    return path;
  }
  */

  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, size.height * 0.85); //vertical line
    //path.cubicTo(size.width / 3, size.height, 2 * size.width / 3,
    //    size.height * 0.7, size.width, size.height * 0.85); //cubic curve
    //path.cubicTo(size.width / 4, 3 * size.height / 4, 3 * size.width / 4,
    //    size.height / 4, size.width, size.height);
    path.conicTo(
        size.width / 4, 3 * size.height / 4, size.width, size.height, 20);
    // path.arcTo(Rect.fromLTWH(size.width / 2, size.height / 2, size.width / 4, size.height / 4), degToRad(0), degToRad(90), true);

    path.lineTo(size.width, 0); //vertical line
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

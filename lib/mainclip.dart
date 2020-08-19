import 'package:flutter/material.dart';
import 'package:stockcard/PortFolio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF02BB9F),
        primaryColorDark: const Color(0xFF167F67),
        accentColor: const Color(0xFF02BB9F),
      ),
      home: MyHomePage(title: 'Flutter Clip Path'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: AppBar(),
        body: //Padding(
            //padding: const EdgeInsets.all(10.0),
            //child:
            Row(
      children: <Widget>[
        /*
        ClipPath(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            color: Colors.red,
          ),
          clipper: CustomClipPath(),
        ),
        */
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.0),
            topRight: Radius.circular(50.0),
            bottomRight: Radius.circular(50.0),
          ),
          child: Align(
            alignment: Alignment.bottomRight,
            heightFactor: 0.8,
            widthFactor: 0.8,
            child: Text("data"),
          ),
        ),
      ],
    )

        //),

        );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

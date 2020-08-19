import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/*
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.barlowTextTheme()),
      home: Scaffold(
        body:Center(
          child:DeliverooCard(
            //imgUrl:'https://cdn.pixabay.com/photo/2017/08/86/06/05/42/people-2589176_1280.jpg',
            imgUrl:'https://images.pexels.com/photos/639023/pexels-photo-639023.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
            title:'Big Fernand',
            subtitle:'Lorem ipsum dolor sit amet.',
            estimatedTime:'wait to 20 - 25 min',
          ),
        )
      ),
    );
  }
}
*/

class DeliverooCard extends StatelessWidget{
  final String imgUrl;
  final String title;
  final String subtitle;
  final String estimatedTime;

  const DeliverooCard(
    {Key key,
    @required this.imgUrl,//@required 必須パラメータ
    @required this.title,
    @required this.subtitle,
    @required this.estimatedTime})
    : assert (imgUrl != null),
      assert (title != null),
      assert (subtitle != null),
      assert (estimatedTime != null),
      super(key: key);
 

 

@override
Widget build(BuildContext context){
  return Container(
    color: Colors.white,
    //padding:EdgeInsets.all(10.0),
    child:Column(
      mainAxisAlignment:MainAxisAlignment.center,
      crossAxisAlignment:CrossAxisAlignment.start,
      children:<Widget>[
        Stack(
          children:<Widget>[
            Container(
              color: Colors.purple,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.only(
              top:0.5, left:0.5, right:0.5, bottom:0.5),
              child:ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  imgUrl,
                  //height: 50.0,
                  //width: 200.0,
                  fit: BoxFit.cover,
                  ),
              ),
            ),
            Positioned(
              left:20,
              top:20,
              child:Row(
                children: <Widget>[
                  CircleAvatar(
                  maxRadius: 5.0,
                  backgroundColor: true ? Colors.red : Colors.green,
                  ),
                  Text("Nikkey Price",
                    style: TextStyle(fontSize: 10.0, color: Colors.white),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "￥",
                          style: TextStyle(fontSize: 10.0, color: Colors.white),
                        ),
                        TextSpan(
                          text: title,
                          style: TextStyle(fontSize: 12.0,color: Colors.white,//fontWeight: FontWeight.bold,
                          ),
                          //style: TextStyle(fontSize: 12.0,//fontWeight: FontWeight.bold,
                          //),
                        ),
                      ],
                    ),
                  ), 
                ],
              ),
            ),
            Positioned(
              left:30,
              top:30,
              child:Row(
                children: <Widget>[
                  Text("The day before ratio",
                    style: TextStyle(fontSize: 10.0, color: Colors.white),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "￥",
                          style: TextStyle(fontSize: 10.0, color: Colors.white),
                        ),
                        TextSpan(
                          text: estimatedTime,
                          style: TextStyle(fontSize: 10.0,color: Colors.white,//fontWeight: FontWeight.bold,
                          ),
                          //style: TextStyle(fontSize: 12.0,//fontWeight: FontWeight.bold,
                          //),
                        ),
                      ],
                    ),
                  ), 
                ],
              ),
            ), 
            Positioned(
              right:20,
              bottom:0,
              //child: Material(
              //  borderRadius: BorderRadius.circular(60.0),
              //  elevation: 2,
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(30.0)),
                  child: Text(
                    estimatedTime,
                    style:TextStyle(
                      fontSize:12,fontWeight:FontWeight.bold),
                  ),  
                ),
             // ),
            ),
          ]
        ),
        /*
        Padding(
          padding: EdgeInsets.all(2.5),
          child: Text(
            title,
            style: TextStyle(fontSize:20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(padding: EdgeInsets.all(2.5),child:  Text(subtitle)),
        */
      ],
      )
  );

}
}
  

//import 'package:flutter/material.dart';

class ChipInputField extends StatelessWidget {
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chip Input Field Example'),
      ),
      body: Center(
        child: Padding(
          //Add padding around textfield
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: InputChip(
            avatar: Icon(
              Icons.cancel,
              color: Colors.red,
            ),
            label: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "A Chip input field"),
            ),
            labelPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          ),
        ),
      ),
    );
  }
}




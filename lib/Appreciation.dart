import 'package:flutter/material.dart';
//import 'NetConnect.dart';
//import 'dart:async';


//Parsonal Data Disp
  class Appreciation extends StatelessWidget {
    Appreciation({this.stdwidgets});
    List <List<String>> stdwidgets;
       

      @override
      Widget build(BuildContext context){
      
        return new Container(
        padding: new EdgeInsets.fromLTRB(4.0, 1.0, 5.0, 5.0),
        decoration: BoxDecoration(
        //color: Colors.black54,//.fromARGB(0xFF, 0x0B, 0x39, 0x50),
        //borderRadius: const BorderRadius.all(const Radius.circular(3.0)),
        ),
        child: Column(
          children: [
          Container(child://-------->>
            //child:Column(children:<Widget> [// Expanded(flex: 2,child:
              new Card(
                margin: EdgeInsets.only(top: 0.0, right: 0.0, bottom: 0.0, left: 0.0),
                color: Colors.black,
                  child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                     // Expanded(child:
                        new Column(
                         
                          children: <Widget>[                  
                            //new Padding(
                            //    padding: new EdgeInsets.only(top: 3.0, right: 0.0, bottom: 0.0, left: 30.0),
                                /*child:*/new Text('Appreciation Rate Top3',style: new TextStyle(fontSize: 12.0, color: Colors.orangeAccent),),
                             // ), 
                              new Padding(
                                  padding: new EdgeInsets.only(top: 3.0, right: 0.0, bottom: 0.0, left: 0.0),
                                  child: new Text("${stdwidgets[0][1]} code:${stdwidgets[0][0]}  value:${stdwidgets[0][2]}", style: TextStyle(fontSize: 12.0, color: Colors.lightGreenAccent)),
                              ),
                               new Padding(
                                  padding: new EdgeInsets.only(top: 3.0, right: 0.0, bottom: 0.0, left: 0.0),
                                  child: new Text("${stdwidgets[1][1]} code:${stdwidgets[1][0]}  value:${stdwidgets[1][2]}", style: TextStyle(fontSize: 12.0, color: Colors.greenAccent)),
                              ), 
                               new Padding(
                                  padding: new EdgeInsets.only(top: 3.0, right: 0.0, bottom: 0.0, left: 0.0),
                                  child: new Text("${stdwidgets[2][1]} code:${stdwidgets[2][0]}  value:${stdwidgets[2][2]}", style: TextStyle(fontSize: 12.0, color: Colors.greenAccent)),
                              ),
                              new Padding(
                                  padding: new EdgeInsets.only(top: 3.0, right: 0.0, bottom: 0.0, left: 0.0),
                                  child: new Text("${stdwidgets[3][1]} code:${stdwidgets[3][0]}  value:${stdwidgets[3][2]}", style: TextStyle(fontSize: 12.0, color: Colors.greenAccent)),
                              ), 
                              new Padding(
                                  padding: new EdgeInsets.only(top: 3.0, right: 0.0, bottom: 3.0, left: 0.0),
                                  child: new Text("${stdwidgets[4][1]} code:${stdwidgets[4][0]}  value:${stdwidgets[4][2]}", style: TextStyle(fontSize: 12.0, color: Colors.greenAccent)),
                              ),  
                                       
                            ],
                          ),
                     // ),
                    ],), 
                ),
             // ],
            //),
          ),
        ],),
      );

  }
}


//Parsonal Data Disp
  class Volume extends StatelessWidget{
    Volume({this.volumewidgets});
    final List <List<String>> volumewidgets;

      @override
      Widget build(BuildContext context) {
      return new Container(
        padding: new EdgeInsets.fromLTRB(4.0, 1.0, 5.0, 5.0),
        decoration: BoxDecoration(
        //color: Colors.black54,//.fromARGB(0xFF, 0x0B, 0x39, 0x50),
        //borderRadius: const BorderRadius.all(const Radius.circular(3.0)),
        ),
        child: Column(
          children: [
          Container(//-------->>
            child:Column(children:<Widget> [// Expanded(flex: 2,child:
              new Card(
                margin: EdgeInsets.only(top: 0.0, right: 0.0, bottom: 0.0, left: 0.0),
                color: Colors.black,
                  child:
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      Expanded(child:
                        new Column(
                          children: <Widget>[                  
                            new Padding(
                              padding: new EdgeInsets.only(top: 0.0, right: 0.0, bottom: 0.0, left: 30.0),
                                  child:new Text('Volume Top3',style: new TextStyle(fontSize: 12.0, color: Colors.orangeAccent),),
                              ), 
                              new Padding(
                                  padding: new EdgeInsets.only(top: 3.0, right: 0.0, bottom: 0.0, left: 0.0),
                                  child: new Text("${volumewidgets[0][1]}code:${volumewidgets[0][0]}  value:${volumewidgets[0][2]}", style: TextStyle(fontSize: 12.0, color: Colors.blueAccent)),
                              ),
                              new Padding(
                                  padding: new EdgeInsets.only(top: 3.0, right: 0.0, bottom: 0.0, left: 0.0),
                                  child: new Text("${volumewidgets[1][1]}code:${volumewidgets[1][0]}  value:${volumewidgets[1][2]}", style: TextStyle(fontSize: 12.0, color: Colors.blueAccent)),
                              ), 
                              new Padding(
                                  padding: new EdgeInsets.only(top: 3.0, right: 0.0, bottom: 0.0, left: 0.0),
                                  child: new Text("${volumewidgets[2][1]}code:${volumewidgets[2][0]}  value:${volumewidgets[2][2]}", style: TextStyle(fontSize: 12.0, color: Colors.blueAccent)),
                              ), 
                              new Padding(
                                  padding: new EdgeInsets.only(top: 3.0, right: 0.0, bottom: 0.0, left: 0.0),
                                  child: new Text("${volumewidgets[3][1]}code:${volumewidgets[3][0]}  value:${volumewidgets[3][2]}", style: TextStyle(fontSize: 12.0, color: Colors.blueAccent)),
                              ), 
                               new Padding(
                                  padding: new EdgeInsets.only(top: 3.0, right: 0.0, bottom: 0.0, left: 0.0),
                                  child: new Text("${volumewidgets[4][1]}code:${volumewidgets[4][0]}  value:${volumewidgets[4][2]}", style: TextStyle(fontSize: 12.0, color: Colors.blueAccent)),
                              ),       
                            ],
                          ),
                      ),
                    ],), 
                ),
              ],
            ),
          ),
        ],),
      );

  }
}

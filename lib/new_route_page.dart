import 'package:flutter/material.dart';

class NewRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('newRoute'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
               decoration: InputDecoration(
                    labelText: 'CodeNumber',
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 8.0,
                        //height: 1,
                        fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                    //errorText:_validateCode ? 'The CodeNumber input is empty.' : null,
                    contentPadding: const EdgeInsets.only(
                        left: 0.0, bottom: 15.0, top: 15.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellowAccent),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
            ),
            TextField(),
            TextField(),
            Text('newRoute'),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('pop'),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'shared_prefs.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';

/*
class ParentWidget extends StatefulWidget {
  ParentWidget({Key key,this.codeItems, this.stockItems, this.valueItems});// : super(key: key) ;
    final List<String> codeItems;
    final List<String> stockItems;
    final List<String> valueItems;

  @override
  //Stocks createState() => new Stocks();
}
*/

final TextEditingController codeCtrl = TextEditingController();
final TextEditingController stockCtrl = TextEditingController();
final TextEditingController valueCtrl = TextEditingController();
bool _validateCode = false;
bool _validateStock = false;
bool _validateValue = false;

class Stocks extends StatelessWidget {
  //bool _validateCode = false;
  //bool _validateStock = false;
  //bool _validateValue = false;

  //List<String> codeItems = []; //codekey
  //List<String> stockItems = [];//stock
  //List<String> valueItems = []; //value
  final List<String> codeItems;
  final List<String> stockItems;
  final List<String> valueItems;

  const Stocks(
      {Key key,
      @required this.codeItems,
      @required this.stockItems,
      @required this.valueItems})
      : assert(codeItems != null),
        assert(stockItems != null),
        assert(valueItems != null),
        super(key: key);

  //TextEditingController codeCtrl = TextEditingController();
  //final TextEditingController stockCtrl = TextEditingController();
  //final TextEditingController valueCtrl = TextEditingController();
  //bool _validateCode = false;
  //bool _validateStock = false;
  //bool _validateValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stocks'),
      ),
      body: Container(
          margin: EdgeInsets.only(top: 0.0, left: 0.0),
          padding: EdgeInsets.all(0.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.grey[800],
                    //Color(0xffb43af7),
                    //Color(0x0B52067),
                    //Color(0xff6d2af7),
              ],
            ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  bottomLeft: Radius.circular(0),
                ),
              ),
        child: Row(
          // 1行目
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                //padding: EdgeInsets.all(1.0),
                //height: 70.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  color: Colors.grey,
                ),
                child: TextField(
                  controller: codeCtrl,
                  //maxLength: 4,
                  decoration: InputDecoration(
                    labelText: 'CodeNumber',
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 8.0,
                        //height: 1,
                        fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                    errorText:
                        _validateCode ? 'The CodeNumber input is empty.' : null,
                    contentPadding: const EdgeInsets.only(
                        left: 0.0, bottom: 15.0, top: 15.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellowAccent),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                  autocorrect: false,
                  onSubmitted: (text) {
                    if (text.isEmpty) {
                      _validateCode = true;
                      //setState(() {});
                    } else {
                      _validateCode = false;
                      codeItems.add(text);
                      codeCtrl.clear();
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                // height: 70.0,
                margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  color: Colors.grey,
                ),
                child: TextField(
                  controller: stockCtrl,
                  decoration: InputDecoration(
                    labelText: 'Stock',
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 8.0,
                        //height: 1,
                        fontWeight: FontWeight.bold),
                    border: InputBorder.none,
                    errorText:
                        _validateStock ? 'The Stock input is empty.' : null,
                    contentPadding: const EdgeInsets.only(
                        left: 0.0, bottom: 15.0, top: 15.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  autocorrect: true,
                  onSubmitted: (text) {
                    if (text.isEmpty) {
                      _validateStock = true;
                      //setState(() {});
                    } else {
                      _validateStock = false;
                      stockItems.add(text);
                      SharePrefs.setStockItems(stockItems).then((_) {
                        //setState(() {});
                      });
                      stockCtrl.clear();
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                //height: 70.0,
                margin: EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey,
                ),
                child: TextField(
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontWeight: FontWeight.bold),
                  controller: valueCtrl,
                  decoration: InputDecoration(
                    labelText: "value",
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 8.0,
                        //height: 1,
                        fontWeight: FontWeight.bold),
                    errorText:
                        _validateValue ? 'The Value input is empty.' : null,
                    contentPadding: const EdgeInsets.only(
                        left: 0.0, bottom: 15.0, top: 15.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  autocorrect: true,
                  onSubmitted: (text) {
                    //TextFieldからの他のコールバック
                    if (text.isEmpty) {
                      _validateValue = true;
                      //setState(() {});
                    } else {
                      _validateValue = false;
                      valueItems.add(text);
                      SharePrefs.setValueItems(valueItems).then((_) {
                        //setState(() {});
                      });
                      valueCtrl.clear();
                    }
                  },
                ),
              ),
            ),
            InkWell(
                child: Icon(
                  Icons.add_circle,
                  color: Colors.blueAccent,
                  semanticLabel: "",
                ),
                onTap: () {
                  if (/*eCtrl.text.isEmpty ||*/ codeCtrl.text.isEmpty ||
                      stockCtrl.text.isEmpty ||
                      valueCtrl.text.isEmpty) {
                    //if (eCtrl.text.isEmpty) _validate = true;
                    if (codeCtrl.text.isEmpty) _validateCode = true;
                    if (stockCtrl.text.isEmpty) _validateStock = true;
                    if (valueCtrl.text.isEmpty) _validateValue = true;
                    //setState(() {});
                  } else {
                    _validateCode = false;
                    _validateStock = false;
                    _validateValue = false;
                    codeItems.add(codeCtrl.text);
                    stockItems.add(stockCtrl.text);
                    valueItems.add(valueCtrl.text);
                    SharePrefs.setCodeItems(codeItems);
                    SharePrefs.setStockItems(stockItems);
                    SharePrefs.setValueItems(valueItems);
                    //setState(() {
                    //(codeCtrl.text);

                    //});

                    codeCtrl.clear();
                    stockCtrl.clear();
                    valueCtrl.clear();
                  }
                }),
          
          ],
        ),
      ),
    );
  }
}

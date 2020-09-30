import 'dart:async';
//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

import 'package:stockcard/Clipper.dart';

import 'shared_prefs.dart';

import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride;
//import 'package:flutter/services.dart';
import 'dart:io';
import 'MarketStandard.dart';
import 'PortFolio.dart';
import 'maining.dart';
import 'package:intl/intl.dart';

//Shift + Alt + F

//void main() async {
//debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
//  runApp(MyApp1());
//}
void main() => runApp(MyApp1());

class MyApp1 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false, // <- Debug の 表示を OFF
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

//カンマ区切り文字列を整数に変換
int toIntger(String char) {
  String row = "";
  List<String> sp = char.split(",");

  if (char == "---") return 0;
  for (int i = 0; i < (sp.length); ++i) {
    row += sp[i];
  }

  int num = int.parse(row);
  return num;
}

String separation(int number) {
  final matcher = new RegExp(r'(\d+)(\d{3})');

  String first_part = number.toString();
  while ((first_part).contains(matcher)) {
    first_part =
        (first_part.replaceAllMapped(matcher, (m) => '${m[1]},${m[2]}'));
  }
  debugPrint('separation-out: $first_part');
  return first_part;
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List widgets = []; // new List<Price>.filled(1, Price());

  ////////////////////////////////
  List<String> codeItems = []; //codekey
  List<String> stockItems = []; //stock
  List<String> valueItems = []; //value
  List<String> income = []; //損益
  List<String> stdcodeItems = ['998407.O', '^DJI']; //Nikkei And Dw

  List<String> acquiredAssetsItems = []; //取得資産 stock x value
  List<String> valuableAssetsItems = []; //評価資産 stock X presentvalue
  String acquiredAssetsSumString = '0';
  String valuableAssetsSumString = '0';
  int acquiredAssetsSum = 0; //取得資産合計
  int valuableAssetsSum = 0; //評価資産合計

  String valueSum;
  String presentvalueSUm;

  bool _validateCode = false;
  bool _validateStock = false;
  bool _validateValue = false;

  final TextEditingController codeCtrl = TextEditingController();
  final TextEditingController stockCtrl = TextEditingController();
  final TextEditingController valueCtrl = TextEditingController();

  static List<String> code = []; //
  static List<String> presentvalue = []; //現在値
  static List<String> changePriceRate = []; //前日比%
  static List<String> changePriceValue = []; //前日比¥
  static List<bool> signalstate = []; //Each to Up and Down
  static List<bool> percentcheng = [];
  DateTime now = DateTime.now();
  String currentmonth = DateFormat('\n EEE d MMM\n').format(DateTime
      .now()); //DateFormat('kk:mm:ss \n EEE d MMM').format(now);//DateTime.now().month.toString();

  int count;
  static bool isUpDown = false;
  String codename; //="Null to String";
  int intprice = 0;
  int index = 0;
  bool purchase = false;
  String stringprice = "";
  String gain = "0";
  bool _active = false;

  void _init() async {
    await SharePrefs.setInstance();

    codeItems = SharePrefs.getCodeItems();
    stockItems = SharePrefs.getStockItems();
    valueItems = SharePrefs.getValueItems();
    acquiredAssetsItems = SharePrefs.getacquiredAssetsItems(); //取得資産
    valuableAssetsItems = SharePrefs.getvaluableAssetsItems();
  }

  @override
  void initState() {
    Timer.periodic(const Duration(minutes: 1), _timer);

    _init();
    super.initState();

    _setTargetPlatformForDesktop();
    reload1();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getBody() {
    if (showLoadingDialog()) {
      return getProgressDialog();
    } else {
      return setupDisp();
    }
  }

  getProgressDialog() {
    return new Center(child: new CircularProgressIndicator());
  }

  showLoadingDialog() {
    if (widgets.length == 0) {
      return true;
    }
    return false;
  }

  setupDisp() {
    return base();
  }

  void _timer(Timer timer) {
    reload();
  }

  void reload() async {
    reload1();
    base();
  }

  void reload1() async {
    index = 0;
    count = 0;
    purchase = false;

    code = [];
    presentvalue = [];
    changePriceValue = [];
    changePriceRate = [];
    income = [];
    signalstate = [];
    percentcheng = [];
    await fetch(stdcodeItems);

    purchase = true;
    intprice = 0;
    //if (!codeItems.isEmpty) {
    await fetch(codeItems);
    //}

    setState(() {
      widgets = stdcodeItems; // widgets;
    });
  }

  void _showScaffold(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void _changeSwitch(bool e) => setState(() => _active = e);

  //*************************************** */

  Future fetch(List<String> items) async {
    //6758,6976
    //List<String> responce =["998407,0,0\n","^DJI,0,0\n"];
    List<String> responce = items; //"998407.O,0,0\n^DJI,0,0\n";
    //List<String> gprices =  responce;
    //int stdcount =0;
    //int count = 0;

    for (String item in responce) {
      final response = await http.get(
          "https://stocks.finance.yahoo.co.jp/stocks/detail/?code=" +
              item); //^DJI
      final String json = response.body;

      int intprice;
      //String changePriceRate = "non"; //前日比%;
      //String changePriceValue = "non"; //前日比¥

      String codename;
      RegExp regExp = RegExp(r'<title>.+【');
      codename = regExp.stringMatch(json).toString(); //name
      codename = codename.replaceAll("<title>", "");

      //regExp = RegExp(r'[+-][0-9]{1,}.[0-9]{1,}.[+-]..[0-9]{1,}%.');//日経平均
      //regExp = RegExp(r'[0-9]{1,}[,][0-9]{1,}[.][0-9]{1,}');//DOW平均
      String value;
      regExp = RegExp(r'"stoksPrice">.{1,}<'); //DOW平均
      //regExp = RegExp(r'[0-9]{1,}.[0-9]{1,}'); //1,234;
      value = regExp.stringMatch(json).toString(); //現在値

      debugPrint("StockPrice : " + value);
      debugPrint("string to int : " + intprice.toString());
      debugPrint("hasMatch : " + regExp.hasMatch(json).toString());

      regExp = RegExp(r'yjMSt">[+-][0-9].{1,}<');
      var changedata = regExp.stringMatch(json).toString();

      //changedata = '"yjMSt">+1,051.26（+4.88%）</span><"';
      debugPrint(changedata);

      String changevalue;
      //regExp = RegExp(r'（[+-][0-9]{1,}.[0-9]{1,}%）');
      if (count < 2) {
        regExp = RegExp(r'[+-][0-9,]{1,}.[0-9]{2,}'); //時価（小数点あり）Nikkei
      } else {
        regExp = RegExp(r'[+-][0-9]{1,}'); //時価（小数点なし）
      }
      //regExp = RegExp(r'(\D{1,3})(?=(\d{3})+(?!\d))'); //value patttan
      //regExp = RegExp(r'["][+-][0-9]{1,}[.][0-9]{1,}');//DOW前日比¥
      changevalue = regExp.stringMatch(changedata).toString();
      //changerate = changerate.replaceAll('"', "");
      //changePriceRate.add(changerate); //前日比%

      debugPrint("Changevalue : " + changevalue);
      debugPrint("Changevalue : " + regExp.hasMatch(json).toString());

      //var ans ='1111112345'.replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
      //debugPrint(ans);

      //************************************************************** */
      String changerate;
      regExp = RegExp(r'（[+-]..[0-9]{1,}%）');
      //regExp = RegExp(r'[>][+-][0-9]{1,}[.][0-9]{1,}%');//DOW前日比%
      //regExp = RegExp(r'[">][+-][0-9]{1,}.[0-9]{1,}.[+-]..[0-9]{1,}%.');//
      changerate = regExp.stringMatch(changedata).toString();
      //changerate = changerate.replaceAll('"', "");

      code.add(codename.replaceAll("【", ""));
      debugPrint("code-name : " + code[count]);

      var tmp = value.replaceAll('"stoksPrice">', "");
      value = tmp.replaceAll('<', "");
      if (value == "null" || value == "---") {
        value = "0";
      }
      presentvalue.add(value);
      debugPrint("code-presentValue : " + presentvalue[count]);

      //tmp = changerate.replaceAll('yjMSt">', "");
      //changerate = tmp.replaceAll('</span><', "");
      if (changerate == "null" || changerate == "---") {
        changerate = "0";
      }

      changePriceRate.add(changerate);
      debugPrint("code-changePriceRate : " + changePriceRate[count]);

      changevalue = changevalue;
      changePriceValue.add(changevalue);
      debugPrint("code-changePriceValue : " + changePriceValue[count]);

      debugPrint("Change : " + regExp.hasMatch(json).toString());
      debugPrint("ChangeValue: " + regExp.hasMatch(json).toString());

      if (purchase == true) {
        try {
          intprice =
              intprice + int.parse(value.replaceAll(",", "")); //string for int
        } catch (exception) {
          intprice = 0;
        }
        acquiredAssetsItems.add(
            (int.parse(stockItems[index]) * int.parse(valueItems[index]))
                .toString()); //取得資産
        try {
          valuableAssetsItems.add((int.parse(value.replaceAll(",", "")) *
                  int.parse(stockItems[index]))
              .toString()); //評価資産
        } catch (exception) {
          valuableAssetsItems.add("0");
        }

        // setState(() {
        acquiredAssetsSum =
            acquiredAssetsSum + int.parse(acquiredAssetsItems[index]); //取得資産合計
        valueSum = separation(acquiredAssetsSum); //insert ','
        acquiredAssetsSumString = (valueSum.toString());

        valuableAssetsSum =
            valuableAssetsSum + int.parse(valuableAssetsItems[index]); //評価資産
        presentvalueSUm = separation(valuableAssetsSum);
        valuableAssetsSumString = (presentvalueSUm.toString());

        gain = separation(valuableAssetsSum - acquiredAssetsSum); //損益
        // });

        if (valuableAssetsSum < acquiredAssetsSum) {
          //損益シグナル
          isUpDown = false;
        } else {
          isUpDown = true;
        }

        var sel = int.parse(presentvalue[index + 2].replaceAll(",", "")) -
            int.parse(valueItems[index]);
        income.add(separation(sel));

        index++;
      } else {
        acquiredAssetsSum = 0;
        valuableAssetsSum = 0;
        acquiredAssetsItems = [];
        valuableAssetsItems = [];
      }

      percentcheng.add(false);
      regExp = RegExp(r'icoUpGreen'); //new RegExp(r"/[0-9]+/");
      String signal = regExp.stringMatch(json).toString();
      if (signal == "null") {
        signalstate.add(false);
      } else {
        signalstate.add(true);
      }
      debugPrint("Signal : " + signal);
      debugPrint("hasMatch : " + regExp.hasMatch(json).toString());
      if ((regExp.hasMatch(json)) == false) {
        debugPrint("Green-Down"); //Down
      } else {
        debugPrint("Red-Up"); //Up
      }

      count++;
    } //for
  }

////////////////////////////////////////////////////

  GridView gridView() => new GridView.builder(
      scrollDirection: Axis.vertical,
      itemCount: codeItems.length, //+20,//<-- setState()
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: new Card(
            margin: const EdgeInsets.all(5.0),
            color: Colors.grey[850],
            elevation: 5.0,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: 0.0, right: 0.0, bottom: 0.0, left: 50.0),
                    child: InkWell(
                      onTap: () {
                        _deleteCard(index);
                        debugPrint("index No:${index}to Delet clicked");
                      },
                      child: Icon(
                        Icons.delete,
                        size: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Text(
                    "(${codeItems[index]}) " + "${code[index + 2]}",
                    style: TextStyle(
                        fontFamily: 'Roboto-Thin',
                        fontSize: 8.0,
                        color: Colors.orange),
                  ),
                  Text(
                    "Present ${presentvalue[index + 2]}",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 8.0,
                        color: Colors.blue),
                  ),
                  Text(
                    "Profit　${income[index]}",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 8.0,
                        color: Colors.yellow),
                  ),
                  Text(
                    "Loss　${separation(int.parse(valuableAssetsItems[index]))}",
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 8.0,
                        color: Colors.orange),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 8.0, right: 0.0, bottom: 0.0, left: 0.0),
                    child: SizedBox(
                      height: 15.0,
                      width: 65.0,
                      child: RaisedButton(
                        padding: EdgeInsets.all(0.0),
                        disabledColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                        ),
                        color:
                            signalstate[index + 2] ? Colors.red : Colors.green,
                        child: new Text(
                          signalstate[index]
                              ? '${changePriceValue[index + 2]}'
                              : '${changePriceRate[index + 2]}',
                          style: TextStyle(fontSize: 8.0, color: Colors.black),
                        ),
                        onPressed: () => setState(() {
                          //widgets[index].percentcheng = !widgets[index].percentcheng;
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });

  //////////////////////////////////////////////////////////////////////
  ///
  ///
  ///
  ///
  ///
  ///

  FixedExtentScrollController fixedExtentScrollController =
      new FixedExtentScrollController();
/*
  ListWheelScrollView(
  controller: fixedExtentScrollController,
  physics: FixedExtentScrollPhysics(),
  children: monthsOfTheYear.map((month) {
    return Card(
        child: Row(
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            month,
            style: TextStyle(fontSize: 18.0),
          ),
        )),
      ],
    ));
  }).toList(),
  itemExtent: 60.0,
),
*/
  ListView listView() => ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: codeItems.length, //+20,//<-- setState()
      //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Container(
              margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    //Color(0xffb43af7),
                    //Color(0x0B52067),
                    //Color(0xff6d2af7),
                    Colors.black,
                    Colors.grey[800],
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  //mainAxisSize: MainAxisSize.max,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    //mainAxisSize: MainAxisSize.min,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    // children:<Widget>[
                    Expanded(
                      flex: 2,
                      child:
                          //Padding(
                          //  padding: EdgeInsets.only(top: 0.0, right: 0.0, bottom: 0.0, left: 0.0),

                          //child:
                          RaisedButton(
                        child: Text("${codeItems[index]}",
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.grey)),
                        color: Colors.purple,
                        shape: CircleBorder(
                            /*
                          side: BorderSide(
                            color: Colors.black,
                            width: 0.0,
                            style: BorderStyle.solid,
                          ),
                          */
                            ),
                        onPressed: () {
                          _asyncEditDialog(context, index);
                        },
                        onLongPress: () {
                          alertDialog(index);
                        },
                      ),

                      /*
                          FloatingActionButton(
                        mini: true,
                        child: Text("${codeItems[index]}",
                            style:
                                TextStyle(fontSize: 10.0, color: Colors.grey)),
                        backgroundColor: Colors.purple,
                        onPressed: () {
                          _asyncEditDialog(context, index);
                        },
                         
                      ),
                      */
                      //),
                    ),

                    //  ]
                    // ),

                    //SizedBox(width: 15.0,),
                    Expanded(
                      flex: 6,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        //mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${code[index + 2]}",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                            strutStyle: StrutStyle(
                              fontSize: 10.0,
                              height: 2.0,
                            ),
                          ),
                          Text(
                            "Market  ${presentvalue[index + 2]}",
                            style: TextStyle(
                                //fontFamily: 'Roboto',
                                fontSize: 12.0,
                                color: Colors.blue),
                          ),
                          Text(
                            "Benefits　${income[index]}",
                            style: TextStyle(
                                //fontFamily: 'Roboto',
                                fontSize: 12.0,
                                color: Colors.yellow),
                          ),
                          Text(
                            "Assets held ${separation(int.parse(valuableAssetsItems[index]))}",
                            style: TextStyle(
                                //fontFamily: 'Roboto',
                                fontSize: 12.0,
                                color: Colors.orange),
                          ),
                        ],
                      ),
                    ),
                    //SizedBox(width: 50.0,),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 0.0, right: 0.0, bottom: 0.0, left: 0.0),
                        //child: //SizedBox(
                        //height: 30.0,
                        //width: 60.0,
                        child: FlatButton(
                          padding: EdgeInsets.all(0.0),
                          disabledColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                          ),
                          color: signalstate[index + 2]
                              ? Colors.red
                              : Colors.green,
                          child: Text(
                            percentcheng[index + 2] //signalstate[index]
                                ? '${changePriceRate[index + 2]}'
                                : '${changePriceValue[index + 2]}',
                            style:
                                TextStyle(fontSize: 13.0, color: Colors.black),
                          ),
                          onPressed: () => setState(() {
                            percentcheng[index + 2] = !percentcheng[index + 2];
                          }),
                        ),
                        //),
                      ),
                    ),
                  ])),
        );
      });

  void alertDialog(int _index) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Check"),
          content: Text("${code[_index + 2]}" + " to Can I delete it?"),
          actions: <Widget>[
            // ボタン領域
            FlatButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            FlatButton(
                child: Text("OK"),
                onPressed: () {
                  _deleteCard(_index);
                  Navigator.pop(context);
                } //Navigator.pop(context),
                ),
          ],
        );
      },
    );
  }

  void _deleteCard(int _index) {
    setState(() {
      codeItems.removeAt(_index);
      stockItems.removeAt(_index);
      valueItems.removeAt(_index);
      SharePrefs.setCodeItems(codeItems);
      SharePrefs.setStockItems(stockItems);
      SharePrefs.setValueItems(valueItems);
    });
  }

  Future<String> _asyncInputDialog(BuildContext context) async {
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          title: Text('Enter an investment estimate'),
          content: Column(
            children: <Widget>[
              Expanded(
                  child: TextField(
                      controller: codeCtrl,
                      autofocus: true,
                      decoration: InputDecoration(
                          labelText: 'Code Namber',
                          hintText: 'Enter the number of 4 digits'),
                      onSubmitted: (text) {
                        if (text.isEmpty) {
                          _validateCode = true;
                          setState(() {});
                        } else {
                          _validateCode = false;
                          codeItems.add(text);
                          codeCtrl.clear();
                        }
                      })),
              Expanded(
                  child: TextField(
                controller: stockCtrl,
                autofocus: true,
                decoration: InputDecoration(
                    labelText: 'Stock', hintText: 'Enter the number of shares'),
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
              )),
              Expanded(
                  child: TextField(
                      controller: valueCtrl,
                      autofocus: true,
                      decoration: InputDecoration(
                          labelText: 'Value',
                          hintText: 'Enter the amount acquired per share'),
                      onChanged: (value) {
                        //teamName = value;
                      },
                      onSubmitted: (text) {
                        //TextFieldからの他のコールバック
                        if (text.isEmpty) {
                          _validateValue = true;
                          setState(() {});
                        } else {
                          _validateValue = false;
                          valueItems.add(text);
                          SharePrefs.setValueItems(valueItems).then((_) {
                            setState(() {});
                          });
                          valueCtrl.clear();
                        }
                      }))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                if (/*eCtrl.text.isEmpty ||*/ codeCtrl.text.isEmpty ||
                    stockCtrl.text.isEmpty ||
                    valueCtrl.text.isEmpty) {
                  //if (eCtrl.text.isEmpty) _validate = true;
                  if (codeCtrl.text.isEmpty) _validateCode = true;
                  if (stockCtrl.text.isEmpty) _validateStock = true;
                  if (valueCtrl.text.isEmpty) _validateValue = true;
                  setState(() {});
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> _asyncEditDialog(BuildContext context, int index) async {
    final TextEditingController _codeFieldController =
        TextEditingController(text: codeItems[index]);
    final TextEditingController _stackFieldController =
        TextEditingController(text: stockItems[index]);
    final TextEditingController _valueFieldController =
        TextEditingController(text: valueItems[index]);

    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier

      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          title: Text('Edit an investment Data'),
          content: Column(
            children: <Widget>[
              Expanded(
                  child: TextField(
                      controller: _codeFieldController,
                      //autofocus: true,
                      decoration: InputDecoration(
                          labelText: 'Code : ',
                          border: OutlineInputBorder(),
                          hintText: 'If you want to change it, enter a value'),
                      onSubmitted: (text) {
                        debugPrint(text);
                        if (text.isEmpty) {
                          _validateCode = true;
                          setState(() {});
                        } else {
                          _validateCode = false;
                          codeItems[index] = text;
                          SharePrefs.setStockItems(codeItems).then((_) {
                            setState(() {
                              codeCtrl.clear();
                            });
                          });
                          //codeCtrl.clear();
                        }
                      })),
              Expanded(
                  child: TextField(
                controller: _stackFieldController,
                //autofocus: true,
                decoration: InputDecoration(
                    labelText: 'Stock : ',
                    border: OutlineInputBorder(),
                    hintText: 'If you want to change it, enter a value'),
                onSubmitted: (text) {
                  if (text.isEmpty) {
                    setState(() {
                      _validateStock = true;
                    });
                  } else {
                    _validateStock = false;
                    stockItems[index] = text;
                    SharePrefs.setStockItems(stockItems).then((_) {
                      setState(() {
                        stockCtrl.clear();
                      });
                    });
                    //stockCtrl.clear();
                  }
                },
              )),
              Expanded(
                  child: TextField(
                      controller: _valueFieldController,
                      //autofocus: true,
                      decoration: InputDecoration(
                          labelText: 'Value : ',
                          border: OutlineInputBorder(),
                          hintText: 'If you want to change it, enter a value'),
                      onSubmitted: (text) {
                        //TextFieldからの他のコールバック
                        if (text.isEmpty) {
                          _validateValue = true;
                          setState(() {});
                        } else {
                          _validateValue = false;
                          valueItems[index] = text;
                          SharePrefs.setValueItems(valueItems).then((_) {
                            setState(() {
                              valueCtrl.clear();
                            });
                          });
                          valueCtrl.clear();
                        }
                      }))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Return'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  todayDate() {
    //new DateFormat.M();
    var now = new DateTime.now();
    var formatter = new DateFormat('LLLLL-yyyy');
    String formattedTime = DateFormat('kk:mm:a').format(now);
    String formattedDate = formatter.format(now);
    //String formattedMouth = new DateFormat.M();
    debugPrint(formattedTime);
    debugPrint(formattedDate);
    //debugPrint(formattedMouth);
  }

  Widget base() {
    return Column(
      children: <Widget>[
        Container(
          //width: 280,
          margin: EdgeInsets.all(0.0),
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Stack(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                  child: SafeArea(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ClipPath(
                            clipper: MyCustomClipper(),
                            child: Container(
                                //margin: EdgeInsets.only(top: 0.0, right: 0.0),
                                padding: EdgeInsets.only(
                                    top: 0.0,
                                    left: 20.0,
                                    right: 0.0,
                                    bottom: 10.0),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      //Color(0xffb43af7),
                                      //Color(0x0B52067),
                                      Colors.white,
                                      //Colors.grey[800],
                                      Colors.grey[800],

                                      //Color(0xff6d2af7),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  //mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      //mainAxisAlignment: MainAxisAlignment.start,
                                      //mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Stocks",
                                          style: TextStyle(
                                            fontSize: 30.0,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 10.0, right: 0.0),
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    //Color(0xffb43af7),
                                    //Color(0x0B52067),
                                    Colors.black,
                                    Colors.grey[800],

                                    //Color(0xff6d2af7),
                                  ],
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                //mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.trending_up,
                                    size: 42,
                                    color: Colors.grey,
                                  ),
                                  Column(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    //mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      /*
                                      Text(
                                        "Future Vaiue",
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),*/

                                      MaketStandard(
                                        presentValue: presentvalue,
                                        changePriceRate: changePriceRate,
                                        changePriceValue: changePriceValue,
                                        signal: signalstate[0], //isUpDown
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          GestureDetector(
                            child: Container(
                                margin: EdgeInsets.only(top: 10.0, right: 0.0),
                                padding: EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      //Color(0xffb43af7),
                                      //Color(0x0B52067),
                                      //Color(0xff6d2af7),
                                      Colors.black,
                                      Colors.grey[800],
                                    ],
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    //mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.attach_money,
                                        size: 42,
                                        color: Colors.grey,
                                      ),
                                      Column(
                                        //mainAxisAlignment: MainAxisAlignment.start,
                                        //mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Investment",
                                            style: TextStyle(
                                              fontSize: 30.0,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          PortFolio(
                                            portassetPrice:
                                                valuableAssetsSumString, //presentvalueSUm,
                                            portassetTotal:
                                                acquiredAssetsSumString, //valueSum,
                                            portassetvalue: gain,
                                            signal: isUpDown,
                                          ),
                                        ],
                                      ),
                                    ])),
                          ),
                        ]),
                  )),
              Positioned(
                left: 100.0,
                top: 5.0,
                child: Text(currentmonth /*+ '  ' + now.month.toString()*/,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              
              Positioned(
                right: 30.0,
                top: 33.0,
                child: CountDownTimer(),
              ),
              
              Positioned(
                right: 157.0,
                top: 0.0,
                child: FloatingActionButton.extended(
                  label: Text('60s'),
                  //icon: Icon(Icons.add),
                  //mini: true,
                  onPressed: () {
                    reload();
                  },
                ),
              ),
              Positioned(
                right: 5.0,
                bottom: 35.0,
                child: IconButton(
                  icon: Icon(Icons.grain),
                  color: Colors.blueGrey,
                  iconSize: 40,
                  onPressed: () {
                    _asyncInputDialog(context);
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
        ),
        Expanded(
          child: Container(
            //color: Colors.black54,
            child: listView(), //gridView1(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF02BB9F),
        primaryColorDark: const Color(0xFF167F67),
        accentColor: const Color(0xFF02BB9F),
      ),
      home: Scaffold(
        backgroundColor: Colors.black,
        //Color.fromARGB(0xFF, 0x04, 0x5B, 0x5B), //008A83//Colors.grey,
        //appBar: new AppBar(
        //  title: new Text("widget.title"),
        //),

        body: SafeArea(
          child: getBody(),
          //floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}

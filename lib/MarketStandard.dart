import 'package:flutter/material.dart';
//import 'debug/main_card.dart';
//import 'package:http/http.dart' as http;
//import 'PortFolio.dart';
//import 'ViewModel/Finance.dart';
//
//
//void main(){
//  runApp(MyApp());
//}
//void main() => runApp(MyApp());
//
/*Stateクラス
initState()
　最初に一度呼ばれる
　Widgetツリーの初期化を実行

didChangeDependencies()
　initState()呼び出し直後に呼ばれる
　Widgetツリーの変更を要素に通知する

build()
　didChangeDependencies()呼出し後にしか呼ばれない
　複数回呼ばれる
　Widgetツリーを置き換える

didUpdateWidget(Widget oldWidget)
　リビルド時のinitState()的な位置づけ

setState()
　任意で呼べるメソッド
　Widgetツリーを再構成して、変更を反映させる
　簡単な変数の代入だけでなく非同期処理でも使える

deactivate()
　StateをWidgetツリーから削除する
　滅多に使わないらしい

dispose()
　Stateを永続的に削除する
　画面をおとすときやストリーム停止で使うらしい

*/

/*
Future get_dowhtmls() async {
  List<String> dow = [];

  final response =
      await http.get('https://finance.yahoo.co.jp/quote/%5EDJI'); //^DJI
  String json = response.body;

  RegExp regprice = RegExp(r'"price":".*?"'); //RegExp(r"(\w+)");
  RegExp regchangePrice = RegExp(r'"changePrice":".*?"'); //RegExp(r"(\w+)");
  RegExp changePriceRate = RegExp(r'"changePriceRate":".*?"');

  List<String> price =
      regprice.allMatches(json).map((match) => match.group(0)).toList();
  dow.add(price[1].replaceAll(RegExp("[^0-9,.]"), ""));
  print(dow[0]);

  List<String> changeprice =
      regchangePrice.allMatches(json).map((match) => match.group(0)).toList();
  dow.add(changeprice[0].replaceAll(RegExp("[^-+0-9,.]"), ""));
  print(dow[1]);

  List<String> changepriceRate =
      changePriceRate.allMatches(json).map((match) => match.group(0)).toList();
  dow.add(changepriceRate[0].replaceAll(RegExp("[^-+0-9,.]"), ""));
  print(dow[2]);

  return dow;
}
*/
//Nikkey And NewYork Dow Display
class MaketStandard extends StatelessWidget {
  MaketStandard({this.dowValue, this.nikkeiValue});
  final List<String>? dowValue;
  final List<String>? nikkeiValue;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        //mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              CircleAvatar(
                maxRadius: 5.0,
                backgroundColor:
                    dowValue![3] == 'true' ? Colors.red : Colors.green,
              ),
              Text(
                "Dow Price: \$ ",
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                  fontFamily: 'NotoSansJP',
                  fontWeight: FontWeight.w900,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${dowValue![0]}',
                      style: TextStyle(
                        fontSize: 12.0, //fontWeight: FontWeight.bold,
                        fontFamily: 'NotoSansJP',
                        fontWeight: FontWeight.w900,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: <Widget>[
              SizedBox(width: 10),
              Text(
                "          The day before ratio: \$ ",
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                  fontFamily: 'NotoSansJP',
                  fontWeight: FontWeight.w900,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${dowValue![1] + "   " + dowValue![2] + "%"}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color:
                            dowValue![3] == 'true' ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // SizedBox(height: 10),

          Row(
            children: <Widget>[
              CircleAvatar(
                maxRadius: 5.0,
                backgroundColor:
                    nikkeiValue![3] == 'true' ? Colors.red : Colors.green,
              ),
              Text(
                "Nikkey Price: ￥ ",
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                  fontFamily: 'NotoSansJP',
                  fontWeight: FontWeight.w900,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${nikkeiValue![0]}',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'NotoSansJP',
                        fontWeight: FontWeight.w900,
                        color: Colors.blueAccent, //fontWeight: FontWeight.bold,
                      ),
                      //style: TextStyle(fontSize: 12.0,//fontWeight: FontWeight.bold,
                      //),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: <Widget>[
              SizedBox(width: 10),
              Text(
                "          The day before ratio: ￥ ",
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                  fontFamily: 'NotoSansJP',
                  fontWeight: FontWeight.w900,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${nikkeiValue![1] + "  " + nikkeiValue![2] + "%"}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: nikkeiValue![3] == 'true'
                            ? Colors.red
                            : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // SizedBox(height: 10),
          //Expanded(child:
          // ChipInputField(),
          /*
          DeliverooCard(
            //imgUrl:'https://cdn.pixabay.com/photo/2017/08/86/06/05/42/people-2589176_1280.jpg',
            imgUrl:'https://images.pexels.com/photos/639023/pexels-photo-639023.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
            title:'${presentValue[0]}',//'Big Fernand',
            subtitle:'${changePriceValue[0]}',//'Lorem ipsum dolor sit amet.',
            estimatedTime:'${changePriceValue[0]}',//'wait to 20 - 25 min',
          ),
          */
          //),
        ],
      ),
    );
  }
} //market

//Card Market

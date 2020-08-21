//import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
//import 'shared_prefs.dart';





String assetTotal;
String assetPrice;
String assetValue;


List<String> codeItems = []; //codekey
List<String> stockItems = [];//stock
List<String> valueItems = []; //value

List<String> acquiredAssetsItems = [];//取得資産 stock x value
List<String> valuableAssetsItems = [];//評価資産 stock X presentvalue
List<String> acquiredAssetsSumString = [];
List<String> valuableAssetsSumString = [];
int acquiredAssetsSum = 0;//取得資産合計
int valuableAssetsSum = 0;//評価資産合計
String presentvalueSUm;
String presentvalue;
String valueSum;
int _assetTotal=0;
int _assetPrice=0;
int _assetValue=0;
bool purchase = false;
int index=0;
String gain="0";
bool signalstate = true; //Up or Down

int assetTotalReturn()
{
  return _assetTotal;
}

int assetPriceReturn()
{
  return _assetPrice;
}

int assetValueReturn()
{
  _assetValue =_assetTotal - _assetPrice;
  return _assetValue;//assetValue;
}


class  StorageControl{
  //StorageControl(){}//コンストラクタ

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<String> readStorage() async {
    try {
      final file = await _localFile;

      /// Read the file
      String contents = await file.readAsString();
      print("Read to Data= " + contents);
      return contents;
    } catch (e) {
      //If we encounter an error, return 0/*
      return null;
    }
  }

  Future<File> writeStorage(String value) async {
    final file = await _localFile;
    print("Write to fileName= ${file.toString()}   " + value);
    /// Write the file
    return file.writeAsString(value);
  }
}






 





StorageControl storageControl = new StorageControl();

//////////////////////////////////
///
///
String dividend(){//配当
  return "https://info.finance.yahoo.co.jp/ranking/?kd=8&mk=1&tm=d&vl=a";
}

String priceRiseRate(){//値上率
  return "https://info.finance.yahoo.co.jp/ranking/?kd=1&mk=3&tm=d&vl=a";
}


String volume() {//出来高
  return  "https://info.finance.yahoo.co.jp/ranking/?kd=3&tm=d&mk=1";
}

String _geturlToFetch(String code) {
  return "https://stocks.finance.yahoo.co.jp/stocks/detail/?code="+ code ;//+".T";
}


String _urlToFetch(String code) {
  return "https://stocks.finance.yahoo.co.jp/stocks/detail/?code="+ code +".T";
}



  

  



Future<List<Price>> getserchi1(/*List getwidgets*/) async {
    String gcompanyName = "";
    String grealValue = "";
    String grealChange = "";
    String gpercent = "";
    bool change = true;
    

    //String responce ="6758,200,1665\n9837,200,712\n6976,200,1746\n";
    String responce ="998407,0,0\n^DJI,0,0\n";
    // String responce ="998407.O,0,0\n^DJI,0,0\n";
    List<Price> gprices = Finance.parse(responce);


    for(Price price in gprices) {
    	  http.Response response = await http.get(_geturlToFetch(price.code)/*dataURL*/);
      	final String json = response.body;

      	String searchWord = "symbol"; //検索する文字列symbol
      	int foundIndex = json.indexOf(searchWord, 0);
      	//始めの位置を探す
      	int nextIndex = foundIndex + searchWord.length;

      	foundIndex = json.indexOf(">", nextIndex);
      	int i = 5;//searchWord.length; //pricedata to point

      	if (foundIndex != -1) {
        	for (; json[foundIndex + i] != "<"; i++) {
          		gcompanyName += json[foundIndex + i]; //current value 現在値
        	}
      	} else {
        	//price[0] = "Error";
      	}

      	searchWord = "stoksPrice"; //検索する文字列 ="stoksPrice">
      	foundIndex = json.indexOf(searchWord); //始めの位置を探す
      	//次の検索開始位置
      	nextIndex = foundIndex + searchWord.length;

      	//次の位置を探す
      	foundIndex = json.indexOf(searchWord, nextIndex);
      	if (foundIndex != -1) {
        	int i = searchWord.length + 2; //pricedata to point
        	for (; json[foundIndex + i] != "<"; i++) {
          		grealValue += json[foundIndex + i]; //current value 現在値
        	}
      	} else {
        	//price[0] = "Error";
      	}

      	String searchWord1 = "yjMSt"; //検索する文字列前日比
      	int foundIndex1 = json.indexOf(searchWord1); //始めの位置を探す
      	int i1 = searchWord1.length + 2;

      	if (json[foundIndex1 + i1] == "+"){change = true;}//+-
      	else{change = false;}

      	for (; json[foundIndex1 + i1] != "（"; i1++) {
        	grealChange += json[foundIndex1 + i1]; //previous 前日比? ¥
      	}

      	i1++;
      	for (; json[foundIndex1 + i1] != "）"; i1++) {
        	gpercent += json[foundIndex1 + i1]; //previous 前日比? %
      	}

      	price.percentcheng=true;
      	price.polar= change;
      	//iconButtonToggle=true;//.polar;
      	price.name = gcompanyName;//企業名
      	price.getrealValue = grealValue;//realValue);//時価
      	price.prevday = grealChange;//前日比(円)
      	price.percent = gpercent;//前日比(%)
    

      	print(price.name);
      	print(price.realValue);
      	print(price.prevday);
      	print(price.percent);


      	gcompanyName = "";
      	grealValue = "";
      	grealChange = "";
      	gpercent = "";

		//getwidgets = gprices;  
   	}//for to end
	
    //setState(() {
     /*getwidgets =*/
     return gprices;//.toList();
    //});
}//load


Future<List<Price>> gridData( ) async {
    String companyName = "";
    String realValue = "";
    String realChange = "";
    String percent = "";
    bool change = true;
   
    
      

    //storageControl.writeStorage("6758,200,1665\n6976,300,1804\n7575,0,0\n6029,0,0\n2685,0,0\n3172,0,0\n");
   
    //String responce = await storageControl.readStorage();
    //String responce = responceBuff;
    String responce ="6758,200,1665\n6976,400,1804\n6904,100,1030\n";
    List<Price> prices = Finance.parse(responce);


    for(Price price in prices) {

      http.Response response = await http.get(_urlToFetch(price.code)/*dataURL*/);
      final String json = response.body;

      String searchWord = "symbol"; //検索する文字列symbol
      int foundIndex = json.indexOf(searchWord, 0);
      //始めの位置を探す
      int nextIndex = foundIndex + searchWord.length;

      foundIndex = json.indexOf(">", nextIndex);
      int i = 5;//searchWord.length; //pricedata to point

      if (foundIndex != -1) {
        for (; json[foundIndex + i] != "<"; i++) {
          companyName += json[foundIndex + i]; //current value 現在値
        }
      } else {
        //price[0] = "Error";
      }

      searchWord = "stoksPrice"; //検索する文字列 ="stoksPrice">
      foundIndex = json.indexOf(searchWord); //始めの位置を探す
      //次の検索開始位置
      nextIndex = foundIndex + searchWord.length;

      //次の位置を探す
      foundIndex = json.indexOf(searchWord, nextIndex);
      if (foundIndex != -1) {
        int i = searchWord.length + 2; //pricedata to point
        for (; json[foundIndex + i] != "<"; i++) {
          realValue += json[foundIndex + i]; //current value 現在値
        }
      } else {
        //price[0] = "Error";
      }

      String searchWord1 = "yjMSt"; //検索する文字列前日比
      int foundIndex1 = json.indexOf(searchWord1); //始めの位置を探す
      int i1 = searchWord1.length + 2;

      if (json[foundIndex1 + i1] == "+"){change = true;}//+-
      else{change = false;}
      for (; json[foundIndex1 + i1] != "（"; i1++) {
        realChange += json[foundIndex1 + i1]; //previous 前日比? ¥
      }

      i1++;
      for (; json[foundIndex1 + i1] != "）"; i1++) {
        percent += json[foundIndex1 + i1]; //previous 前日比? %
      }

      price.percentcheng=true;
      price.polar= change;
      //iconButtonToggle=true;//.polar;
      price.name = companyName;//企業名
      price.realValue =  toIntger(realValue);//realValue);//時価
      price.prevday = realChange;//前日比(円)
      price.percent = percent;//前日比(%)
      price.gain = (price.realValue - int.parse(price.itemprice))*int.parse(price.stocks);// (時価 - 購入価格)X買付数
      price.totalAsset = int.parse(price.stocks) * price.realValue;//買付数ｘ時価

      _assetTotal += price.totalAsset;
      _assetPrice += (int.parse(price.itemprice))*int.parse(price.stocks);

      print(price.name);
      print(price.realValue);
      print(price.prevday);
      print(price.percent);


      companyName = "";
      realValue = "";
      realChange = "";
      percent = "";
  
  }//for to end

   //setState(() {
    assetTotal =  _assetTotal.toString();
    assetPrice =  _assetPrice.toString();
    assetValue = (_assetTotal - _assetPrice).toString();
  
    /*widgets =*/
    return prices;
  //});

 }//load






Future<List<List<String>>> riseRate1(/*List rategets*/) async {
  String gcompanyName = "";
  String gcompanycode = "";
  String grealValue = ""; 
    
  
  
  http.Response response = await http.get(priceRiseRate()/*dataURL*/);
  final String json = response.body;
  int foundIndex =0;// = json.indexOf(searchWord, 0);
      
      //Rise grises = new Rise();// = Finance.parse(responce);
      //Rise [] grises = new List<Rise>();
      //List grises = new List[[],[]];
  List<List<String>> grises = List.generate(10, (_) => List.generate(3, (_) => null));
      //List grises = new List<Rise>(1);

  for(int l =0; l < 5;++l) {
    String searchWord = "/?code="; //検索する文字列symbol
    foundIndex = json.indexOf(searchWord,foundIndex);
    //始めの位置を探す
    //int nextIndex = foundIndex + searchWord.length;

    foundIndex =  foundIndex + searchWord.length;//nextIndex;//.indexOf(".", nextIndex);
    int i = 0;//searchWord.length; //pricedata to point

    if (foundIndex != -1) {
      for (; json[foundIndex + i] != "."; i++) {
        gcompanycode += json[foundIndex + i]; //current value 現在値
      }
      } else {
        //price[0] = "Error";
      }

      searchWord = "normal yjSt"; //検索する文字列 ="stoksPrice">
      foundIndex = json.indexOf(searchWord,foundIndex); //始めの位置を探す
      //次の検索開始位置
      //nextIndex = foundIndex + searchWord.length;

      //次の位置を探す
      foundIndex = json.indexOf(">", foundIndex + searchWord.length/*nextIndex*/);
      if (foundIndex != -1) {
        int i = 1; //pricedata to point
        for (; json[foundIndex + i] != "<"; i++) {
          gcompanyName += json[foundIndex + i]; //current value 現在値
        }
      } else {
        //price[0] = "Error";
      }

      searchWord = "txtright bold"; //検索する文字列前日比
      foundIndex = json.indexOf(searchWord,foundIndex); //始めの位置を探す
      
      //次の検索開始位置
      foundIndex = foundIndex + searchWord.length;

      //次の位置を探す
      foundIndex = json.indexOf(">", foundIndex);
      if (foundIndex != -1) {
        int i = 1; //pricedata to point
        for (; json[foundIndex + i] != "<"; i++) {
          grealValue += json[foundIndex + i]; //current value 現在値
        }
      } else {
        //price[0] = "Error";
      }
      print(gcompanycode+" ");
      print(gcompanyName+" ");
      print(grealValue+" ");
      

     // Rise.code =  gcompanycode;
      grises[l][0] = gcompanycode;
      grises[l][1] = gcompanyName;
      grises[l][2] = grealValue;


      gcompanycode = "";
      gcompanyName = "";
      grealValue ="";

   }//for to end

   //setState(() {
       /*rategets =*/return grises;
   // });
     
      //gpercent = "";

 }//load


  Future<List<List<String>>> volumeranking1(/*List volumegats*/) async {
    String gcompanyName = "";
    String gcompanycode = "";
    String grealValue = "";  
  

   
      http.Response response = await http.get(volume()/*dataURL*/);
      final String json = response.body;
      int foundIndex =0;// = json.indexOf(searchWord, 0);
      
      //Rise grises = new Rise();// = Finance.parse(responce);
      //Rise [] grises = new List<Rise>();
      //List grises = new List[[],[]];
      List<List<String>> grises = List.generate(10, (_) => List.generate(3, (_) => null));
      //List grises = new List<Rise>(1);

    for(int l =0; l < 5;++l) {
      String searchWord = "/?code="; //検索する文字列symbol
      foundIndex = json.indexOf(searchWord,foundIndex);
      //始めの位置を探す
      //int nextIndex = foundIndex + searchWord.length;

      foundIndex =  foundIndex + searchWord.length;//nextIndex;//.indexOf(".", nextIndex);
      int i = 0;//searchWord.length; //pricedata to point

      if (foundIndex != -1) {
        for (; json[foundIndex + i] != "."; i++) {
          gcompanycode += json[foundIndex + i]; //current value 現在値
        }
      } else {
        //price[0] = "Error";
      }

      searchWord = "normal yjSt"; //検索する文字列 ="stoksPrice">
      foundIndex = json.indexOf(searchWord,foundIndex); //始めの位置を探す
      //次の検索開始位置
      //nextIndex = foundIndex + searchWord.length;

      //次の位置を探す
      foundIndex = json.indexOf(">", foundIndex + searchWord.length/*nextIndex*/);
      if (foundIndex != -1) {
        int i = 1; //pricedata to point
        for (; json[foundIndex + i] != "<"; i++) {
          gcompanyName += json[foundIndex + i]; //current value 現在値
        }
      } else {
        //price[0] = "Error";
      }

      searchWord = "txtright bold"; //検索する文字列前日比
      foundIndex = json.indexOf(searchWord,foundIndex); //始めの位置を探す
      
      //次の検索開始位置
      foundIndex = foundIndex + searchWord.length;

      //次の位置を探す
      foundIndex = json.indexOf(">", foundIndex);
      if (foundIndex != -1) {
        int i = 1; //pricedata to point
        for (; json[foundIndex + i] != "<"; i++) {
          grealValue += json[foundIndex + i]; //current value 現在値
        }
      } else {
        //price[0] = "Error";
      }
      print(gcompanycode+" ");
      print(gcompanyName+" ");
      print(grealValue+" ");
      

     // Rise.code =  gcompanycode;
      grises[l][0] = gcompanycode;
      grises[l][1] = gcompanyName;
      grises[l][2] = grealValue;


      gcompanycode = "";
      gcompanyName = "";
      grealValue ="";

   }//for to end

   //setState(() {
       /*volumegats =*/ return grises;
    //});
     
      //gpercent = "";

 }//load
















////////////////////////////////////////////////////

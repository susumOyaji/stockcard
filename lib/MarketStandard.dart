import 'package:flutter/material.dart';
import 'main_card.dart';
//import 'PortFolio.dart';
//import 'ViewModel/Finance.dart';

//Nikkey And NewYork Dow Display
class MaketStandard extends StatelessWidget {
  MaketStandard(
      {this.presentValue,
      this.changePriceRate,
      this.changePriceValue,
      this.signal});
  final List<String> presentValue;
  final List<String> changePriceRate;
  final List<String> changePriceValue;
  final bool signal;

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
                backgroundColor: Colors.green,
              ),
              Text(
                "Dow Price",
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
                      text: '${presentValue[1]}',
                      style: TextStyle(
                        fontSize: 12.0, //fontWeight: FontWeight.bold,
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
                "The day before ratio",
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
                      text: '${changePriceValue[1]}',
                      style: TextStyle(
                        fontSize: 10.0, //fontWeight: FontWeight.bold,
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
                backgroundColor: signal ? Colors.red : Colors.green,
              ),
              Text(
                "Nikkey Price",
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
                      text: '${presentValue[0]}',
                      style: TextStyle(
                        fontSize: 10.0,
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
                "The day before ratio",
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
                      text: '${changePriceValue[0]}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: signal ? Colors.red : Colors.green,
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

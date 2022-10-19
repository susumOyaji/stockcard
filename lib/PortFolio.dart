import 'package:flutter/material.dart';
//mport 'main.dart';

//Parsonal Data Disp
class PortFolio extends StatelessWidget {
  PortFolio(
      {this.portassetPrice,
      this.portassetTotal,
      this.portassetvalue,
      this.signal});
  final String? portassetPrice;
  final String? portassetTotal;
  final String? portassetvalue;
  final bool? signal;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        //mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              CircleAvatar(
                maxRadius: 5.0,
                backgroundColor:
                    signal! ? Colors.orange : Colors.green, //Colors.green,
              ),
              Text(
                "Market price: ", //"Gain or loss",
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
                      text: '$portassetPrice',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: signal! ? Colors.orange : Colors.green,
                        fontWeight: FontWeight.bold,
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
              //Text("The day before ratio",
              //  style: TextStyle(fontSize: 10.0, color: Colors.white),
              //),
              Text(
                "Profit(Gains)", //"Gain or loss", //"Market price",
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
                      text: '$portassetvalue',
                      style: TextStyle(
                        fontSize: 12.0, //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Text(
                "Investment",
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
                      text: '$portassetTotal',
                      style: TextStyle(
                        fontSize: 12.0, //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

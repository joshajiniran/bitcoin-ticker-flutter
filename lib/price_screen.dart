import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';

import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedValue = currenciesList[0];
  int exchangeRate = 0;
  CoinData coinData = CoinData();

  void getCoinDataRate() async {
    var data = await coinData.getCoinData();
    // convert data to int
    double convertedData = data["rate"];
    setState(() {
      exchangeRate = convertedData.toInt();
    });
  }

  Widget _buildAndroidPicker() {
    return DropdownButton(
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            selectedValue = value;
            getCoinDataRate();
          });
        },
        // elevation: 5,
        items: currenciesList
            .map((e) => new DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ))
            .toList());
  }

  Widget _buildIOSPicker() {
    return CupertinoPicker(
      itemExtent: 40,
      onSelectedItemChanged: (int value) {
        print(currenciesList[value]);
      },
      children: currenciesList.map((e) => Text(e)).toList(),
    );
  }

  @override
  void initState() {
    super.initState();
    getCoinDataRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${exchangeRate.round()} USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:
                Platform.isAndroid ? _buildAndroidPicker() : _buildIOSPicker(),
          ),
        ],
      ),
    );
  }
}

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
  var cryptoAPIData = Map<String, int>();

  void getCoinDataRate() async {
    cryptoAPIData = await coinData.getCoinData(selectedValue);

    setState(() {
      cryptoAPIData = cryptoAPIData;
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

  List<Widget> _buildCryptoCards() {
    return cryptoList
        .map(
          (e) => CryptoCard(
            crypto: e,
            exchangeRate: cryptoAPIData[e],
            selectedValue: selectedValue,
          ),
        )
        .toList();
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
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildCryptoCards(),
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

class CryptoCard extends StatelessWidget {
  const CryptoCard({
    Key key,
    @required this.exchangeRate,
    @required this.selectedValue,
    @required this.crypto,
  }) : super(key: key);

  final int exchangeRate;
  final String selectedValue;
  final String crypto;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            '1 $crypto = $exchangeRate $selectedValue',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

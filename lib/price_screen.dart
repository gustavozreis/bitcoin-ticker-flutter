import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker_two/coin_data.dart';
import 'dart:io' show Platform;
import 'package:bitcoin_ticker_two/widgets/ticker.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'USD';
  String? btcRate = '0.0';
  CoinData coinData = CoinData();
  List<Padding> tickerList = [];

  @override
  void initState() {
    super.initState();
    getRates();
  }

  Future<void> getRates() async {
    List<Padding> tempList = [];
    for (String coin in cryptoList) {
      var coinRateInDouble = await coinData.getRate(coin, selectedCurrency!);
      print(coinRateInDouble);
      var coinRateInString = coinRateInDouble.toStringAsFixed(2);
      print('$coinRateInString $selectedCurrency');
      tempList.add(
        Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: MainTicker(
                coin: coin,
                rate: coinRateInString,
                selectedCurrency: selectedCurrency!)),
      );
    }
    setState(() {
      tickerList = tempList;
    });
  }

  Widget? getPicker() {
    if (Platform.isIOS) {
      return iOSPicker();
    } else if (Platform.isAndroid) {
      return getDropDownButton();
    }
  }

  DropdownButton<String> getDropDownButton() {
    List<DropdownMenuItem<String>> currencyList = [];
    for (String currency in currenciesList) {
      currencyList.add(
        DropdownMenuItem(child: Text(currency), value: currency),
      );
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currencyList,
      onChanged: (value) {
        setState(() async {
          selectedCurrency = value;
          await getRates();
        });
        print(value);
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> currencyList = [];
    List<String> currencyListString = [];
    for (String currency in currenciesList) {
      currencyList.add(Text(
        currency,
        style: TextStyle(color: Colors.white),
      ));
      currencyListString.add(currency);
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currencyListString[selectedIndex];
        });
      },
      children: currencyList,
    );
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
          Column(children: tickerList),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getPicker(),
          ),
        ],
      ),
    );
  }
}

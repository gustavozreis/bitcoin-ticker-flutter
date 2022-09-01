import 'package:flutter/material.dart';

class MainTicker extends StatefulWidget {
  const MainTicker(
      {Key? key,
      required this.coin,
      required this.rate,
      required this.selectedCurrency})
      : super(key: key);
  final String? coin;
  final String? rate;
  final String? selectedCurrency;

  @override
  State<MainTicker> createState() => _MainTickerState();
}

class _MainTickerState extends State<MainTicker> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 ${widget.coin} = ${widget.rate} ${widget.selectedCurrency}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

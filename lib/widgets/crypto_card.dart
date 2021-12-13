import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  final String coinName;
  final String coinRate;
  final String currency;

  CryptoCard(
      {required this.coinName, required this.coinRate, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
        ),
        child: Text(
          '1 $coinName = $coinRate $currency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}

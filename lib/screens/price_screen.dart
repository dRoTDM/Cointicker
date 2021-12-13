import 'package:cointicker/services/coin_data.dart';
import 'package:cointicker/utilities/constants.dart';
import 'package:cointicker/widgets/crypto_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinModel coinModel = CoinModel();
  String currency = 'AUD';
  String btcCoinRate = '?';
  String ethCoinRate = '?';
  String ltcCoinRate = '?';
  String dogeCoinRate = '?';

  @override
  void initState() {
    super.initState();
    getCurrencyRate(currency);
  }

  DropdownButton<String> getDropdownButtonForAndroid() {
    List<DropdownMenuItem<String>> dropDownMenuItems = [];

    for (String currency in kCurrenciesList) {
      dropDownMenuItems.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }

    return DropdownButton<String>(
      value: currency,
      items: dropDownMenuItems,
      onChanged: (currency) {
        getCurrencyRate(currency!);
      },
    );
  }

  CupertinoPicker getCupertinoPickerForIOS() {
    List<Text> currencies = [];

    for (String currency in kCurrenciesList) {
      currencies.add(
        Text(
          currency,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }

    return CupertinoPicker(
      itemExtent: 40.0,
      children: currencies,
      onSelectedItemChanged: (currencyIndex) {
        getCurrencyRate(kCurrenciesList[currencyIndex]);
      },
    );
  }

  void updateUI(String curr) {
    setState(() {
      if (coinModel.btcCoinRate == null) {
        Alert(
                context: context,
                title: "ERROR",
                desc: "Unable to get the coin rates.")
            .show();
        btcCoinRate = 'Error';
        ethCoinRate = 'Error';
        ltcCoinRate = 'Error';
        dogeCoinRate = 'Error';
      } else {
        btcCoinRate = coinModel.btcCoinRate!;
        ethCoinRate = coinModel.ethCoinRate!;
        ltcCoinRate = coinModel.ltcCoinRate!;
        dogeCoinRate = coinModel.dogeCoinRate!;
      }
      currency = curr;
    });
  }

  void getCurrencyRate(String currency) async {
    await coinModel.getCurrencyRate(currency);
    updateUI(currency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                18.0,
                18.0,
                18.0,
                0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CryptoCard(
                      coinName: 'BTC',
                      coinRate: btcCoinRate,
                      currency: currency),
                  SizedBox(
                    height: 10.0,
                  ),
                  CryptoCard(
                      coinName: 'ETH',
                      coinRate: ethCoinRate,
                      currency: currency),
                  SizedBox(
                    height: 10.0,
                  ),
                  CryptoCard(
                      coinName: 'LTC',
                      coinRate: ltcCoinRate,
                      currency: currency),
                  SizedBox(
                    height: 10.0,
                  ),
                  CryptoCard(
                      coinName: 'DOGE',
                      coinRate: dogeCoinRate,
                      currency: currency),
                ],
              ),
            ),
            Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS
                  ? getCupertinoPickerForIOS()
                  : getDropdownButtonForAndroid(),
            ),
          ],
        ),
      ),
    );
  }
}

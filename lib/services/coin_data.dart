import 'package:cointicker/utilities/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoinModel {
  String? btcCoinRate;
  String? ethCoinRate;
  String? ltcCoinRate;
  String? dogeCoinRate;

  Future<void> getCurrencyRate(String currency) async {
    for (int i = 0; i < kCryptoList.length; i++) {
      String coinAPIURL =
          'https://rest.coinapi.io/v1/exchangerate/${kCryptoList[i]}/$currency/?apikey=$kCoinAPIKey';
      http.Response response = await http.get(Uri.parse(coinAPIURL));

      if (response.statusCode == 200) {
        if (i == 0) {
          double coinRate = jsonDecode(response.body)['rate'];
          btcCoinRate = coinRate.toStringAsFixed(2);
        } else if (i == 1) {
          double coinRate = jsonDecode(response.body)['rate'];
          ethCoinRate = coinRate.toStringAsFixed(2);
        } else if (i == 2) {
          double coinRate = jsonDecode(response.body)['rate'];
          ltcCoinRate = coinRate.toStringAsFixed(2);
        } else {
          double coinRate = jsonDecode(response.body)['rate'];
          dogeCoinRate = coinRate.toStringAsFixed(2);
        }
      } else {
        btcCoinRate = null;
        print('Error status code: ${response.statusCode}');
      }
    }
  }
}

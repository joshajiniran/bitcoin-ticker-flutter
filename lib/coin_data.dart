import 'networking.dart';

const apiKey = '919C70AE-3029-4A9C-9DB5-AA2B7E61A402';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<Map<String, int>> getCoinData(String currency) async {
    var cryptoData = Map<String, int>();
    for (String crypto in cryptoList) {
      String coinDataURL =
          'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency';
      NetworkHelper networkHelper =
          NetworkHelper(coinDataURL, {'X-CoinApi-Key': apiKey});
      var coinData = await networkHelper.getData(); // get the data from the api
      double convertedData = coinData["rate"];
      cryptoData[crypto] = convertedData.round();
    }
    print(cryptoData);
    return cryptoData;
  }
}

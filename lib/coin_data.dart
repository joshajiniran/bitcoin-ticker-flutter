import 'networking.dart';

const apiKey = '919C70AE-3029-4A9C-9DB5-AA2B7E61A402';
const coinDataURL = 'https://rest.coinapi.io/v1/exchangerate/BTC/USD';

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
  Future<dynamic> getCoinData() async {
    NetworkHelper networkHelper =
        NetworkHelper(coinDataURL, {'X-CoinApi-Key': apiKey});

    var coinData = await networkHelper.getData();
    return coinData;
  }
}

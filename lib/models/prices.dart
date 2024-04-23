import 'dart:convert';
import 'package:http/http.dart' as http;

class Currency {
  String name;
  double ask;
  double bid;
  DateTime date;
  Currency(this.name, this.ask, this.bid, this.date);

  // Constructor that fetches data from the API during initialization
  Currency.fromApiUrl(String apiUrl)
      : name = "",
        ask = 0,
        bid = 0,
        date = DateTime.now() {
    fetchData(apiUrl);
  }

  Future<void> fetchData(String apiUrl) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Parse the JSON response
      Map<String, dynamic> jsonData = json.decode(response.body);

      // Extract exchange, coin, and fiat from the JSON data
      name = "USDC";
      ask = jsonData['ask'];
      bid = jsonData['bid'];
      date = DateTime.now();
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }
}

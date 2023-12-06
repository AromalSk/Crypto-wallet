import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart%20';

// 

Future<double>getPrice(String id)async{
try {
 
  var response =await http.get(Uri.parse("https://api.coingecko.com/api/v3/coins/$id"));
  var json = jsonDecode(response.body);
  var value = json['market_data']['current_price']['inr'].toString();
  return double.parse(value);
} catch (e) {
  print(e.toString());
  return 0;
}
}
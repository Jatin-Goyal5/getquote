import 'dart:convert';
import 'dart:math';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Quotes with ChangeNotifier {
  Gradient _color =LinearGradient(
      colors: [Colors.deepPurple, Colors.deepOrange, Colors.pink]);
  String text="wait";

  List<String> _quotes=[];

  Gradient getColor() {

    var rng = new Random();
    List<Gradient> _color1 = [
      new LinearGradient(
        colors:[Colors.black54, Colors.red, Colors.lightBlue]),
      new LinearGradient(
        colors:[Colors.blueAccent, Colors.green, Colors.grey,]),
        LinearGradient(
        colors: [Colors.deepPurple, Colors.deepOrange, Colors.pink]),
    ];
    _color = _color1[rng.nextInt(_color1.length)];
    notifyListeners();
    return _color;
  }

  Future<void> getQuotes() async {
    const url = "https://type.fit/api/quotes";
    var response = await http.get(url);
    var itemCount;
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      itemCount = jsonResponse['text'];
      //print('Number of books about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return itemCount;
  }

  Future<void> fetchAndSetProducts() async {
    var rng = new Random();
    const url = 'https://type.fit/api/quotes';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List<dynamic>;

     extractedData.forEach((element) {
       _quotes.add(element['text']);
       print(_quotes);
      });

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
  List<String> getall(){
    return _quotes;
  }
}
import 'dart:convert';
import 'dart:math';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Quotes with ChangeNotifier {
  Color color =Colors.deepPurple;
  String text="wait";

  List<String> quotes=[];

  void getColor() {

    var rng = new Random();
    List<Color> _color1 = [
      Colors.black54, Colors.red, Colors.lightBlue,
      Colors.blueAccent, Colors.green, Colors.grey,
      Colors.deepPurple, Colors.deepOrange, Colors.pink,
    ];
    color = _color1[rng.nextInt(_color1.length)];
    notifyListeners();
    
  }

  // Future<void> getQuotes() async {
  //   const url = "https://type.fit/api/quotes";
  //   var response = await http.get(url);
  //   var itemCount;
  //   if (response.statusCode == 200) {
  //     var jsonResponse = convert.jsonDecode(response.body);
  //     itemCount = jsonResponse['text'];
  //     //print('Number of books about http: $itemCount.');
  //   } else {
  //     print('Request failed with status: ${response.statusCode}.');
  //   }

  //   return itemCount;
  // }

  Future<void> fetchAndSetProducts() async {
    
    const url = 'https://type.fit/api/quotes';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List<dynamic>;
      final List<String> duplicate=[];
     extractedData.forEach((element) {
       duplicate.add(element['text']);
       print(duplicate);
      });
      quotes = duplicate;
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
  
}
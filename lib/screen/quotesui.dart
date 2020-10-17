
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getquote/data/quotedata.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:provider/provider.dart';

class quoteui extends StatefulWidget {
  @override
  _quoteuiState createState() => _quoteuiState();
}

class _quoteuiState extends State<quoteui> {
  @override
  var _isInit = true;
  var _isLoading = false;
  var rng = new Random();

  

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();

  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final res = Provider.of<Quotes>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    final quotes = Provider.of<Quotes>(context);

    List<String> my=quotes.getall();
    String tr = my[rng.nextInt(150)];

    return Scaffold(
      backgroundColor:Colors.amber ,
      body: Center(
        child: new FlatButton(
          child: _isLoading?CircularProgressIndicator():GradientText(
            tr,gradient: quotes.getColor(),
            style: TextStyle(
              fontSize: 36.0,
              fontStyle: FontStyle.italic
            ),
          ),
          onPressed: (){
            setState(() {
              tr=my[rng.nextInt(150)];
            });
            },

        ),
      )
    );
  }
}


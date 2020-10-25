
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
  String tr = "";
  var _checkState= true;
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
    if (_checkState) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Quotes>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _checkState = false;
          _isLoading = false;
        });
      });
    }
    _checkState = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    final myquotes = Provider.of<Quotes>(context);

    List<String> my=myquotes.quotes;
  
  

    return Scaffold(
      backgroundColor:myquotes.color ,
      body: Center(
        child: new FlatButton(
          child: _isLoading?Center(child: CircularProgressIndicator()):Text(
            my[rng.nextInt(my.length)],
            style: TextStyle(
              color:  Colors.white,
              fontSize: 36.0,
              fontStyle: FontStyle.italic
            ),
          ),
          onPressed: (){
            setState(() {
              myquotes.getColor();
              tr=my[rng.nextInt(150)];
            });
            },

        ),
      )
    );
  }
}


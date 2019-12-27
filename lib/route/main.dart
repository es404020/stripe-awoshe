

import 'package:flutter/material.dart';
import 'package:stripe/screens/main.dart';



class Router{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args  = settings.arguments;





    switch(settings.name){
      case MyHomePage.id:
        return MaterialPageRoute(builder: (_)=>MyHomePage());
      case Auth.id:
        return MaterialPageRoute(builder: (_)=>Auth());


      default:
        return _errorPage();
    }


  }
  static Route<dynamic> _errorPage(){
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("error page"),
        ),
        body: Center(
          child: Text("ERROR"),
        ),
      );
    });
  }
}
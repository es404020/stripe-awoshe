import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stripe/route/main.dart';
import 'package:stripe/screens/main.dart';
import 'package:provider/provider.dart';
import 'package:stripe/service/main.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value: AuthService().user)
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        initialRoute: Auth.id,
        onGenerateRoute:Router.generateRoute,
      ),
    );
  }
}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stripe/screens/main.dart';
import 'package:stripe/service/auth.dart';

class Auth extends StatefulWidget {
  static const id = '/auth';
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {

  AuthService auth = new AuthService();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    return user?.uid!=null?MyHomePage():  Scaffold(
      body: Container(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(child: Text("Awoshe Stripe",style: TextStyle(fontSize: 32),)),
            SizedBox(height: 20.0,),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.6,
              child: RaisedButton(
                child: Text("Google",style: TextStyle(color: Colors.white),),
                color: Colors.red,
                onPressed: (){
            auth.handleSignIn().then((res)=>{
                  Navigator.of(context).pushReplacementNamed(MyHomePage.id)
                  }) .catchError((err)=>{
                    print(err+'mess'),

              print('err'),

//                    setState((){
//                      final snackBar = SnackBar(content: Text('Are you talkin\' to me?'));
//                      _scaffoldKey.currentState.showSnackBar(snackBar);
//                    })


            });

                  //
                },
              ),
            )
          ],
        ),
      ),
    );
  }

}

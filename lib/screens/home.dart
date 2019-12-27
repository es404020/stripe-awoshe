import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:cloud_functions/cloud_functions.dart';




class MyHomePage extends StatefulWidget {
  static const id = '/';
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


// Test credit card to test
  final CreditCard testCard = CreditCard(
      number: '4242424242424242',
      expMonth: 12,
      expYear: 2020,
      cvc: '220'
  );

  //setup callable functions to invoke the stripeCreatecCharge function.
  final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
    functionName: 'stripeCreateCharge',
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //strip configuration
    StripePayment.setOptions(
   StripeOptions(publishableKey: "pk_test_bmKaaXC29wfXG1qkfkiLM1NG00FqjisU24", merchantId: "Test", androidPayMode: 'test'));


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Make test payment:',
            ),
            RaisedButton(
              child: Text("pay 3000 eurs"),
              onPressed: () {

                //configure data sourseparame
                StripePayment.createSourceWithParams(
                    SourceParams(
                      type: 'ideal',
                      currency: 'eur',
                      returnURL: 'example://stripe-redirect',
                      card: testCard,
                      amount: 3000

                    )

                ).then((paymentMethod) async {
  // Note: Callable functions would on work when billing is enabled on firebase console
                  dynamic resp = await callable.call(<String, dynamic>{
                   'source': paymentMethod.sourceId,
                    'amount':paymentMethod.amount
                  });



                }).catchError((setError)=>AlertManger(context,setError));
              },
            )
          ],
        ),
      ),

    );
  }


  AlertManger(context,dynamic error){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(

          content: Text(error.toString()),
        );
      },
    );
  }
}

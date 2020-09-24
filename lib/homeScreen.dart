import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class HomeScrenn extends StatefulWidget {
  @override
  _HomeScrennState createState() => _HomeScrennState();
}

class _HomeScrennState extends State<HomeScrenn> {
  Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();
  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlePaymentWallet);
  }

  @override
  void dispose() {
    super.dispose();

    razorpay.clear();
  }

  void opencheckOut() {
    var options = {
      'key': 'rzp_test_80I7w1TLyQKUpL',
      'amount': num.parse(textEditingController.text) * 100,
      'name': "Payment app",
      'description': 'Ashish Torane',
      'prefill': {'contact': "9689798759", 'email': "toraneashish7@gmail.com"},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (err) {
      print(err);
    }
  }

  void handlePaymentSuccess() {}
  void handlePaymentError() {}
  void handlePaymentWallet() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Payment with RazorPay'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(labelText: 'Enter Amount'),
              ),
              RaisedButton.icon(
                  onPressed: () {
                    opencheckOut();
                  },
                  icon: Icon(Icons.payment),
                  label: Text('Done'))
            ],
          ),
        ));
  }
}

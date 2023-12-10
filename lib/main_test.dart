/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:razorpay_flutter/razorpay_flutter.dart';// Import your UpiTurbo class
import 'Model/Error.dart';
import 'Model/upi_account.dart';
import 'upi_turbo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController keyController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController orderIdController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  // Your Razorpay Key ID
  String merchantKeyValue = "rzp_test_3qO5LzXq0URltM";
  String amountValue = "100";
  String orderIdValue = "";
  String mobileNumberValue = "8888888888";

  late Razorpay razorpay;
  late UpiTurbo upiTurbo;
  final MethodChannel _channel = MethodChannel('your_channel_name');

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
    upiTurbo = UpiTurbo(_channel); // Initialize your custom UpiTurbo
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              RZPEditText(
                controller: keyController,
                textInputType: TextInputType.text,
                hintText: 'Enter Key',
                labelText: 'Merchant Key',
              ),
              RZPEditText(
                controller: amountController,
                textInputType: TextInputType.number,
                hintText: 'Enter Amount',
                labelText: 'Amount',
              ),
              RZPEditText(
                controller: orderIdController,
                textInputType: TextInputType.text,
                hintText: 'Enter Order Id',
                labelText: 'Order Id',
              ),
              RZPEditText(
                controller: mobileNumberController,
                textInputType: TextInputType.number,
                hintText: 'Enter Mobile Number',
                labelText: 'Mobile Number',
              ),
              Container(
                margin: EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
                child: Text(
                  '* Note - In case of TPV the orderId is mandatory.',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: RZPButton(
                      widthSize: 200.0,
                      onPressed: () {
                        merchantKeyValue = keyController.text;
                        amountValue = amountController.text;
                        razorpay.open(getPaymentOptions());
                      },
                      labelText: 'Standard Checkout Pay',
                    ),
                  ),
                  Expanded(
                    child: RZPButton(
                      widthSize: 200.0,
                      onPressed: () {
                        merchantKeyValue = keyController.text;
                        amountValue = amountController.text;
                        mobileNumberValue = mobileNumberController.text;
                        orderIdValue = orderIdController.text;
                        razorpay.open(getTurboPaymentOptions());
                      },
                      labelText: 'Turbo Pay',
                    ),
                  ),
                ],
              ),
              RZPButton(
                widthSize: 200.0,
                labelText: "Link New Upi Account",
                onPressed: () {
                  mobileNumberValue = mobileNumberController.text;
                  upiTurbo.linkNewUpiAccount(
                    customerMobile: mobileNumberValue,
                    color: "#ffffff",
                    onSuccess: (List<UpiAccount> upiAccounts) {
                      print("Successfully Onboarded Account : ${upiAccounts.length}");
                    },
                    onFailure: (Error error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error : ${error.errorDescription}")),
                      );
                    },
                  );
                },
              ),
              RZPButton(
                widthSize: 200.0,
                labelText: "Manage Upi Account",
                onPressed: () {
                  mobileNumberValue = mobileNumberController.text;
                  upiTurbo.manageUpiAccounts(
                    customerMobile: mobileNumberValue,
                    color: "#ffffff",
                    onFailure: (Error error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error : ${error.errorDescription}")),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, Object> getPaymentOptions() {
    return {
      'key': '$merchantKeyValue',
      'amount': int.parse(amountValue),
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': '$mobileNumberValue',
        'email': 'test@razorpay.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };
  }

  Map<String, Object> getTurboPaymentOptions() {
    return {
      'amount': int.parse(amountValue),
      'currency': 'INR',
      'prefill': {
        'contact': '$mobileNumberValue',
        'email': 'test@razorpay.com'
      },
      'theme': {
        'color': '#0CA72F'
      },
      'send_sms_hash': true,
      'retry': {
        'enabled': false,
        'max_count': 4
      },
      'key': '$merchantKeyValue',
      'order_id': '$orderIdValue',
      'disable_redesign_v15': false,
      'experiments.upi_turbo': true,
      'ep': 'https://api-web-turbo-upi.ext.dev.razorpay.in/test/checkout.html?branch=feat/turbo/tpv'
    };
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        ElevatedButton(
          child: const Text("Close"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void dispose() {
    // Dispose controllers and Razorpay instance
    keyController.dispose();
    amountController.dispose();
    orderIdController.dispose();
    mobileNumberController.dispose();
    razorpay.clear(); // Clear event listeners
    super.dispose();
  }
}

class RZPButton extends StatelessWidget {
  final String labelText;
  final VoidCallback onPressed;
  final double widthSize;

  RZPButton({required this.widthSize, required this.labelText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthSize,
      height: 50.0,
      margin: EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 12.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          labelText,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.indigoAccent),
        ),
      ),
    );
  }
}

class RZPEditText extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  final TextEditingController controller;

  RZPEditText({required this.textInputType, required this.hintText, required this.labelText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.fromLTRB(16.0, 0, 0, 0),
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: TextField(
        controller: controller,
        keyboardType: textInputType,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          labelText: labelText,
        ),
      ),
    );
  }
}*/

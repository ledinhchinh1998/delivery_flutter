import 'package:delivery_app/extension/color_extension.dart';
import 'package:delivery_app/screen/tabar_controller.dart';
import 'package:flutter/material.dart';

import 'categories_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  @override
  void didUpdateWidget(covariant SplashScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            child: Image.asset("assets/bg-splash.png",
                fit: BoxFit.cover, width: double.infinity)),
        Positioned(
            left: 10,
            top: 20,
            child: Image.asset(
              "assets/ic-logo.png",
              width: 100,
              height: 100,
            )),
        AnimatedPositioned(
          duration: Duration(seconds: 2),
          bottom: 0,
          right: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: HexColor.fromHex("#F6F5F5"),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 100,
                  height: 100,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white
                  ),
                  child: Image.asset(
                      "assets/ic-app.png",
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  margin: EdgeInsets.only(left: 30,right: 20, top: 20),
                  child: Text(
                    "Non-Contact Deliveries",
                    style: TextStyle(
                      color: HexColor.fromHex("#2D0C57"),
                      fontSize: 34,
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    "When placing an order, select the option “Contactless delivery” and the courier will leave your order at the door.",
                    style: TextStyle(
                      color: HexColor.fromHex("#9586A8"),
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center
                  )
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: HexColor.fromHex("#0BCE83"),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TabbarControler()));
                      });
                    },
                    child: Text(
                      "ORDER NOW",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                      )
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25, bottom: 25),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      // color: Colors.blueAccent,/
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: FlatButton(
                    onPressed:() {

                    },
                    child: Text(
                        "DISMISS",
                        style: TextStyle(
                            color: HexColor.fromHex("#9586A8"),
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        )
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}

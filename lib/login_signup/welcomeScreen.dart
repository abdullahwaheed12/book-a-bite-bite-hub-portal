import 'package:bite_hub/login_signup/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/style.dart';
import 'constants.dart';
import 'login.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Option selectedOption = Option.LogIn;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    print(size.height);
    print(size.width);

    return Scaffold(
      body: Container(
        color: deepOrange,
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  height: double.infinity,
                  width: size.width / 2,
                  color: Colors.white,
                ),
                Container(
                    height: double.infinity,
                    width: size.width / 2,
                    color: deepOrange),
              ],
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 150, top: 70),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    fontFamily: "Nunito",
                    color: deepOrange,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 120, top: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/Logo.png',
                        height: 270,
                        width: 270,
                        // cacheColorFilter: false,
                        // color: Colors.transparent,
                      ),
                    )
                    // SvgPicture(
                    //
                    //
                    //   height: 270,
                    //   width: 270,
                    //   // color: Colors.blueGrey[(i + 1) * 100],
                    //   // matchTextDirection: true,
                    // ),

                    // Image.asset(
                    //     'assets/Logo.png',
                    //     height: 270,
                    //     width: 270,
                    //   ),
                  ],
                ),
              ),
            ),
            AnimatedSwitcher(
                duration: Duration(milliseconds: 500),

                //Animation 1
                //transitionBuilder: (widget, animation) => RotationTransition(
                //  turns: animation,
                //  child: widget,
                //),
                //switchOutCurve: Curves.easeInOutCubic,
                //switchInCurve: Curves.fastLinearToSlowEaseIn,

                //Animation 2
                transitionBuilder: (widget, animation) =>
                    ScaleTransition(child: widget, scale: animation),
                child:
                    // selectedOption == Option.LogIn
                    //     ?
                    LogIn()
                //     : SignUp(
                //   onLogInSelected: () {
                //     setState(() {
                //       selectedOption = Option.LogIn;
                //     });
                //   },
                // ),
                ),
          ],
        ),
      ),
    );
  }
}

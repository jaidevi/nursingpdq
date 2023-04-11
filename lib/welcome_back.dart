import 'package:flutter/material.dart';


import '../Customcomponents/custom_circle.dart';
import '../constants/colors.dart';

class WelcomeBack extends StatelessWidget {
  const WelcomeBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Stack(
        children: [
          Positioned(
              top: MediaQuery.of(context).size.height * 0.03,
              left: MediaQuery.of(context).size.width * 0.25,
              child: const CustomCircle(
                width: 25,
                height: 25,
                color: primaryColor,
              )),
          Positioned(
              top: MediaQuery.of(context).size.height * -0.065,
              right: MediaQuery.of(context).size.width * 0.03,
              child: const CustomCircle(
                width: 125,
                height: 125,
                gradient: circleGradientColor,
                color: circleColor,
                borderWidth: 2,
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),


          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(

                  image: DecorationImage(

                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child:

                Text(
                  "PDQ",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25,
                      color: Colors.white),
                ),

              ),
              Text(
                "Post Discharge Questionnare",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Colors.white),
              ),

            ],
          ),

        ],
      ),
    );
  }
}

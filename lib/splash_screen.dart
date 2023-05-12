
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:neon/neon.dart';
import 'package:newshayrii/main.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({Key? key}) : super(key: key);

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return newshayarii();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {

    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;
    double statusbar = MediaQuery.of(context).padding.top;
    double appbar = kToolbarHeight;
    double bodyheight = theight - appbar;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("image/back.jpg"),fit: BoxFit.fill)
        ),
        child: BlurryContainer(
          blur: 7,
          width: twidth,
          height: theight,
          color: Colors.transparent,
          child: Column(
            children: [
              SizedBox(height: theight * 0.13),
              Container(
                height: theight * 0.17,
                width: twidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DefaultTextStyle(
                      style: TextStyle(),
                      child: Neon(
                        text: 'Hindi',
                        color: Colors.red,
                        font: NeonFont.Beon,
                        fontSize: theight * 0.06,
                        flickeringText: true,
                        flickeringLetters: [0, 1, 2, 3,4],
                      ),
                    ),
                    DefaultTextStyle(
                      style: TextStyle(),
                      child: Neon(
                        text: 'Shayari',
                        color: Colors.red,
                        font: NeonFont.Beon,
                        fontSize: theight * 0.06,
                        flickeringText: true,
                        flickeringLetters: [0, 1, 2, 3,4, 5,6],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: theight * 0.02),
              Container(
                height: theight * 0.45,
                width: twidth * 0.55,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("image/0.png"),
                    fit: BoxFit.fill
                  )
                ),
              ),
              Expanded(child: Container()),
              Container(
                  height: theight * 0.1,
                  width: twidth * 0.3,
                  child: Lottie.asset("Animation/e7GhGksqJT.json",fit: BoxFit.fill)),
              SizedBox(height: theight * 0.00),
              Container(
                  height: theight * 0.01,
                  width: twidth,
                  child: Lottie.asset("Animation/7787-progress.json"))
            ],
          ),
        ),
      ),
    );
  }
}

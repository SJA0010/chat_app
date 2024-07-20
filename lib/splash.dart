import 'dart:ui';

import 'package:chat_app/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  )..repeat(reverse: false);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => login(),
          ));
    });
    super.initState();
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      height: height,
      width: width,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(),
            child: Center(
              child: Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                    //   color: Colors.amber,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("images/two.jpg"))),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 370),
            child: Center(
              child: Container(
                alignment: Alignment.topCenter,
                height: height * 0.2,
                width: width * 0.8,
                decoration: BoxDecoration(
                    // color: Colors.amber,
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome To",
                      style: TextStyle(
                          color: Colors.teal[800],
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          shadows: <Shadow>[
                            Shadow(
                                color: Colors.blue,
                                offset: Offset(3, -3),
                                blurRadius: 7.0)
                          ]),
                    ),
                    Text(
                      "GLOBAL",
                      style: TextStyle(
                        color: Colors.teal[800],
                        fontSize: 25,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                              color: Colors.blue,
                              offset: Offset(5, -5),
                              blurRadius: 7.0)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 70),
            child: Center(
              child: Container(
                height: height * 0.25,
                width: width * 0.8,
                child: ScaleTransition(
                    scale: _animation,
                    child: Image(
                      image: AssetImage("images/one.jpg"),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 330),
            child: Center(
              child: Container(
                alignment: Alignment.topCenter,
                height: height * 0.2,
                width: width * 0.8,
                decoration: BoxDecoration(
                    // color: Colors.amber,
                    ),
                child: Text(
                  textAlign: TextAlign.center,
                  "Global is worldwide chatting app that provides you a great opportunity to make new friends and stay connected to global.",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

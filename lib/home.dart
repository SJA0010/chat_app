import 'package:chat_app/pages/chat.dart';
import 'package:chat_app/pages/findfriend.dart';
import 'package:chat_app/pages/notifications.dart';
import 'package:flutter/material.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  var height, width;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    PageController controller = PageController();
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            height: height * 0.07,
            width: width,
            color: Colors.teal[800],
            child: Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: height * 0.05,
                  width: width * 0.8,
                  child: Text(
                    "   GLOBAL",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(
                    child: Container(
                  height: height * 0.05,
                  width: width * 0.2,
                  child: Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 30,
                  ),
                ))
              ],
            ),
          ),
          Container(
            height: height * 0.07,
            width: width,
            color: Colors.teal[800],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      index = index;
                      print("$index");

                      controller.jumpToPage(0);
                    });
                  },
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.25,
                    color: Colors.teal[800],
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: height * 0.06,
                          width: width * 0.25,
                          child: Text(
                            "Chats",
                            style: TextStyle(
                                fontSize: 15,
                                color: index == 1 ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: height * 0.01,
                          width: width * 0.25,
                          color: index == 1 ? Colors.white : Colors.teal[800],
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      index = index;
                      print("$index");

                      controller.jumpToPage(1);
                    });
                  },
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.25,
                    color: Colors.teal[800],
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: height * 0.06,
                          width: width * 0.25,
                          child: Text(
                            "find friends",
                            style: TextStyle(
                                fontSize: 15,
                                color: index == 2 ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: height * 0.01,
                          width: width * 0.25,
                          color: index == 2 ? Colors.white : Colors.teal[800],
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      index = index;
                      print("$index");

                      controller.jumpToPage(2);
                    });
                  },
                  child: Container(
                    height: height * 0.07,
                    width: width * 0.25,
                    color: Colors.teal[800],
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: height * 0.06,
                          width: width * 0.25,
                          child: Text(
                            "notifications",
                            style: TextStyle(
                                fontSize: 15,
                                color: index == 3 ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: height * 0.01,
                          width: width * 0.25,
                          color: index == 3 ? Colors.white : Colors.teal[800],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: height * 0.83,
            width: width,
            child: PageView(
              controller: controller,
              onPageChanged: (value) {
                setState(() {
                  print(value);
                  index = value + 1;
                });
              },
              children: [chat(), FindFriend(), notifications()],
            ),
          )
        ],
      )),
    );
  }
}

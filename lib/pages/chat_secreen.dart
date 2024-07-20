import 'package:chat_app/staticData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String chatroomId;
  final String usernamee;
  ChatScreen({required this.chatroomId, required this.usernamee});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  http.Response? response;
  TextEditingController msgController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void onsendMessage() async {
    if (msgController.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendBy": StaticData.model!.name!,
        "message": msgController.text,
        "time": FieldValue.serverTimestamp()
      };
      await _firestore
          .collection('chatroom')
          .doc(widget.chatroomId)
          .collection('chats')
          .add(messages);
      msgController.clear();
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            children: [
              Container(
                color: Colors.green,
                height: height * 0.04,
              ),
              Container(
                height: height * 0.08,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Padding(
                  padding:
                      EdgeInsets.only(right: width * 0.02, left: width * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: height * 0.05,
                        width: width * 0.12,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: Icon(
                          Icons.person,
                          color: Colors.green,
                        ),
                      ),
                      Text('${widget.usernamee}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                      Expanded(
                          child: SizedBox(
                        width: width,
                      )),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.call,
                          size: width * 0.07,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.video_call,
                          size: width * 0.07,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('chatroom')
                        .doc(widget.chatroomId)
                        .collection('chats')
                        .orderBy("time", descending: false)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.data != null) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> map =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            return messages(MediaQuery.of(context).size, map);
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ),
              Divider(
                color: Colors.green,
              ),
              SizedBox(
                height: height * 0.07,
                width: width,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.03, right: width * 0.01),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: EdgeInsets.only(left: width * 0.02),
                            child: Center(
                              child: TextField(
                                controller: msgController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      InkWell(
                          onTap: () {
                            onsendMessage();
                          },
                          child: Container(
                            height: height,
                            width: width * 0.14,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green),
                            child: const Center(
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map) {
    return Container(
      width: size.width,
      alignment: map['sendBy'] == StaticData.model!.name!
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: map['sendBy'] == StaticData.model!.name!
              ? Colors.green
              : Colors.green[100],
        ),
        child: Text(
          map['message'],
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: map['sendBy'] == StaticData.model!.name!
                  ? Colors.white
                  : Colors.black),
        ),
      ),
    );
  }
}

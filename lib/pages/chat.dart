import 'package:chat_app/models/friendModel.dart';
import 'package:chat_app/pages/chat_secreen.dart';
import 'package:chat_app/staticData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class chat extends StatefulWidget {
  const chat({super.key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  List<FriendModel> allFriends = [];

  getFriendrLIst() async {
    allFriends.clear();
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("Friends")
        .where("userId", isEqualTo: StaticData.model!.userId)
        .get();

    for (var data in query.docs) {
      FriendModel model =
          FriendModel.fromMap(data.data() as Map<String, dynamic>);
      setState(() {
        allFriends.add(model);
      });
    }
  }

  @override
  void initState() {
    getFriendrLIst();
    super.initState();
  }

  String chatRoomId(String loginUser, String friendUser) {
    if (loginUser[0].toLowerCase().codeUnits[0] >
        friendUser.toLowerCase().codeUnits[0]) {
      return "$loginUser$friendUser";
    } else {
      return "$friendUser$loginUser";
    }
  }

  var height, width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(),
          child: Center(
            child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  //  color: Colors.amber,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("images/three.png"))),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(),
          child: Container(
              height: height,
              width: width,
              child: ListView.builder(
                itemCount: allFriends.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      String chatId = chatRoomId(StaticData.model!.userId!,
                          allFriends[index].friendId!);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                chatroomId: chatId,
                                usernamee: allFriends[index].friendName!),
                          ));
                      print(chatId);
                    },
                    child: Card(
                      elevation: 10,
                      color: Colors.white.withOpacity(0.1),
                      child: Container(
                          alignment: Alignment.center,
                          height: height * 0.12,
                          width: width * 0.92,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              border: Border.all(width: 1),
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            children: [
                              Container(
                                width: width * 0.2,
                                height: height * 0.11,
                                // color: Colors.amber,
                                child: Center(
                                  child: Container(
                                    height: height * 0.11,
                                    width: width * 0.14,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle),
                                  ),
                                ),
                              ),
                              Container(
                                height: height * 0.11,
                                width: width * 0.7,
                                //   color: Colors.amber,
                                child: Column(
                                  children: [
                                    Container(
                                        height: height * 0.03,
                                        width: width * 0.7,
                                        //  color: Colors.blue,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: height * 0.03,
                                              width: width * 0.2,
                                              child: Text(
                                                "${allFriends[index].friendName}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Container(
                                              height: height * 0.03,
                                              width: width * 0.1,
                                              child: Text(
                                                "time",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  //fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      height: height * 0.007,
                                    ),
                                    Container(
                                        height: height * 0.03,
                                        width: width * 0.7,
                                        //color: Colors.blue,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: height * 0.03,
                                              width: width * 0.2,
                                              child: Text(
                                                " msg here",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                await FirebaseFirestore.instance
                                                    .collection("Friends")
                                                    .doc(allFriends[index].id)
                                                    .delete();

                                                QuerySnapshot<
                                                        Map<String, dynamic>>
                                                    userfriedid =
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection("Friends")
                                                        .where("userId",
                                                            isEqualTo:
                                                                allFriends[
                                                                        index]
                                                                    .friendId)
                                                        .where("friendId",
                                                            isEqualTo:
                                                                StaticData
                                                                    .model!
                                                                    .userId)
                                                        .get();
                                                FriendModel userfriend =
                                                    FriendModel.fromMap(
                                                        userfriedid.docs[0]
                                                            .data());
                                                await FirebaseFirestore.instance
                                                    .collection("Friends")
                                                    .doc(userfriend.id)
                                                    .delete();
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: height * 0.05,
                                                width: width * 0.1,
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                ),
                                                child: Text(
                                                  "delete",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                  );
                },
              )),
        )
      ],
    ));
  }
}

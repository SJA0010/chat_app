import 'package:chat_app/models/model_user.dart';
import 'package:chat_app/models/request_model.dart';
import 'package:chat_app/staticData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class FindFriend extends StatefulWidget {
  const FindFriend({super.key});

  @override
  State<FindFriend> createState() => _FindFriendState();
}

class _FindFriendState extends State<FindFriend> {
  List<UserModel> allUsers = [];

  getUserLIst() async {
    allUsers.clear();
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("users")
        .where("userId", isNotEqualTo: StaticData.model!.userId)
        .get();

    for (var data in query.docs) {
      UserModel model = UserModel.fromMap(data.data() as Map<String, dynamic>);
      setState(() {
        allUsers.add(model);
      });
    }
  }

  @override
  void initState() {
    getUserLIst();
    super.initState();
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
          child: Center(
            child: Container(
              height: height,
              width: width,
              child: ListView.builder(
                itemCount: allUsers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10,
                      color: Colors.white.withOpacity(0.1),
                      child: Container(
                          alignment: Alignment.center,
                          height: height * 0.12,
                          width: width * 0.8,
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
                                // color: Colors.amber,
                                child: Column(
                                  children: [
                                    Container(
                                      height: height * 0.03,
                                      width: width * 0.7,
                                      //color: Colors.blue,
                                      child: Text(
                                        allUsers[index].name!,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      height: height * 0.025,
                                      width: width * 0.7,
                                      // color: Colors.blue,
                                      child: Text(
                                        allUsers[index].email!,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[800]
                                            // fontWeight: FontWeight.bold
                                            ),
                                      ),
                                    ),
                                    Container(
                                      height: height * 0.055,
                                      width: width * 0.7,
                                      //   color: Colors.blue,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            height: height * 0.045,
                                            width: width * 0.6,
                                            //color: Colors.amber,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    var uid = Uuid();
                                                    String reqId = uid.v4();

                                                    RequestModel model =
                                                        RequestModel(
                                                            reciverId: allUsers[
                                                                    index]
                                                                .userId!,
                                                            reciverName:
                                                                allUsers[
                                                                        index]
                                                                    .name!,
                                                            requestId: reqId,
                                                            senderId: StaticData
                                                                .model!.userId,
                                                            senderName:
                                                                StaticData
                                                                    .model!
                                                                    .name,
                                                            status: 1);
                                                    FirebaseFirestore.instance
                                                        .collection("requests")
                                                        .doc(reqId)
                                                        .set(model.toMap());
                                                  },
                                                  child: Container(
                                                    height: height * 0.045,
                                                    width: width * 0.28,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Text("Add"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                  );
                },
              ),
            ),
          ),
        )
      ],
    ));
  }
}

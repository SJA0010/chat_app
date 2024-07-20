import 'package:chat_app/models/friendModel.dart';
import 'package:chat_app/models/request_model.dart';
import 'package:chat_app/staticData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class notifications extends StatefulWidget {
  const notifications({super.key});

  @override
  State<notifications> createState() => _notificationsState();
}

class _notificationsState extends State<notifications> {
  var height, width;
  List<RequestModel> allUsersRequests = [];

  getUserRequestLIst() async {
    allUsersRequests.clear();
    print("method cal for request");
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("requests")
        .where("reciverId", isEqualTo: StaticData.model!.userId)
        .where("status", isEqualTo: 1)
        .get();

    for (var data in query.docs) {
      RequestModel model =
          RequestModel.fromMap(data.data() as Map<String, dynamic>);
      setState(() {
        allUsersRequests.add(model);
      });
    }
  }

  @override
  void initState() {
    getUserRequestLIst();
    super.initState();
  }

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
            alignment: Alignment.center,
            child: Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              child: allUsersRequests.isEmpty
                  ? Text("No request Found")
                  : ListView.builder(
                      itemCount: allUsersRequests.length,
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
                                              allUsersRequests[index]
                                                  .senderName!,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
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
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "requests")
                                                              .doc(allUsersRequests[
                                                                      index]
                                                                  .requestId)
                                                              .update({
                                                            "status": 2
                                                          }).then((value) {
                                                            getUserRequestLIst();
                                                          });
                                                        },
                                                        child: InkWell(
                                                          onTap: () {
                                                            var uid = Uuid();
                                                            String firstId =
                                                                uid.v4();

                                                            FriendModel model = FriendModel(
                                                                friendId:
                                                                    allUsersRequests[
                                                                            index]
                                                                        .senderId,
                                                                friendName:
                                                                    allUsersRequests[
                                                                            index]
                                                                        .senderName,
                                                                id: firstId,
                                                                userId: allUsersRequests[
                                                                        index]
                                                                    .reciverId);
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "Friends")
                                                                .doc(firstId)
                                                                .set(model
                                                                    .toMap());
                                                            String secoundId =
                                                                uid.v4();
                                                            FriendModel model1 = FriendModel(
                                                                friendId:
                                                                    allUsersRequests[
                                                                            index]
                                                                        .reciverId,
                                                                friendName:
                                                                    allUsersRequests[
                                                                            index]
                                                                        .reciverName,
                                                                id: secoundId,
                                                                userId: allUsersRequests[
                                                                        index]
                                                                    .senderId);
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "Friends")
                                                                .doc(secoundId)
                                                                .set(model1
                                                                    .toMap());
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "requests")
                                                                .doc(allUsersRequests[
                                                                        index]
                                                                    .requestId)
                                                                .update({
                                                              "status": 2
                                                            }).then((value) {
                                                              getUserRequestLIst();
                                                            });
                                                          },
                                                          child: Container(
                                                            height:
                                                                height * 0.045,
                                                            width: width * 0.28,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child:
                                                                Text("Accept"),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "requests")
                                                              .doc(allUsersRequests[
                                                                      index]
                                                                  .requestId)
                                                              .update({
                                                            "status": 0
                                                          }).then((value) {
                                                            getUserRequestLIst();
                                                          });
                                                        },
                                                        child: Container(
                                                          height:
                                                              height * 0.045,
                                                          width: width * 0.28,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .red[800],
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Text("Reject"),
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

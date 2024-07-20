import 'package:chat_app/login.dart';
import 'package:chat_app/models/model_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var height, width;
  int index = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
                height: height * 0.75,
                width: width * 0.8,
                decoration: BoxDecoration(
                    //color: Colors.amber,
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: height * 0.06,
                      width: width * 0.5,
                      decoration: BoxDecoration(
                          //      color: Colors.red,
                          ),
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      //email
                      height: height * 0.1,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                          //     color: Colors.red,
                          ),
                      child: Column(
                        children: [
                          Container(
                            height: height * 0.03,
                            width: width * 0.8,
                            decoration: BoxDecoration(
                                //   color: Colors.green,
                                ),
                            child: Text(
                              " Email :",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            height: height * 0.07,
                            width: width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.3),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: height * 0.06,
                                  width: width * 0.13,
                                  child: Icon(
                                    Icons.email_outlined,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                Container(
                                    height: height * 0.06,
                                    width: width * 0.67,
                                    // color: Colors.amber,
                                    child: TextFormField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                          hintText: "Enter your email",
                                          border: InputBorder.none),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //name
                      height: height * 0.1,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                          //  color: Colors.red,
                          ),
                      child: Column(
                        children: [
                          Container(
                            height: height * 0.03,
                            width: width * 0.8,
                            decoration: BoxDecoration(
                                //   color: Colors.green,
                                ),
                            child: Text(
                              " Full Name :",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            height: height * 0.07,
                            width: width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.3),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: height * 0.06,
                                  width: width * 0.13,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                Container(
                                    height: height * 0.06,
                                    width: width * 0.67,
                                    // color: Colors.amber,
                                    child: TextFormField(
                                      controller: nameController,
                                      decoration: InputDecoration(
                                          hintText: "Enter your username",
                                          border: InputBorder.none),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //number
                      height: height * 0.1,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                          //     color: Colors.red,
                          ),
                      child: Column(
                        children: [
                          Container(
                            height: height * 0.03,
                            width: width * 0.8,
                            decoration: BoxDecoration(
                                //   color: Colors.green,
                                ),
                            child: Text(
                              " Phone :",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            height: height * 0.07,
                            width: width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.3),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: height * 0.06,
                                  width: width * 0.13,
                                  child: Icon(
                                    Icons.phone_android,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                Container(
                                    height: height * 0.06,
                                    width: width * 0.67,
                                    // color: Colors.amber,
                                    child: TextFormField(
                                      controller: phoneController,
                                      decoration: InputDecoration(
                                          hintText: "Enter your number",
                                          border: InputBorder.none),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //password
                      height: height * 0.1,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                          //  color: Colors.red,
                          ),
                      child: Column(
                        children: [
                          Container(
                            height: height * 0.03,
                            width: width * 0.8,
                            decoration: BoxDecoration(
                                //   color: Colors.green,
                                ),
                            child: Text(
                              " Password :",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            height: height * 0.07,
                            width: width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.3),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: height * 0.06,
                                  width: width * 0.13,
                                  child: Icon(
                                    Icons.lock_outline_sharp,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                Container(
                                    height: height * 0.06,
                                    width: width * 0.67,
                                    // color: Colors.amber,
                                    child: TextFormField(
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                          hintText: "Enter your password",
                                          border: InputBorder.none),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      //comfirm
                      height: height * 0.1,
                      width: width * 0.8,
                      decoration: BoxDecoration(
                          //  color: Colors.red,
                          ),
                      child: Column(
                        children: [
                          Container(
                            height: height * 0.03,
                            width: width * 0.8,
                            decoration: BoxDecoration(
                                //   color: Colors.green,
                                ),
                            child: Text(
                              "Comfirm Password :",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            height: height * 0.07,
                            width: width * 0.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.3),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: height * 0.06,
                                  width: width * 0.13,
                                  child: Icon(
                                    Icons.lock_outline_sharp,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                Container(
                                    height: height * 0.06,
                                    width: width * 0.67,
                                    // color: Colors.amber,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Enter your password",
                                          border: InputBorder.none),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.05,
                    ),
                    InkWell(
                      onTap: () {
                        var uid = Uuid();
                        String userId = uid.v4();
                        UserModel model = UserModel(
                            email: emailController.text,
                            name: nameController.text,
                            number: phoneController.text,
                            password: passwordController.text,
                            userId: userId);

                        FirebaseFirestore.instance
                            .collection("users")
                            .doc(userId)
                            .set(model.toMap());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: height * 0.07,
                        width: width * 0.7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.teal[900],
                        ),
                        child: Text(
                          "REGISTER",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 680),
          child: Center(
              child: Container(
            height: height * 0.05,
            width: width * 0.7,
            //  color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account ?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    //fontWeight: FontWeight.bold
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => login(),
                        ));
                  },
                  child: Container(
                    child: Text(
                      "  Sign In",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          )),
        )
      ],
    ));
  }
}

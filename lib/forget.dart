import 'package:chat_app/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class forget extends StatefulWidget {
  const forget({super.key});

  @override
  State<forget> createState() => _forgetState();
}

class _forgetState extends State<forget> {
  var height, width;
  int index = 0;
  final _phoneController = TextEditingController();
  final _passController = TextEditingController();
  String? myverifcationId;

  Future registerUser(String mobile) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
      phoneNumber: mobile,
      timeout: Duration(seconds: 60),
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {},
      codeSent: (verificationId, forceResendingToken) {
        print("code send lala");
        print(verificationId);
        setState(() {
          myverifcationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    PageController controller = PageController();
    return Scaffold(
      body: PageView(
        controller: controller,
        onPageChanged: (value) {
          setState(() {
            print(value);
            index = value + 1;
          });
        },
        children: [
          Container(
            alignment: Alignment.center,
            child: Stack(
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
                  padding: EdgeInsets.only(right: 0, top: 100),
                  child: Center(
                    child: Container(
                      height: height,
                      width: width * 0.95,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white.withOpacity(0.4)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: Center(
                    child: Container(
                        height: height * 0.38,
                        width: width * 0.8,
                        decoration: BoxDecoration(
                            // color: Colors.amber,
                            ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
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
                                      border: Border.all(width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white.withOpacity(0.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: height * 0.06,
                                          width: width * 0.13,
                                          child: Icon(
                                            Icons.phone_android_outlined,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                        Container(
                                            height: height * 0.06,
                                            width: width * 0.65,
                                            // color: Colors.amber,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                  hintText: "Enter your phone",
                                                  border: InputBorder.none),
                                              controller: _phoneController,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                String number = "+92${_phoneController.text}";
                                registerUser(number);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: height * 0.06,
                                width: width * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.teal[900],
                                ),
                                child: Text(
                                  "Send",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
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
                                      " OTP :",
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
                                      border: Border.all(width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white.withOpacity(0.0),
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
                                            width: width * 0.66,
                                            // color: Colors.amber,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                  hintText: "Enter OTP",
                                                  border: InputBorder.none),
                                              controller: _passController,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 0.1,
                            ),
                            InkWell(
                              // onTap: () {
                              //   setState(() {
                              //     index = index + 1;
                              //     print("$index");

                              //     controller.jumpToPage(1);
                              //   });
                              // },
                              onTap: () {
                                FirebaseAuth auth = FirebaseAuth.instance;

                                String smsCode = _passController.text.trim();

                                var _credential = PhoneAuthProvider.credential(
                                    verificationId: myverifcationId!,
                                    smsCode: smsCode);
                                auth
                                    .signInWithCredential(_credential)
                                    .then((result) {
                                  //  print("shafeeq Ahmad verify hogya");
                                  setState(() {
                                    index = index + 1;
                                    print("$index");

                                    controller.jumpToPage(1);
                                  });
                                  // Navigator.pushReplacement(context, MaterialPageRoute(
                                  //   builder: (context) => HomeScreen(result.user)
                                  // ));
                                }).catchError((e) {
                                  print(e);
                                });
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
                                  "Verify",
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
                  padding: EdgeInsets.only(top: 645),
                  child: Center(
                      child: Container(
                    height: height * 0.05,
                    width: width * 0.7,
                    //  color: Colors.amber,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Remember Password ?",
                          style: TextStyle(
                            color: Colors.black,
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
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 390, left: 0),
                  child: Center(
                    child: Container(
                      height: height * 0.2,
                      width: width,
                      //   color: Colors.amber,
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: height * 0.12,
                                  width: width * 0.5,
                                  //   color: Colors.red,
                                  child: Text(
                                    "Forget Your Password?",
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.4,
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: height * 0.08,
                            width: width * 0.8,
                            //  color: Colors.red,
                            child: Text(
                              "Well don't worry, type your number to verify and recover your account",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                //   fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Stack(
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
                        height: height * 0.5,
                        width: width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.white.withOpacity(0.4)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
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
                                      " New Password :",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: height * 0.07,
                                    width: width * 0.8,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white.withOpacity(0.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: height * 0.06,
                                          width: width * 0.13,
                                          child: Icon(
                                            Icons.lock,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                        Container(
                                            height: height * 0.06,
                                            width: width * 0.65,
                                            // color: Colors.amber,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                  hintText:
                                                      "Enter your password",
                                                  border: InputBorder.none),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
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
                                      " Comfirm Password :",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: height * 0.07,
                                    width: width * 0.8,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white.withOpacity(0.0),
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
                                            width: width * 0.66,
                                            // color: Colors.amber,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                  hintText:
                                                      "Re-enter your password",
                                                  border: InputBorder.none),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 0.1,
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
                                alignment: Alignment.center,
                                height: height * 0.07,
                                width: width * 0.7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.teal[900],
                                ),
                                child: Text(
                                  "Verify",
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

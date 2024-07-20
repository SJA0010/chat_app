import 'package:chat_app/forget.dart';
import 'package:chat_app/home.dart';
import 'package:chat_app/models/model_user.dart';
import 'package:chat_app/signup.dart';
import 'package:chat_app/staticData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class login extends StatefulWidget {
  const login({super.key});
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  static Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        print(user!.displayName);
        print(user.email);
        print(user.phoneNumber);
        print(user.photoURL);
        print(user.uid);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }

  var height, width;
  int index = 0;
  TextEditingController passwordContoller = TextEditingController();
  TextEditingController emailController = TextEditingController();

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
          padding: EdgeInsets.only(bottom: 200),
          child: Center(
            child: Container(
                height: height * 0.5,
                width: width * 0.8,
                decoration: BoxDecoration(
                    // color: Colors.amber,
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
                        "SIGN IN",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
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
                                          hintText: "EMAIL",
                                          border: InputBorder.none),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.13,
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
                                      controller: passwordContoller,
                                      decoration: InputDecoration(
                                          hintText: "PASSWORD",
                                          border: InputBorder.none),
                                    )),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => forget(),
                                  ));
                            },
                            child: Container(
                              alignment: Alignment.centerRight,
                              height: height * 0.03,
                              width: width * 0.8,
                              decoration: BoxDecoration(
                                  //   color: Colors.green,
                                  ),
                              child: Text(
                                " Forget Password  ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.1,
                    ),
                    InkWell(
                      onTap: () async {
                        if (emailController.text == null ||
                            passwordContoller.text == null) {
                          print("fill all fields");
                        } else {
                          QuerySnapshot query = await FirebaseFirestore.instance
                              .collection("users")
                              .where("email", isEqualTo: emailController.text)
                              .where("password",
                                  isEqualTo: passwordContoller.text)
                              .get();
                          if (query.docs.isEmpty) {
                            print("email or password is incorrect");
                          } else {
                            UserModel model = UserModel.fromMap(
                                query.docs[0].data() as Map<String, dynamic>);
                            print(model);
                            StaticData.model = model;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => home(),
                                ));
                          }
                        }
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
                          "LOGIN",
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
          padding: EdgeInsets.only(top: 400),
          child: Center(
              child: Container(
            height: height * 0.2,
            width: width * 0.5,
            //color: Colors.amber,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: height * 0.04,
                  width: width * 0.2,
                  // color: Colors.black,
                  child: Text(
                    "--OR--",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: height * 0.04,
                  width: width * 0.5,
                  //  color: Colors.black,
                  child: Text(
                    "Sign up With",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: height * 0.1,
                  width: width * 0.27,
                  //color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: height * 0.1,
                        width: width * 0.1,
                        decoration: BoxDecoration(
                            color: Colors.blue[800], shape: BoxShape.circle),
                        child: Text(
                          "f",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          signInWithGoogle();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: height * 0.1,
                          width: width * 0.1,
                          decoration: BoxDecoration(
                              color: Colors.red[700], shape: BoxShape.circle),
                          child: Text(
                            "G",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
        ),
        Padding(
          padding: EdgeInsets.only(top: 630),
          child: Center(
              child: Container(
            height: height * 0.05,
            width: width * 0.7,
            //  color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account ?",
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
                          builder: (context) => signup(),
                        ));
                  },
                  child: Container(
                    child: Text(
                      "  Sign Up",
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

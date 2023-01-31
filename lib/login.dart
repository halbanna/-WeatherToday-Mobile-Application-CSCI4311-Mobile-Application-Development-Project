import 'package:weathertoday/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homepage.dart';

class MyLogin extends StatefulWidget {

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.0,
              1.0,

            ],
            colors: [
              Colors.black12,
              Colors.blueGrey,
            ],
          )
      ),

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        backgroundColor: Colors.transparent,
        body: Stack(children: [
          Container(
            padding: const EdgeInsets.only(left: 50, top: 80),
            child: Row(
              children:[ Text(
                "Weather Today",
                style: GoogleFonts.itim(color: Colors.white, fontSize: 33),
              ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Image.network( // <-- SEE HERE
                  'https://uxwing.com/wp-content/themes/uxwing/download/weather/weather-icon.png',
                  height: 50,
                  alignment: Alignment.centerRight,
              ),
                ),]
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35,
                  left: 35,
                  top: MediaQuery.of(context).size.height * 0.3),
              child: Column(children: [
                TextField(
                  controller: email,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xff7e809d)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xff7e809d)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Email',
                      hintStyle: const TextStyle(color: Color(0xff7e809d)),
                    ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: password,
                  style: TextStyle(color: Colors.black),
                  obscureText: true,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xff7e809d)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xff7e809d)),
                      ),
                    filled: true,
                    fillColor: Colors.white,
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Color(0xff7e809d)),
                    ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blueGrey,
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () async {
                          try {
                            final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: email.text,
                                password: password.text,
                            );
                            if(credential != null){
                              Navigator.push( context,
                                  MaterialPageRoute(builder: (_) => const MyHomePage())
                              );
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                          }

                        },
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push( context,
                              MaterialPageRoute(builder: (_) => MyRegister())
                          );


                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),

                    ]),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
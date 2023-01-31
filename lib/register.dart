import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'homepage.dart';
import 'login.dart';

class MyRegister extends StatefulWidget {

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.0,
                1.0,

              ],
              colors: [
                Colors.black,
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
          body: SingleChildScrollView(
            child: Stack(children: [
              Container(
                padding: const EdgeInsets.only(left: 35, top: 80),
                child: const Text(
                  "Create\nAccount",
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    right: 35,
                    left: 35,
                    top: MediaQuery.of(context).size.height * 0.27),
                child: Column(children: [
                  TextField(
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
                      hintText: 'Name',
                      hintStyle: const TextStyle(color: Color(0xff7e809d)),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
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
                      hintStyle: const TextStyle(color: Color(0xff7e809d)
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sign Up',
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
                                final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                  email: email.text,
                                  password: password.text,
                                );

                                if(credential != null){
                                  Navigator.push( context,
                                      MaterialPageRoute(builder: (_) => const MyHomePage())
                                  );
                                }

                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  print('The password provided is too weak.');
                                } else if (e.code == 'email-already-in-use') {
                                  print('The account already exists for that email.');
                                }
                              } catch (e) {
                                print(e);
                              }
                            },
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ]),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () async {



                            Navigator.push( context,
                                MaterialPageRoute(builder: (_) => MyLogin())
                            );
                          },
                          child: const Text(
                            'Already with an account? Login here',
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
            ]),
          ),
        ),
      ),
    );
  }
}
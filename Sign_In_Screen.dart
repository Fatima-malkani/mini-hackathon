import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Screens/Sign_up_Screen.dart';
import 'package:project/Screens/mapScreen.dart';
import 'package:project/Screens/showAlldonars.dart';
import 'package:project/Widgets/styling.dart';
import 'package:project/sessioncontroller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEB3738),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/splash.png",
            cacheHeight: 116,
            cacheWidth: 93,
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              width: 372,
              height: 365,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.white,
              ),
              child: Center(
                child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Text(
                            "LOGIN",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                  controller: _emailController,
                                  validator: (value) {
                                    return value!.isEmpty
                                        ? "Enter email"
                                        : null;
                                  },
                                  decoration:
                                      TextFormFieldDecoration("Enter email")),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                validator: (value) {
                                  return value!.isEmpty
                                      ? "Enter password"
                                      : null;
                                },
                                decoration: TextFormFieldDecoration("password"),
                                obscureText: true,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() {});
                                    //  CircularProgressIndicator();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MapScreen()));

                                    try {
                                      await _auth
                                          .signInWithEmailAndPassword(
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                      )
                                          .then((value) {
                                        SessionControler().userId =
                                            _auth.currentUser!.uid.toString();

                                        setState(() {});
                                      });
                                      print(" User signed in successfully");
                                    } catch (e) {
                                      // Handle sign-in errors (e.g., invalid credentials).
                                      print("invalid credentials");
                                    }
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 242, 79, 79),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Center(
                                      child: Text(
                                    "Sign In ",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account?",
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignUpScreen()));
                                      },
                                      child: const Text(
                                        "Sign Up Now..",
                                      ))
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

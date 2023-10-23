import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Screens/Sign_In_Screen.dart';
import 'package:project/Widgets/styling.dart';
import 'package:project/sessioncontroller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
   CollectionReference users = FirebaseFirestore.instance.collection('users');
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

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
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                       
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                  controller: _usernameController,
                                  validator: (value) {
                                    return value!.isEmpty
                                        ? "Enter Username"
                                        : null;
                                  },
                                  decoration: TextFormFieldDecoration(
                                      "Enter username")),
                              TextFormField(
                                  controller: _emailController,
                                  validator: (value) {
                                    return value!.isEmpty
                                        ? "Enter email"
                                        : null;
                                  },
                                  decoration:
                                      TextFormFieldDecoration("Enter email")),
                             
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
                                onTap: () async{
                                   if (_formkey.currentState!.validate()) {
                  setState(() {
                    isLoading = true;
                  });

                  try {
                    await _auth
                        .createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text)
                        .then((value) {
                      isLoading = false;
                      setState(() {});
                      print("User created Successful");
                      SessionControler().userId =
                          _auth.currentUser!.uid.toString();
                      users.doc(_auth.currentUser!.uid.toString()).set({
                        "userName": _usernameController.text,
                        "userEmail": _emailController.text,
                      }).then((value) {
                        isLoading = false;
                        setState(() {});
                        Dialogs.showSnackBar(
                            context, ' Your account created successfully');
                        print("User Data created");
                      });
                    });
                  } catch (e) {
                    print("Login Failed: ${e.toString()}");
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
                                    "Sign up ",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Already have an account?",
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
                                                  const SignInScreen()));
                                    },
                                    child: const Text(
                                      "Sign In Now..",
                                    ),
                                  )
                                ],
                              ),
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

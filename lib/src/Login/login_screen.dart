import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/src/Login/Forget_pass_button.dart';

import 'package:grocery/src/Login/SignUp.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();

    _isObscure = true;
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  // ignore: unused_field
  String _emailAddress = '';
  // ignore: unused_field
  String _password = '';
  final _formkey = GlobalKey<FormState>();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
//section 1----------------------------------------------------------------------------------------------------
              Image(
                  image: const AssetImage('assets/grocery_image.png'),
                  height: size.height * 0.2),
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),

//SECTION 2-------------------------------------------------------------------------------------------------------
              Form(
                  key: _formkey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              labelText: 'E-mail',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty || !value.contains('@')) {
                                return 'Please enter a Vaild Email';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                            autofillHints: const [AutofillHints.email],
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passwordFocusNode),
                            onSaved: (value) {
                              _emailAddress = value!;
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.lock_outline_rounded),
                              labelText: 'Password',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                  padding: const EdgeInsetsDirectional.only(
                                      end: 12.0),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                  icon: _isObscure
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                            ),
                            obscureText: _isObscure,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  value.length <= 8 ||
                                  value.length >= 4) {
                                return 'Please enter a Password with Words between 4 to 8';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              _password = value!;
                            },
                          ),
                          const SizedBox(height: 10),

                          TextButton(
                              onPressed: () {
                                scaffoldKey.currentState!
                                    .showBottomSheet((context) {
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100));
                                  return const ForgetPassPoopUp();
                                });
                              },
                              child: const Text(
                                'Forget Password?',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 143, 176, 247)),
                              )),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {}, child: const Text('Login')),
                          ),
                          const SizedBox(height: 10),
//SECTION 3--------------------------------------------------------------------------------------------------
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('OR'),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: () async {
                                    /*
                                    await signInWithGoogle().then((result) {
                                      print(result);
                                      if (result != null) {
                                        Navigator.of(context).pop();
                                        Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                          builder: (context) =>
                                              const UserScreen(),
                                        ));
                                      }
                                    }).catchError((error) {
                                      print('Registration Error: $error');
                                    });
                                    */
                                  },
                                  label: const Text('Sign in with Google'),
                                  icon: const Image(
                                    image: AssetImage('assets/google.png'),
                                    width: 20,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.to(() => const SignUpScreen());
                                },
                                child: const Text.rich(
                                  TextSpan(
                                    text: 'Don\'t have an Account?',
                                    style: TextStyle(color: Colors.grey),
                                    children: [
                                      TextSpan(
                                        text: ' Sign Up',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ]),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

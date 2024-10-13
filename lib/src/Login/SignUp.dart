import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/src/Home/homeScreen.dart';
import 'package:grocery/src/Login/SignUpController.dart';
import 'package:grocery/src/Login/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() {
    return _SignUpScreen();
  }
}

class _SignUpScreen extends State<SignUpScreen> {
  final controller = Get.put(SignUpController());
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNoFocusNode = FocusNode();
  late bool _isObscure;
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNoFocusNode.dispose();

    super.dispose();
  }

  TextEditingController phoneNumber = TextEditingController();
  TextEditingController otp = TextEditingController();
  var temp;

  @override
  void initState() {
    super.initState();

    _isObscure = true;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        child: Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
//SECTION 1 ----------------------------------------------------------------------------
              Image(
                  image: const AssetImage('assets/grocery_image.png'),
                  height: size.height * 0.2),
              const Text(
                'Boarding On!',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),

//SECTION 2 -------------------------------------------------------------------------
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: controller.fullName,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_outline_outlined),
                          label: Text('Full Name'),
                        ),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_emailFocusNode),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Full Name cannot be empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controller.email,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          label: Text('E-mail'),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Please enter a Vaild Email';
                          } else {
                            return null;
                          }
                        },
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_phoneNoFocusNode),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controller.phoneNo,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone_in_talk_outlined),
                          label: Text('Phone Number'),
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty || value.length == 10) {
                            return 'Please enter your Phone Number';
                          } else {
                            return null;
                          }
                        },
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_passwordFocusNode),
                        keyboardType: TextInputType.number,
                        autofillHints: const [AutofillHints.telephoneNumber],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: controller.password,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline),
                            label: const Text('Password'),
                            suffixIcon: IconButton(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 12.0),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                                icon: _isObscure
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off))),
                        obscureText: _isObscure,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty ||
                              value.length <= 8 ||
                              value.length >= 4) {
                            return 'Please enter Password that is 4 to 8 characters long';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              Get.to(() => Homescreen());
                              if (_formkey.currentState!.validate()) {}
                            },
                            child: const Text('SIGN UP'),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('OR'),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              label: const Text('Sign in with Google'),
                              icon: const Image(
                                image: AssetImage('assets/google.png'),
                                width: 20,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(() => const LoginScreen());
                            },
                            child: const Text.rich(
                              TextSpan(
                                text: 'Already have an Account?',
                                style: TextStyle(color: Colors.grey),
                                children: [
                                  TextSpan(
                                    text: '  Login',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

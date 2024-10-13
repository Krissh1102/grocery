import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/src/Login/SignUp.dart';
import 'package:grocery/src/Login/login_screen.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
  
   
    var mediaQuery = MediaQuery.of(context);
    var hight = mediaQuery.size.height;

    return Scaffold(
      body: Stack(children: [
      
             Container(
                padding: const EdgeInsets.all(18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Image(
                        image: const AssetImage('assets/grocery_image.png'),
                        height: hight * 0.6),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Get the Grocrey anywhere you want',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Just one click away'),
                    const SizedBox(
                      height: 105,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: OutlinedButton(
                          onPressed: () {
                            Get.to(() => const LoginScreen());
                          },
                          child: const Text('Login'),
                        )),
                        const SizedBox(width: 10),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  Get.to(() => const SignUpScreen());
                                },
                                child: const Text('Sign up')))
                      ],
                    )
                  ],
                ))]
      
    ));
  }
}

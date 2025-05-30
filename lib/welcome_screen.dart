import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tasky_app/core/components/custom_text_form_field.dart';
import 'package:flutter_tasky_app/home_screen.dart';
import 'package:flutter_tasky_app/models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final TextEditingController controller = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/Tasky.svg",
                        width: 42,
                        height: 42,
                      ),
                      const SizedBox(width: 16),
                      Text("Tasky", style: TextTheme.of(context).displayMedium),
                    ],
                  ),
                  const SizedBox(height: 110),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome To Tasky",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(width: 10),
                      SvgPicture.asset('assets/images/waving.svg'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Your productivity journey starts here.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  SvgPicture.asset(
                    'assets/images/main.svg',
                    width: 215,
                    height: 205,
                  ),
                  const SizedBox(height: 28),
                  CustomTextFormField(
                    title: 'Full Name',
                    hintText: 'e.g  Sarah Khalid',
                    controller: controller,
                    validator: (String ? value){
                      if(value == null || value.isEmpty)
                      {
                        return "Please Enter your Name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      if (_key.currentState?.validate() ?? false) {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString("userName", controller.text);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return HomeScreen();
                            },
                          ),
                        );
                      }
                    },
                    child: const Text("Let’s Get Started"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

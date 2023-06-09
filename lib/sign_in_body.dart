
import 'package:flutter/material.dart';
import 'package:nursingpdq/welcome_back.dart';

import 'sign_in_form.dart';


class SignInBody extends StatelessWidget {
  const SignInBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      reverse: true,
      child: Column(
        children: const [WelcomeBack(),SignInForm()],
      ),
    ));
  }
}

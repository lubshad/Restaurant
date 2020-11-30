import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant/services/authService.dart';

import '../../../root.dart';
import '../../../size_config.dart';
import 'default_button.dart';
import 'sign_up_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenHeight(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Register Account"),
                Text(
                  "Complete your details or continue \nwith social media",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignUpForm(),

                SizedBox(
                  height: 20,
                ),
                DefaultButton(
                  text: "Sign IN With Google",
                  press: () async {
                    await AuthService().signInWithGoogle();
                    Get.offAll(Root());
                  },
                  icon: "assets/icons/google-icon.svg",
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  'By continuing your confirm that you agree \nwith our Term and Condition',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

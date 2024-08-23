import 'package:coolmeal/theming/colors.dart';
import 'package:flutter/material.dart';

import '../../../../helpers/extensions.dart';
import '../../../../routing/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoNotHaveAccountText extends StatelessWidget {
  const DoNotHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Routes.signupScreen);
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an account yet?',
              style:  TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorsManager.darkBlue,
                ),
            ),
            TextSpan(
              text: ' Sign Up',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w900,
                color: ColorsManager.mainGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

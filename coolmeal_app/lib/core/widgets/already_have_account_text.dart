import 'package:coolmeal/theming/colors.dart';
import 'package:flutter/material.dart';

import '../../helpers/extensions.dart';
import '../../routing/routes.dart';
import '../../theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamedAndRemoveUntil(
          Routes.loginScreen,
          predicate: (route) => false,
        );
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text: 'Already have an account?',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorsManager.darkBlue,
                )),
            TextSpan(
              text: ' Login',
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

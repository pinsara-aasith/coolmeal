import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:coolmeal/core/widgets/unified_back_button.dart';
import 'package:coolmeal/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../core/widgets/already_have_account_text.dart';
import '../../../core/widgets/login_and_signup.dart';
import '../../../core/widgets/progress_indicaror.dart';
import '../../../core/widgets/sign_in_with_google_text.dart';
import '../../../helpers/extensions.dart';
import '../../../logic/cubit/login_or_signup_cubit.dart';
import '../../../routing/routes.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            height: double.infinity,
        decoration: BoxDecoration(
          gradient: welcomeGradient,
        ),
        child: Padding(
          padding:
              EdgeInsets.only(left: 10.w, right: 10.w, bottom: 15.h, top: 5.h),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                UnifiedBackButton(onPressed: () {
                  Navigator.of(context).pop();
                }),
                Gap(13.h),
                const Text(
                  'Create New Account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Create New Account and Begin Your Healthy Eating Journey',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                Gap(20.h),
                BlocConsumer<LoginOrSignupCubit, AuthState>(
                  buildWhen: (previous, current) => previous != current,
                  listenWhen: (previous, current) => previous != current,
                  listener: (context, state) async {
                    if (state is AuthLoading) {
                      ProgressIndicaror.showProgressIndicator(context);
                    } else if (state is AuthError) {
                      context.pop();
                      context.pop();
                      await AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.rightSlide,
                        title: 'Error',
                        desc: state.message,
                      ).show();
                    } else if (state is UserSignIn) {
                      await Future.delayed(const Duration(seconds: 2));

                      if (!context.mounted) return;
                      context.pushNamedAndRemoveUntil(
                        Routes.homeScreen,
                        predicate: (route) => false,
                      );
                    } else if (state is IsNewUser) {
                      context.pushNamedAndRemoveUntil(
                        Routes.createPassword,
                        predicate: (route) => false,
                        arguments: [state.googleUser, state.credential],
                      );
                    } else if (state is UserSingupButNotVerified) {
                      context.pop();
                      await AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        title: 'Sign up Success',
                        desc: 'Don\'t forget to verify your email check inbox.',
                      ).show();
                      await Future.delayed(const Duration(seconds: 2));

                      if (!context.mounted) return;
                      context.pushNamedAndRemoveUntil(
                        Routes.loginScreen,
                        predicate: (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        EmailAndPassword(
                          isSignUpPage: true,
                        ),
                        Gap(10.h),
                        const SigninWithGoogleText(),
                        Gap(5.h),
                        InkWell(
                          onTap: () {
                            context.read<LoginOrSignupCubit>().signInWithGoogle();
                          },
                          child: SvgPicture.asset(
                            'assets/svgs/google_logo.svg',
                            width: 40.w,
                            height: 40.h,
                          ),
                        ),
                        Gap(15.h),
                        const AlreadyHaveAccountText(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginOrSignupCubit>(context);
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:coolmeal/core/widgets/unified_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../core/widgets/login_and_signup.dart';
import '../../../core/widgets/no_internet.dart';
import '../../../core/widgets/progress_indicaror.dart';
import '../../../core/widgets/sign_in_with_google_text.dart';
import '../../../helpers/extensions.dart';
import '../../../logic/cubit/login_or_signup_cubit.dart';
import '../../../routing/routes.dart';
import '../../../theming/colors.dart';
import 'widgets/do_not_have_account.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          List<ConnectivityResult> connectivities,
          Widget child,
        ) {
          final bool connected = connectivities[0] != ConnectivityResult.none;
          return connected ? _loginPage(context) : const BuildNoInternet();
        },
        child: const Center(
          child: CircularProgressIndicator(
            color: ColorsManager.mainGreen,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginOrSignupCubit>(context);
  }

  SafeArea _loginPage(BuildContext context) {
    return SafeArea(
        child: Container(
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: welcomeGradient,
      ),
      child: Padding(
        padding:
            EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.h, top: 5.h),
        child: SingleChildScrollView(
          child: BlocConsumer<LoginOrSignupCubit, AuthState>(
            buildWhen: (previous, current) => previous != current,
            listenWhen: (previous, current) => previous != current,
            listener: (context, state) async {
              if (state is AuthLoading) {
                ProgressIndicaror.showProgressIndicator(context);
              } else if (state is AuthError) {
                context.pop();

                AwesomeDialog(
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
              } else if (state is UserNotVerified) {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.info,
                  animType: AnimType.rightSlide,
                  title: 'Email Not Verified',
                  desc: 'Please check your email and verify your email.',
                ).show();
              } else if (state is IsNewUser) {
                context.pushNamedAndRemoveUntil(
                  Routes.createPassword,
                  predicate: (route) => false,
                  arguments: [state.googleUser, state.credential],
                );
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UnifiedBackButton(onPressed: () {
                          Navigator.of(context).pop();
                        }),
                        Gap(13.h),
                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          'Welcome Back! Continue Your Journey to Healthier Meals',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(10.h),
                  EmailAndPassword(),
                  Gap(20.h),
                  const SigninWithGoogleText(),
                  Gap(5.h),
                  InkWell(
                    radius: 50.r,
                    onTap: () {
                      context.read<LoginOrSignupCubit>().signInWithGoogle();
                    },
                    child: SvgPicture.asset(
                      'assets/svgs/google_logo.svg',
                      width: 40.w,
                      height: 40.h,
                    ),
                  ),
                  Gap(25.h),
                  const DoNotHaveAccountText(),
                ],
              );
            },
          ),
        ),
      ),
    ));
  }
}

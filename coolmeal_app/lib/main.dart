import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolmeal/bloc/app_bloc.dart';
import 'package:coolmeal/repositories/authentication_repository.dart';
import 'package:coolmeal/repositories/meal_repository.dart';
import 'package:coolmeal/repositories/user_profile_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';
import 'routing/app_router.dart';
import 'routing/routes.dart';
import 'theming/colors.dart';

String initialRoute = Routes.loginScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
    ScreenUtil.ensureScreenSize(),
    preloadSVGs(['assets/svgs/google_logo.svg'])
  ]);
  Bloc.observer = const AppBlocObserver();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  runApp(MyApp(
    router: AppRouter(),
    authenticationRepository: authenticationRepository,
  ));
}

Future<void> preloadSVGs(List<String> paths) async {
  for (final path in paths) {
    final loader = SvgAssetLoader(path);
    await svg.cache.putIfAbsent(
      loader.cacheKey(null),
      () => loader.loadBytes(null),
    );
  }
}

class MyApp extends StatelessWidget {
  final AppRouter router;

  final AuthenticationRepository _authenticationRepository;

  const MyApp({
    required this.router,
    required authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
                create: (context) =>
                    MealRepository(firestore: FirebaseFirestore.instance)),
            RepositoryProvider(
                create: (context) =>
                    UserProfileRepository(firestore: FirebaseFirestore.instance)),
            RepositoryProvider(create: (context) => _authenticationRepository),
          ],
          child: BlocProvider(
            create: (_) => AppBloc(
              authenticationRepository: _authenticationRepository,
            ),
            child: AppView(router: router),
          ),
        );
      },
    );
  }
}

class AppView extends StatefulWidget {
  final AppRouter router;
  const AppView({super.key, required this.router});

  @override
  State<AppView> createState() => _AppViewState();
}

var splashShown = false;

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  void commitAppStateChanges(AppState appState) {
    switch (appState.status) {
      case AppStatus.authenticated:
        _navigator.pushNamedAndRemoveUntil<void>(
          Routes.homeScreen,
          (route) => false,
        );
        break;
      case AppStatus.authenticatedNotVerified:
        _navigator.pushNamedAndRemoveUntil<void>(
          Routes.verifyPlease,
          (route) => false,
        );
        break;
      case AppStatus.unauthenticated:
        _navigator.pushNamedAndRemoveUntil<void>(
          Routes.letsStart,
          (route) => false,
        );
        break;
      case AppStatus.unknown:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoolMeal',
      navigatorKey: _navigatorKey,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryColor: ColorsManager.mainGreen,
        secondaryHeaderColor: ColorsManager.secondaryGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: ColorsManager.mainGreen,
          selectionColor: Color.fromARGB(188, 36, 124, 255),
          selectionHandleColor: ColorsManager.mainGreen,
        ),
      ),
      builder: (context, child) {
        return BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            if (!splashShown) {
              Future.delayed(const Duration(seconds: 2)).then((v) {
                commitAppStateChanges(state);
              });

              splashShown = true;
              return;
            }

            commitAppStateChanges(state);
          },
          child: child,
        );
      },
      onGenerateRoute: widget.router.generateRoute,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashScreen,
    );
  }
}

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    print(change);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

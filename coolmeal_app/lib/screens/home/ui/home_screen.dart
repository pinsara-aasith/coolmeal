import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolmeal/bloc/app_bloc.dart';
import 'package:coolmeal/screens/home/tabs/generated_meal_plan_tab/bloc/generated_meal_plans_bloc.dart';
import 'package:coolmeal/screens/home/tabs/home_tab/bloc/popular_meals_bloc.dart';
import 'package:coolmeal/screens/home/tabs/new_meal_plan_tab/new_meal_plan_tab.dart';
import 'package:coolmeal/screens/home/tabs/generated_meal_plan_tab/generated_meal_plans_tab.dart';
import 'package:coolmeal/screens/home/tabs/home_tab/home_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '/helpers/extensions.dart';
import '/routing/routes.dart';
import '../../../core/widgets/no_internet.dart';
import '../../../logic/cubit/login_or_signup_cubit.dart';
import '../../../theming/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          List<ConnectivityResult> connectivity,
          Widget child,
        ) {
          final bool connected = connectivity[0] != ConnectivityResult.none;
          return connected
              ? BlocConsumer<AppBloc, AppState>(
                  buildWhen: (previous, current) => previous != current,
                  listenWhen: (previous, current) => previous != current,
                  listener: (context, state) async {
                    if (state is UserSignedOut) {
                      context.pushNamedAndRemoveUntil(
                        Routes.loginScreen,
                        predicate: (route) => false,
                      );
                    }
                  },
                  builder: (context, state) {
                    return const HomeBody();
                  },
                )
              : const BuildNoInternet();
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
    BlocProvider.of<AppBloc>(context);
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  int _selectedTab = 0;

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    var pages = [
      BlocProvider(
          create: (context) =>
              PopularMealBloc(firestore: FirebaseFirestore.instance)
                ..add(FetchPopularMeals()),
          child: const HomeTab()),
      const NewMealPlanTab(),
      BlocProvider(
          create: (context) => MealPlanBloc(FirebaseFirestore.instance)
            ..add(FetchMealPlans(currentUser?.email ?? '')),
          child: const GeneratedMealsComboTab()),
      Center(
        child: BlocBuilder<AppBloc, AppState>(
          builder: (context, state) {
            return ElevatedButton(
                onPressed: () {
                  context.read<AppBloc>().add(const AppLogoutRequested());
                },
                child: const Text("Logout"));
          },
        ),
      ),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_selectedTab]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        iconSize: 40,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box), label: "New Meal Plan"),
          BottomNavigationBarItem(
              icon: Icon(Icons.food_bank), label: "Your Meals"),
          BottomNavigationBarItem(
              icon: Icon(Icons.food_bank), label: "Chat Bot"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}

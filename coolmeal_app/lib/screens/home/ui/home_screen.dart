import 'package:coolmeal/bloc/app_bloc.dart';
import 'package:coolmeal/screens/home/tabs/create_meal_plan_tab/create_meal_plan_tab.dart';
import 'package:coolmeal/screens/home/tabs/home_tab/home_tab.dart';
import 'package:coolmeal/screens/profile_details_edit/ui/profile_tab.dart';
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
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State {
  int _selectedTab = 0;

  final List _pages = [
    const HomeTab(),
    const CreateMealPlanTab(),
    const Center(
      child: Text("Contact"),
    ),
    const Center(
      child: Text("Settings"),
    ),
  ];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedTab]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        iconSize: 40,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.four_k_plus_rounded), label: "Meals"),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_mail), label: "Contact"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
    );
  }
}

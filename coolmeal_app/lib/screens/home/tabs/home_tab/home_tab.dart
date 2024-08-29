import 'package:coolmeal/models/meal.dart';
import 'package:coolmeal/routing/routes.dart';
import 'package:coolmeal/screens/home/tabs/home_tab/popular_meals_bloc.dart';
import 'package:coolmeal/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  void handleMealClick(String mealType) {
    // Handle the click event here
    print('$mealType clicked!');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(gradient: welcomeGradient),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              stretch: true,
              floating: true,
              onStretchTrigger: () async {
                // Triggers when stretching
              },
              stretchTriggerOffset: 200.0,
              expandedHeight: 300.0,
              flexibleSpace: Image.asset(
                "assets/images/home_image.png",
                fit: BoxFit.cover,
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        height: 150,
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            MealTime(
                              imageUrl: "assets/images/breakfast.jpg",
                              mealType: 'Breakfast',
                              onClick: () => handleMealClick('Breakfast'),
                            ),
                            Gap(6.h),
                            MealTime(
                              imageUrl: "assets/images/lunch.jpg",
                              mealType: 'Lunch',
                              onClick: () => handleMealClick('Lunch'),
                            ),
                            Gap(6.h),
                            MealTime(
                              imageUrl: "assets/images/dinner.jpg",
                              mealType: 'Dinner',
                              onClick: () => handleMealClick('Dinner'),
                            ),
                          ],
                        ),
                      ),
                      // Expanded(child:  GateList())
                    ],
                  );
                },
                childCount: 1,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 0, left: 12, right: 12),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                return const Text('Popular Meals');
              }, childCount: 1)),
            ),
            BlocBuilder<PopularMealBloc, PopularMealState>(
              builder: (context, state) {
                if (state is PopularMealLoading) {
                  return const SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()));
                } else if (state is PopularMealLoaded) {
                  return SliverPadding(
                    padding: const EdgeInsets.all(12),
                    sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final meal = state.meals[index];
                        return MealListItem(meal: meal);
                      },
                      childCount: state.meals.length,
                    )),
                  );
                } else if (state is PopularMealError) {
                  return SliverToBoxAdapter(
                      child: Center(child: Text(state.message)));
                } else {
                  return const SliverToBoxAdapter(
                      child: Center(child: Text('No meals found')));
                }
              },
            ),
          ],
        ));
  }
}

class MealTime extends StatelessWidget {
  final String mealType;
  final String imageUrl;
  final VoidCallback onClick;

  const MealTime({
    Key? key,
    required this.mealType,
    required this.imageUrl,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      imageUrl,
                    ))),
            // color: Colors.blue,
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.80),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              mealType,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          Positioned.fill(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.white38,
                    onTap: onClick,
                  ))),
        ],
      ),
    ));
  }
}

class MealListItem extends StatelessWidget {
  final Meal meal;

  const MealListItem({
    super.key,
    required this.meal,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, Routes.mealItem,
                  arguments: [meal.id]);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Row(
                  children: [
                    // Gate Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        "assets/images/food_item.jpg",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16.0),

                    // Gate Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            meal.completeMeal,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            meal.mealTime,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Row(
                            children: [
                              const Icon(
                                Icons.directions_walk,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                meal.generatedTimes.toString(),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.3,
                  endIndent: 20,
                )
              ]),
            )));
  }
}

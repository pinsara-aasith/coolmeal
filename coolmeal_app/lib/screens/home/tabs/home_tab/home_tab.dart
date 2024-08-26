import 'dart:io';
import 'dart:ui';

import 'package:coolmeal/screens/home/tabs/create_meal_plan_tab/widgets/generate_meal.dart';
import 'package:coolmeal/theming/colors.dart';
import 'package:coolmeal/theming/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
  }

  void handleMealClick(String mealType) {
    // Handle the click event here
    print('$mealType clicked!');
  }

    final List<Map<String, String>> gateItems = [
    {
      'imageUrl':
          'https://example.com/gate1.jpg', // Replace with actual image URLs
      'gateName': 'Bab As Salam - Gate 1',
      'accessType': 'Mens & women Access',
      'distance': '2 mins away'
    },
    {
      'imageUrl': 'https://example.com/gate2.jpg',
      'gateName': 'Bab Abu Bakr - Gate 2',
      'accessType': 'Mens Only',
      'distance': '2 mins away'
    },
    {
      'imageUrl': 'https://example.com/gate2.jpg',
      'gateName': 'Bab Abu Bakr - Gate 2',
      'accessType': 'Mens Only',
      'distance': '2 mins away'
    },
    {
      'imageUrl': 'https://example.com/gate2.jpg',
      'gateName': 'Bab Abu Bakr - Gate 2',
      'accessType': 'Mens Only',
      'distance': '2 mins away'
    },
    {
      'imageUrl': 'https://example.com/gate2.jpg',
      'gateName': 'Bab Abu Bakr - Gate 2',
      'accessType': 'Mens Only',
      'distance': '2 mins away'
    },
    {
      'imageUrl': 'https://example.com/gate2.jpg',
      'gateName': 'Bab Abu Bakr - Gate 2',
      'accessType': 'Mens Only',
      'distance': '2 mins away'
    },
    {
      'imageUrl': 'https://example.com/gate2.jpg',
      'gateName': 'Bab Abu Bakr - Gate 2',
      'accessType': 'Mens Only',
      'distance': '2 mins away'
    },
    {
      'imageUrl': 'https://example.com/gate2.jpg',
      'gateName': 'Bab Abu Bakr - Gate 2',
      'accessType': 'Mens Only',
      'distance': '2 mins away'
    },
    {
      'imageUrl': 'https://example.com/gate3.jpg',
      'gateName': 'Bab Al-Rahmah - Gate 3',
      'accessType': 'Women Only',
      'distance': '2 mins away'
    },
    {
      'imageUrl': 'https://example.com/gate4.jpg',
      'gateName': 'Bab Al-Hijrah - Gate 4',
      'accessType': 'Mens & women Access',
      'distance': '2 mins away'
    },
  ];


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
                            MealItem(
                              imageUrl: "assets/images/breakfast.jpg",
                              mealType: 'Breakfast',
                              onClick: () => handleMealClick('Breakfast'),
                            ),
                            Gap(6.h),
                            MealItem(
                              imageUrl: "assets/images/lunch.jpg",
                              mealType: 'Lunch',
                              onClick: () => handleMealClick('Lunch'),
                            ),
                            Gap(6.h),
                            MealItem(
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


            SliverList(
              delegate: SliverChildBuilderDelegate( (BuildContext context, int index) {
                var gateItem = gateItems[index];
  return GateListItem(
          imageUrl: gateItem['imageUrl']!,
          gateName: gateItem['gateName']!,
          accessType: gateItem['accessType']!,
          distance: gateItem['distance']!,
        );
                  
                  },childCount: gateItems.length,)
              
              )
          ],
        ));
  }
}

class MealItem extends StatelessWidget {
  final String mealType;
  final String imageUrl;
  final VoidCallback onClick;

  const MealItem({
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

class GateListItem extends StatelessWidget {
  final String imageUrl;
  final String gateName;
  final String accessType;
  final String distance;

  GateListItem({
    required this.imageUrl,
    required this.gateName,
    required this.accessType,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
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
                  gateName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  accessType,
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
                      distance,
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

          // Navigation Icon
          const Icon(
            Icons.navigation,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}

import 'dart:io';

import 'package:coolmeal/screens/home/tabs/new_meal_plan_tab/widgets/generate_meal.dart';
import 'package:coolmeal/theming/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class HomeTabOLD extends StatefulWidget {
  const HomeTabOLD({Key? key}) : super(key: key);

  @override
  State<HomeTabOLD> createState() => _HomeTabOLDState();
}

class _HomeTabOLDState extends State<HomeTabOLD>
    with SingleTickerProviderStateMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController shopController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
    }
  }

  late LatLng homeAddress;
  late LatLng businessAddress;
  late LatLng shoppingAddress;

  TextEditingController ageController = TextEditingController();
  String? selectedGender;
  String? selectedNationality;
  late final AnimationController _animController;

  late final Animation<double> _rotationAnim;

// Initialize the DraggableScrollableController.
// This will be used to get and control the state of the sheet
  final dragController = DraggableScrollableController();

  final double maxScrollHeight = 0.8;
  final double minScrollHeight = 0.2;
  @override
  void initState() {
    super.initState();
    dragController.addListener(() {
      final newSize = dragController.size;
      final scrollPosition =
          ((newSize - minScrollHeight) / (maxScrollHeight - minScrollHeight))
              .clamp(0.0, 1.0);

      // Drive the animation based on scroll position
      _animController.animateTo(scrollPosition, duration: Duration.zero);
    });

    // Initialize the animation controller
    _animController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Create a custom animation that interpolates between 0 and 0.5
    // based on scroll position
    _rotationAnim =
        Tween<double>(begin: 0.0, end: 0.5).animate(_animController);
  }

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    // todo 1: Initialize animation controller and DraggableScrollableController
    void animateDragOnTap(double height) {
      // Use dragController to control the sheet positioning.
      dragController.animateTo(
        height,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }

    void toggleDragSheet() {
      if (dragController.size == maxScrollHeight) {
        animateDragOnTap(minScrollHeight);
      } else {
        animateDragOnTap(maxScrollHeight);
      }
    }

    return
        // Container(
        //   child: Stack(
        //     children: [
        //       // greenIntroWidgetWithoutLogos(title: 'My Profile'),
        //       Align(
        //         alignment: Alignment.bottomCenter,
        //         child: InkWell(
        //           onTap: () {
        //             // getImage(ImageSource.camera);
        //           },
        //           child: selectedImage == null
        //               ? user.photoURL != null
        //                   ? Container(
        //                       width: 120,
        //                       height: 120,
        //                       margin: const EdgeInsets.only(bottom: 20),
        //                       decoration: BoxDecoration(
        //                           image: DecorationImage(
        //                               image: NetworkImage(user.photoURL!),
        //                               fit: BoxFit.fill),
        //                           shape: BoxShape.circle,
        //                           color: const Color(0xffD6D6D6)),
        //                     )
        //                   : Container(
        //                       width: 120,
        //                       height: 120,
        //                       margin: const EdgeInsets.only(bottom: 20),
        //                       decoration: const BoxDecoration(
        //                           shape: BoxShape.circle,
        //                           color: Color(0xffD6D6D6)),
        //                       child: const Center(
        //                         child: Icon(
        //                           Icons.camera_alt_outlined,
        //                           size: 40,
        //                           color: Colors.white,
        //                         ),
        //                       ),
        //                     )
        //               : Container(
        //                   width: 120,
        //                   height: 120,
        //                   margin: const EdgeInsets.only(bottom: 20),
        //                   decoration: BoxDecoration(
        //                       image: DecorationImage(
        //                           image: FileImage(selectedImage!),
        //                           fit: BoxFit.fill),
        //                       shape: BoxShape.circle,
        //                       color: const Color(0xffD6D6D6)),
        //                 ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(
        //   height: 20,
        // ),
        Container(
      decoration: BoxDecoration(
        gradient: welcomeGradient,
      ),
      child: Stack(
        children: [
          const FractionallySizedBox(
            heightFactor: 0.7,
            alignment: Alignment.topCenter,
            child: GenerateMealForm(),
          ),
          DraggableScrollableSheet(
            initialChildSize: .30,
            minChildSize: minScrollHeight,
            maxChildSize: maxScrollHeight,
            controller: dragController,
            snapAnimationDuration: const Duration(milliseconds: 150),
            builder: (BuildContext context, ScrollController scrollController) {
              // todo 3: add listener to dragController

              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 0),
                              // todo 4: Wrap Icon with RotationTransition widget
                              child: RotationTransition(
                                turns: _rotationAnim,
                                child: const Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  size: 40,
                                ),
                              )),
                          ...List.generate(
                            17,
                            (index) => ListTile(
                              title: Text("Tile number: ${index + 1}"),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

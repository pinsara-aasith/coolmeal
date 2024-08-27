import 'dart:io';

import 'package:coolmeal/core/widgets/form_field_wrapper.dart';
import 'package:coolmeal/core/widgets/gender_toggle.dart';
import 'package:coolmeal/screens/complete_profile/ui/widgets/page_header.dart';
import 'package:coolmeal/theming/colors.dart';
import 'package:coolmeal/theming/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: welcomeGradient,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CategoryTitle(
                    title: "Profile",
                    subtitle: "Update Profile Details",
                    assetImagePath:
                        "assets/images/tell_me_more_about_you_2.png"),
                // Name
                FormFieldWrapper(
                    label: "Name",
                    textField: TextField(
                        controller: nameController,
                        decoration:
                            TextDecorations.getLabellessTextFieldDecoration(
                                placeholder: "Name", context: context))),

                Gap(16.h),

                Row(
                  children: [
                    Expanded(
                        child: FormFieldWrapper(
                      label: "Height",
                      textField: TextFormField(
                          controller: ageController,
                          decoration:
                              TextDecorations.getLabellessTextFieldDecoration(
                                  placeholder: "Height", context: context),
                          keyboardType: TextInputType.number),
                    )),
                    Gap(10.w),
                    Expanded(
                        child: FormFieldWrapper(
                      label: "Weight",
                      textField: TextFormField(
                          controller: ageController,
                          decoration:
                              TextDecorations.getLabellessTextFieldDecoration(
                                  placeholder: "Weight", context: context),
                          keyboardType: TextInputType.number),
                    )),
                  ],
                ),

                Gap(16.h),
                // Age
                FormFieldWrapper(
                  label: "Age",
                  textField: TextFormField(
                      controller: ageController,
                      decoration:
                          TextDecorations.getLabellessTextFieldDecoration(
                              placeholder: "Age", context: context),
                      keyboardType: TextInputType.number),
                ),

                Gap(16.h),
                // Gender
                FormFieldWrapper(
                    label: "Gender",
                    textField: GenderToggle(
                        selectedGender: selectedGender,
                        onGenderSelected: (gender) {
                          setState(() {
                            selectedGender = gender;
                          });
                        })),

                const SizedBox(height: 16),

                FormFieldWrapper(
                    label: "Health Concerns",
                    textField: TextField(
                        controller: nameController,
                        decoration:
                            TextDecorations.getLabellessTextFieldDecoration(
                                placeholder:
                                    "Please list any health issues or conditions.",
                                context: context))),
                Gap(16.h),
                FormFieldWrapper(
                    label: "Any allergies?",
                    textField: TextField(
                        controller: nameController,
                        decoration:
                            TextDecorations.getLabellessTextFieldDecoration(
                                placeholder: "Do you have any allergies?",
                                context: context))),
                Gap(16.h),
                FormFieldWrapper(
                    label: "Fitness goals?",
                    textField: TextField(
                        controller: nameController,
                        decoration:
                            TextDecorations.getLabellessTextFieldDecoration(
                                placeholder: "What are your fitness goals?",
                                context: context))),
                Gap(16.h),
                FormFieldWrapper(
                    label: "Exercise level?",
                    textField: TextField(
                        controller: nameController,
                        decoration:
                            TextDecorations.getLabellessTextFieldDecoration(
                                placeholder:
                                    "Describe your current exercise routine.",
                                context: context))),
                Gap(16.h),
              ],
            ),
          ),
        )),
        ElevatedButton(
          onPressed: () {
            // saveData();
            // widget.onClickNext();
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Theme.of(context).primaryColor),
          child: const Text(
            'Save Details',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ]),
    );
  }
}

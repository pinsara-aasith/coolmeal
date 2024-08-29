import 'dart:io';

import 'package:coolmeal/core/widgets/form_field_wrapper.dart';
import 'package:coolmeal/routing/routes.dart';
import 'package:coolmeal/screens/complete_profile/ui/widgets/page_header.dart';
import 'package:coolmeal/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class GenerateMealForm extends StatefulWidget {
  const GenerateMealForm({Key? key}) : super(key: key);

  @override
  State<GenerateMealForm> createState() => _GenerateMealFormState();
}

class _GenerateMealFormState extends State<GenerateMealForm> {
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

  TextEditingController ageController = TextEditingController();
  String? selectedGender;
  String? selectedNationality;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CategoryTitle(
                    title: "Meals",
                    subtitle: "Get Your Meal",
                    assetImagePath:
                        "assets/images/tell_me_more_about_you_2.png"),

                // Row(
                //   children: [
                //     Expanded(
                //         child: FormFieldWrapper(
                //       label: "No of meals per day",
                //       textField: TextFormField(
                //           controller: ageController,
                //           decoration:
                //               TextDecorations.getLabellessTextFieldDecoration(
                //                   placeholder: "No of meals", context: context),
                //           keyboardType: TextInputType.number),
                //     )),
                //     Gap(10.w),
                //     Expanded(
                //         child: FormFieldWrapper(
                //       label: "Curries need with rice",
                //       textField: TextFormField(
                //           controller: ageController,
                //           decoration:
                //               TextDecorations.getLabellessTextFieldDecoration(
                //                   placeholder: "Curries with rice",
                //                   context: context),
                //           keyboardType: TextInputType.number),
                //     )),
                //   ],
                // ),

                Gap(16.h),
                // Age
                FormFieldWrapper(
                  label: "Your budget for this week",
                  textField: TextFormField(
                      controller: ageController,
                      decoration:
                          TextDecorations.getLabellessTextFieldDecoration(
                              placeholder: "Budget for this week",
                              context: context),
                      keyboardType: TextInputType.number),
                ),

                const SizedBox(height: 16),
                Container(
                  height: 1 * 0.1,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  color: Theme.of(context).primaryColor,
                  width: double.infinity,
                ),
                const SizedBox(height: 16),
                const Text(
                  "Personal Details",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),
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
                    label: "Exercise level For The Week?",
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
        OutlinedButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.pushNamed(context, Routes.profileCompletion);
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(14),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1)),
          ),
          child: const Text(
            'Customize Other Personal Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Gap(10.h),
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
            'Get Your Meal',
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
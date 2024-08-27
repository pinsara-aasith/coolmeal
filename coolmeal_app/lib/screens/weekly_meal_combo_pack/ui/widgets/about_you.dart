import 'package:coolmeal/core/widgets/form_field_wrapper.dart';
import 'package:coolmeal/core/widgets/gender_toggle.dart';
import 'package:coolmeal/screens/complete_profile/ui/widgets/page_header.dart';
import 'package:coolmeal/theming/colors.dart';
import 'package:coolmeal/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AboutYou extends StatefulWidget {
  final VoidCallback onClickNext;

  const AboutYou({Key? key, required this.onClickNext}) : super(key: key);

  @override
  State<AboutYou> createState() => _AboutYouState();
}

class _AboutYouState extends State<AboutYou> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String? selectedGender;
  String? selectedNationality;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  void loadData() {
    // Map<dynamic, dynamic>? userInfoRepo =
    //     UserInfomationRepository().getUserInformation();

    // if (userInfoRepo == null) return;

    setState(() {
      // nameController.text = (userInfoRepo['name'] ?? '').toString();
      // ageController.text = (userInfoRepo['age'] ?? '').toString();

      // selectedGender = userInfoRepo['gender'];
      // selectedNationality = userInfoRepo['nationality'];
    });
  }

  Future<void> saveData() async {
    // await UserInfomationRepository().saveAll({
    //   'name': nameController.text,
    //   'age': ageController.text,
    //   'gender': selectedGender,
    //   'nationality': selectedNationality,
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: welcomeGradient,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const SizedBox(height: 20),
        const CategoryTitle(
            title: "Complete Your Profile",
            subtitle: "Tell more about yourself",
            assetImagePath: "assets/images/tell_me_more_about_you_2.png"),
        const SizedBox(height: 20),
        Expanded(
            child: 
            
            
            SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
              ],
            ),
          ),
        )),
        ElevatedButton(
          onPressed: () {
            saveData();
            widget.onClickNext();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Theme.of(context).primaryColor),
          child: const Text(
            'Next',
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

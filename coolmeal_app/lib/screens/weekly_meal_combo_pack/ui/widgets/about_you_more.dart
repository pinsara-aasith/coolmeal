import 'package:coolmeal/core/widgets/form_field_wrapper.dart';
import 'package:coolmeal/core/widgets/toggle_buttons.dart';
import 'package:coolmeal/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'page_header.dart';
import 'package:flutter/material.dart';

class AboutYouMore extends StatefulWidget {
  final VoidCallback onClickNext;

  const AboutYouMore({Key? key, required this.onClickNext}) : super(key: key);

  @override
  State<AboutYouMore> createState() => _AboutYouMoreState();
}

class _AboutYouMoreState extends State<AboutYouMore> {

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String? selectedActivityLevel;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  void loadData() {
    // Map<dynamic, dynamic>? userInfoRepo =
    //     UserInfomationRepository().getUserInformation();

    // if (userInfoRepo == null) return;

    setState(() {
      // _internationalPhoneNo = userInfoRepo['internationalPhoneNo'];
      // _saudiPhoneNo = userInfoRepo['saudiPhoneNo'];
    });
  }

  Future<void> saveData() async {
    // await UserInfomationRepository().saveAll({
    //   'internationalPhoneNo': _internationalPhoneNo,
    //   'saudiPhoneNo': _saudiPhoneNo,
    // });
  }

  final focusNodeForInternationalPhone = FocusNode();
  @override
  void dispose() {
    focusNodeForInternationalPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 3),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const SizedBox(height: 20),
        const CategoryTitle(
            title: "Complete Your Profile",
            subtitle: "Tell Me More About You",
            assetImagePath: "assets/images/tell_me_more_about_you_2.png"),
        const SizedBox(height: 35),
        Expanded(
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                    textField:CMToggleButtons(
                      selectedKey: selectedActivityLevel,
                      hideIcon: true,
                      onSelected: (key) => setState(() => selectedActivityLevel = key),
                      keyValueMap: const {
                        'sedentary': ["Sedentary", Icons.run_circle],
                        'very active': ["Very Active", Icons.female],
                        'active': ["Active", Icons.female],
                        'other': ["Other", Icons.transgender],
                      },
                    ) ),
                Gap(16.h),
              ],
            ),
          )),
        ),
        ElevatedButton(
          onPressed: () {
            saveData();
            FocusManager.instance.primaryFocus?.unfocus();
            widget.onClickNext();
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

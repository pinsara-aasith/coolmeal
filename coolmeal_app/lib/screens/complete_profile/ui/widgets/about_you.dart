import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolmeal/bloc/app_bloc.dart';
import 'package:coolmeal/core/widgets/form_field_wrapper.dart';
import 'package:coolmeal/core/widgets/gender_toggle.dart';
import 'package:coolmeal/screens/complete_profile/ui/widgets/page_header.dart';
import 'package:coolmeal/theming/colors.dart';
import 'package:coolmeal/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String? selectedGender;

  bool loading = true;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> saveData() async {
    var user = context.read<AppBloc>().state.user;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user_profiles')
        .where('email', isEqualTo: user?.email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var docId = querySnapshot.docs.first.id; // Get the document ID

      await FirebaseFirestore.instance.collection('user_profiles').doc(docId).update({
        'email': user?.email,
        'name': nameController.text,
        'age': int.tryParse(ageController.text) ?? 0,
        'gender': selectedGender,
        'height': int.tryParse(heightController.text) ?? 0,
        'weight': int.tryParse(weightController.text) ?? 0,
      });
    } else {
      FirebaseFirestore.instance.collection('user_profiles').add({
        'email': user?.email,
        'name': nameController.text,
        'age': int.tryParse(ageController.text) ?? 0,
        'gender': selectedGender,
        'height': int.tryParse(heightController.text) ?? 0,
        'weight': int.tryParse(weightController.text) ?? 0,
      });
    }
  }

  void loadData() async {
    var user = context.read<AppBloc>().state.user;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user_profiles')
        .where('email', isEqualTo: user?.email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var userDoc = querySnapshot.docs.first;

      setState(() {
        nameController.text = userDoc['name'] ?? '';
        ageController.text = userDoc['age']?.toString() ?? '';
        selectedGender = userDoc['gender'];

        heightController.text = userDoc['height']?.toString()  ?? '';
        weightController.text = userDoc['weight']?.toString()  ?? '';
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: welcomeGradient,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        if (loading) ...[
          const Column(
              children: [SizedBox(height: 20), CircularProgressIndicator()])
        ],
        const SizedBox(height: 20),
        const CategoryTitle(
            title: "Complete Your Profile",
            subtitle: "Tell more about yourself",
            assetImagePath: "assets/images/tell_me_more_about_you_2.png"),
        const SizedBox(height: 20),
        Expanded(
            child: SingleChildScrollView(
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
                      label: "Height(cm)",
                      textField: TextFormField(
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        decoration:
                            TextDecorations.getLabellessTextFieldDecoration(
                                placeholder: "Height", context: context),
                      ),
                    )),
                    Gap(10.w),
                    Expanded(
                        child: FormFieldWrapper(
                      label: "Weight(kg)",
                      textField: TextFormField(
                          controller: weightController,
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
                  label: "Age(years)",
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
          onPressed: ()async  {
            await saveData();
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

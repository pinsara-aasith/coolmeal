import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolmeal/core/widgets/form_field_wrapper.dart';
import 'package:coolmeal/core/widgets/toggle_buttons.dart';
import 'package:coolmeal/theming/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../widgets/page_header.dart';
import 'package:flutter/material.dart';

class AboutYouMore extends StatefulWidget {
  final VoidCallback onClickNext;

  const AboutYouMore({Key? key, required this.onClickNext}) : super(key: key);

  @override
  State<AboutYouMore> createState() => _AboutYouMoreState();
}

class _AboutYouMoreState extends State<AboutYouMore> {
  TextEditingController healthConcernsController = TextEditingController();
  TextEditingController anyAllerigesController = TextEditingController();

  String _selectedActivityLevel = 'very active';
  String _selectedFitnessGoals = 'Cutting';
  @override
  void initState() {
    super.initState();
    loadData();
  }

  bool loading = true;

  Future<void> saveData() async {
    var user = FirebaseAuth.instance.currentUser;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user_profiles')
        .where('email', isEqualTo: user?.email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var docId = querySnapshot.docs.first.id; // Get the document ID

      await FirebaseFirestore.instance
          .collection('user_profiles')
          .doc(docId)
          .update({
        'email': user?.email,
        'healthConcerns': healthConcernsController.text,
        'anyAllergies': anyAllerigesController.text,
        'fitnessGoals': _selectedFitnessGoals,
        'exerciseLevel': _selectedActivityLevel,
      });
    } else {
      FirebaseFirestore.instance.collection('user_profiles').add({
        'email': user?.email,
        'healthConcerns': healthConcernsController.text,
        'anyAllergies': anyAllerigesController.text,
        'fitnessGoals': _selectedFitnessGoals,
        'exerciseLevel': _selectedActivityLevel,
      });
    }
  }

  void loadData() async {
    var user = FirebaseAuth.instance.currentUser;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('user_profiles')
        .where('email', isEqualTo: user?.email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var userDoc = querySnapshot.docs.first.data() as Map<String, dynamic>;

      setState(() {
        healthConcernsController.text = userDoc['healthConcerns'] ?? '';
        anyAllerigesController.text = userDoc['anyAllergies'] ?? '';
        _selectedFitnessGoals = userDoc['fitnessGoals'] ?? '';
        _selectedActivityLevel = userDoc['exerciseLevel'] ?? '';

        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
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
        if (loading) ...[
          const Column(
              children: [SizedBox(height: 20), CircularProgressIndicator()])
        ],
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
                    label: "Health Concerns (eg. Diebetes, Cholesterol)",
                    textField: TextField(
                        controller: healthConcernsController,
                        decoration:
                            TextDecorations.getLabellessTextFieldDecoration(
                                placeholder:
                                    "Please list any health issues or conditions.",
                                context: context))),
                Gap(16.h),
                FormFieldWrapper(
                    label: "Any allergies?",
                    textField: TextField(
                        controller: anyAllerigesController,
                        decoration:
                            TextDecorations.getLabellessTextFieldDecoration(
                                placeholder: "Do you have any allergies?",
                                context: context))),
                Gap(16.h),
                FormFieldWrapper(
                    label: "Fitness goals?",
                    textField: CMToggleButtons(
                      selectedKey: _selectedFitnessGoals,
                      onSelected: (key) =>
                          setState(() => _selectedFitnessGoals = key),
                      keyValueMap: const {
                        'Cutting': ["Cutting", Icons.cut],
                        'Bulking': ["Bulking", Icons.man_4_outlined],
                        'Weightloss': ["Weightloss", Icons.stacked_bar_chart],
                      },
                    )),
                Gap(16.h),
                FormFieldWrapper(
                    label: "Exercise level?",
                    textField: CMToggleButtons(
                      selectedKey: _selectedActivityLevel,
                      hideIcon: true,
                      onSelected: (key) =>
                          setState(() => _selectedActivityLevel = key),
                      keyValueMap: const {
                        'sedentary': ["Sedentary", Icons.run_circle],
                        'very active': ["Very Active", Icons.female],
                        'active': ["Active", Icons.female],
                        'other': ["Other", Icons.transgender],
                      },
                    )),
                Gap(16.h),
              ],
            ),
          )),
        ),
        ElevatedButton(
          onPressed: () async {
            setState(() {
              loading = true;
            });
            await saveData();

            FocusManager.instance.primaryFocus?.unfocus();
            setState(() {
              loading = false;
            });
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

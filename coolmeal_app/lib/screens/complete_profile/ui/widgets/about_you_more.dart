import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coolmeal/core/widgets/form_field_wrapper.dart';
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
  TextEditingController fitnessGoalsController = TextEditingController();
  TextEditingController excerciseLevelController = TextEditingController();

  @override
  void initState() {
    loadData();
    super.initState();
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
        'fitnessGoals': fitnessGoalsController.text,
        'exerciseLevel': excerciseLevelController.text,
      });
    } else {
      FirebaseFirestore.instance.collection('user_profiles').add({
        'email': user?.email,
        'healthConcerns': healthConcernsController.text,
        'anyAllergies': anyAllerigesController.text,
        'fitnessGoals': fitnessGoalsController.text,
        'exerciseLevel': excerciseLevelController.text,
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
      var userDoc = querySnapshot.docs.first;

      setState(() {
        healthConcernsController.text = userDoc['healthConcerns'] ?? '';
        anyAllerigesController.text = userDoc['anyAllergies'] ?? '';
        fitnessGoalsController.text = userDoc['fitnessGoals'] ?? '';
        excerciseLevelController.text = userDoc['exerciseLevel'] ?? '';

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
                    label: "Health Concerns",
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
                        controller: healthConcernsController,
                        decoration:
                            TextDecorations.getLabellessTextFieldDecoration(
                                placeholder: "Do you have any allergies?",
                                context: context))),
                Gap(16.h),
                FormFieldWrapper(
                    label: "Fitness goals?",
                    textField: TextField(
                        controller: healthConcernsController,
                        decoration:
                            TextDecorations.getLabellessTextFieldDecoration(
                                placeholder: "What are your fitness goals?",
                                context: context))),
                Gap(16.h),
                FormFieldWrapper(
                    label: "Exercise level?",
                    textField: TextField(
                        controller: healthConcernsController,
                        decoration:
                            TextDecorations.getLabellessTextFieldDecoration(
                                placeholder:
                                    "Describe your current exercise routine.",
                                context: context))),
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

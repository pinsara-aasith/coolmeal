import 'dart:convert';
import 'dart:io';

import 'package:coolmeal/core/widgets/form_field_wrapper.dart';
import 'package:coolmeal/core/widgets/loading_screen.dart';
import 'package:coolmeal/core/widgets/toggle_buttons.dart';
import 'package:coolmeal/main.dart';
import 'package:coolmeal/models/meal_plan.dart';
import 'package:coolmeal/models/meal_plan_collection.dart';
import 'package:coolmeal/repositories/user_profile_repository.dart';
import 'package:coolmeal/routing/routes.dart';
import 'package:coolmeal/screens/complete_profile/ui/widgets/page_header.dart';
import 'package:coolmeal/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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

  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _ageController = TextEditingController();
  final _budgetController = TextEditingController();
  final String _selectedGender = 'male';
  String _selectedActivityLevel = 'very active';

  String? selectedGender;
  String? selectedNationality;

  @override
  void initState() {
    super.initState();
    var userProfile =
        RepositoryProvider.of<UserProfileRepository>(context).userProfile;

    _weightController.text = userProfile?.weight?.toString() ?? '';
    _heightController.text = userProfile?.height?.toString() ?? '';
    _ageController.text = userProfile?.age?.toString() ?? '';
  }

  int _getNumberFromLevel(String? level) {
    if (level == 'none') {
      return 0;
    }
    if (level == 'medium') {
      return 4;
    }
    if (level == 'high') {
      return 7;
    }
    if (level == 'very high') {
      return 10;
    }

    return 0;
  }

  void _generatePrediction() async {
    try {
      var userProfile =
          RepositoryProvider.of<UserProfileRepository>(context).userProfile;

      LoadingScreen.instance().show(
          context: context,
          text: "We are generating a meal plan tailored to your needs...");
      final weight = double.parse(_weightController.text);
      final height = double.parse(_heightController.text);
      final age = double.parse(_ageController.text);
      final price = double.parse(_budgetController.text);

      final response = await http.post(
        Uri.parse('$ServerIP/prediction'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'weight': weight,
          'height': height,
          'age': age,
          'gender': _selectedGender,
          'price': price,
          'activity_level': _selectedActivityLevel,
          'chol_input': _getNumberFromLevel(userProfile?.cholestrolLevel),
          'diabetes_input': _getNumberFromLevel(userProfile?.cholestrolLevel),
          'pressure_input': _getNumberFromLevel(userProfile?.cholestrolLevel),
        }),
      );

      LoadingScreen.instance().hide();
      if (response.statusCode == 200) {
        final prediction = jsonDecode(response.body);

        var mpc = MealPlanCollection(
            name: "Meal plan on ${DateTime.now().toString()}",
            description: '',
            generatedTime: DateTime.now().toString(),
            mealPlans: (prediction["prediction"] as List)
                .map<MealPlan>((m) => MealPlan.fromJson(m))
                .toList());

        Navigator.pushNamed(context, Routes.mealPlanPerWeek, arguments: [mpc]);
      } else {
        // Handle error
        print(response.body);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to generate prediction')),
        );
      }
    } catch (e) {
      print(e);
      LoadingScreen.instance().hide();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to generate prediction')),
      );
    }
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

                Gap(8.h),
                const Text(
                  "Personal Details",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),
                // Age

                FormFieldWrapper(
                  label: "Age (years)",
                  textField: TextFormField(
                      style: const TextStyle(fontWeight: FontWeight.w700),
                      controller: _ageController,
                      decoration:
                          TextDecorations.getLabellessTextFieldDecoration(
                              placeholder: "Age", context: context),
                      keyboardType: TextInputType.number),
                ),

                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: FormFieldWrapper(
                      label: "Height(cm)",
                      textField: TextFormField(
                          style: const TextStyle(fontWeight: FontWeight.w700),
                          controller: _heightController,
                          decoration:
                              TextDecorations.getLabellessTextFieldDecoration(
                                  placeholder: "Height", context: context),
                          keyboardType: TextInputType.number),
                    )),
                    Gap(10.w),
                    Expanded(
                        child: FormFieldWrapper(
                      label: "Weight(kg)",
                      textField: TextFormField(
                          controller: _weightController,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                          decoration:
                              TextDecorations.getLabellessTextFieldDecoration(
                                  placeholder: "Weight", context: context),
                          keyboardType: TextInputType.number),
                    )),
                  ],
                ),
                Gap(16.h),
                Container(
                  height: 1 * 0.1,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  color: Theme.of(context).primaryColor,
                  width: double.infinity,
                ),
                const SizedBox(height: 16),
                // FormFieldWrapper(
                //     label: "Fitness goals?",
                //     textField: TextField(
                //         controller: nameController,
                //         decoration:
                //             TextDecorations.getLabellessTextFieldDecoration(
                //                 placeholder: "What are your fitness goals?",
                //                 context: context))),
                // Gap(16.h),
                FormFieldWrapper(
                  label: "How much you can spend on foods per day (Rs.)",
                  textField: TextFormField(
                      controller: _budgetController,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      decoration:
                          TextDecorations.getLabellessTextFieldDecoration(
                              placeholder: "How much you can spend on foods",
                              context: context),
                      keyboardType: TextInputType.number),
                ),
                Gap(16.h),
                FormFieldWrapper(
                  label: "Exercise level For The Week?",
                  textField: Column(children: [
                    Gap(5.h),
                    CMToggleButtons(
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
                    )
                  ]),
                ),
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
            _generatePrediction();
            // FocusManager.instance.primaryFocus?.unfocus();
            // Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Theme.of(context).primaryColor),
          child: const Text(
            'Get Your Meal Plan For Week',
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

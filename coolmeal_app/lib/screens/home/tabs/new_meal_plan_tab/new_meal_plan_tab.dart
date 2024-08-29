import 'dart:io';

import 'package:coolmeal/screens/home/tabs/new_meal_plan_tab/widgets/generate_meal_form.dart';
import 'package:coolmeal/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class NewMealPlanTab extends StatefulWidget {
  const NewMealPlanTab({Key? key}) : super(key: key);

  @override
  State<NewMealPlanTab> createState() => _NewMealPlanTabState();
}

class _NewMealPlanTabState extends State<NewMealPlanTab>
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorsManager.gradient.withAlpha(100),
      ),
      child: const GenerateMealForm(),
    );
  }
}

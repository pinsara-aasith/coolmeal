
import 'package:flutter/material.dart';

class GenderToggle extends StatelessWidget {
  final String? selectedGender;
  final void Function(String) onGenderSelected;

  const GenderToggle({super.key, required this.selectedGender, required this.onGenderSelected});


  void toggleGender(String gender) {
    onGenderSelected(gender);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: buildToggleButton(context, 'Male', Icons.male, 'male')),
        const SizedBox(width: 20),
        Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: buildToggleButton(context, 'Female', Icons.female, 'female')),
      ],
    );
  }

  Widget buildToggleButton(BuildContext context, String text, IconData icon, String gender) {
    return InkWell(
      onTap: () => toggleGender(gender),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: selectedGender == gender
                ? Theme.of(context).primaryColor
                : Colors.grey,
            width: 1,
          ),
          color: selectedGender == gender
              ? Theme.of(context).primaryColor.withAlpha(70)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).primaryColor),
            const SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: selectedGender == gender
                    ? FontWeight.bold
                    : FontWeight.normal,
                color: selectedGender == gender
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

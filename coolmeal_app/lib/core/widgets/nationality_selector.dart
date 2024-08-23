import 'package:coolmeal/theming/colors.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class NationalitySelector extends StatefulWidget {
  final Function(String) onNationalityChanged;
  final String? defaultNationality;
  const NationalitySelector(
      {Key? key,
      required this.onNationalityChanged,
      required this.defaultNationality})
      : super(key: key);

  @override
  State<NationalitySelector> createState() => _NationalitySelectorState();
}

class _NationalitySelectorState extends State<NationalitySelector> {
  Country _selectedCountry = Country.parse("Egypt");
  @override
  void initState() {
    // Here the country has been treated as the nationality
    _selectedCountry = Country.tryParse(widget.defaultNationality ?? '') ??
        Country.parse("Egypt");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showCountryPicker(
            context: context,
            countryListTheme: CountryListThemeData(
              flagSize: 25,
              backgroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
              bottomSheetHeight: 500,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              inputDecoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Start typing to search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xFF8C98A8).withOpacity(0.2),
                  ),
                ),
              ),
            ),
            onSelect: (Country country) {
              setState(() => _selectedCountry = country);
              widget.onNationalityChanged(country.name);
            },
          );
        },
        child: Container(
            padding: const EdgeInsets.only(left: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26, width: 1),
              borderRadius: BorderRadius.circular(10),
              color: ColorsManager.textFieldFillColor,
            ),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                child: Row(children: [
                  Expanded(
                      child: Row(
                    children: [
                      Text(_selectedCountry.flagEmoji),
                      const SizedBox(width: 16),
                      Text(_selectedCountry.name),
                      const SizedBox(width: 8),
                      const Icon(Icons.chevron_left,
                          color: Colors.black54, size: 12),
                    ],
                  ))
                ]))));
  }
}

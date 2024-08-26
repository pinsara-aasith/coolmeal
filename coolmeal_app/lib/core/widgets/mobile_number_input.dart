import 'package:coolmeal/theming/colors.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class MobileNumberInputWidget extends StatefulWidget {
  final String label;
  final String hintText;
  final String? defaultPhoneNo;
  final Function(String) onPhoneNumberChanged;
  final Country? defaultCountry;
  final FocusNode? focusNode;

  const MobileNumberInputWidget(
      {Key? key,
      required this.label,
      required this.hintText,
      required this.onPhoneNumberChanged,
      this.defaultPhoneNo,
      this.defaultCountry,
      this.focusNode})
      : super(key: key);

  @override
  State<MobileNumberInputWidget> createState() =>
      _MobileNumberInputWidgetState();
}

List<String?> separateCountryPhoneCode(String phoneNumber) {
  RegExp regExp = RegExp(r'^\+(\d{1,3})\s(.+)$');
  RegExpMatch? match = regExp.firstMatch(phoneNumber);

  if (match != null) {
    String? countryCode = match.group(1);
    String? remainingNumber = match.group(2);

    return [countryCode, remainingNumber];
  } else {
    return [null, phoneNumber];
  }
}

class _MobileNumberInputWidgetState extends State<MobileNumberInputWidget> {
  Country _selectedCountry = Country.worldWide;
  String _latterPartOfPhone = '';

  @override
  void initState() {
    if (widget.defaultPhoneNo == null) {
      _selectedCountry = widget.defaultCountry ?? Country.worldWide;
    } else {
      List c = separateCountryPhoneCode(widget.defaultPhoneNo ?? '');

      String countryPhonecode = c[0] ?? '';
      _selectedCountry = CountryParser.tryParsePhoneCode(countryPhonecode) ??
          Country.worldWide;
      _latterPartOfPhone = c[1];
    }

    super.initState();
  }

  String _generatePhoneNo(countryPhoneCode, latterPart) {
    if (_selectedCountry.phoneCode == '') {
      return latterPart;
    } else {
      return "+$countryPhoneCode $latterPart";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black45)),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.only(left: 20),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black38, width: 1),
            borderRadius: BorderRadius.circular(10),
            color: ColorsManager.textFieldFillColor,
          ),
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          countryListTheme: CountryListThemeData(
                            flagSize: 25,
                            backgroundColor: Colors.white,
                            textStyle: const TextStyle(
                                fontSize: 16, color: Colors.blueGrey),
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
                                  color:
                                      const Color(0xFF8C98A8).withOpacity(0.2),
                                ),
                              ),
                            ),
                          ),
                          onSelect: (Country country) {
                            setState(() => _selectedCountry = country);
                            widget.onPhoneNumberChanged(_generatePhoneNo(
                                country.phoneCode, _latterPartOfPhone));
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Text(_selectedCountry.flagEmoji),
                          const SizedBox(width: 8),
                          Text('+${_selectedCountry.phoneCode}'),
                          const SizedBox(width: 8),
                          const Icon(Icons.chevron_left,
                              color: Colors.black54, size: 12),
                        ],
                      ))),
              Expanded(
                flex: 2,
                child: TextFormField(
                  focusNode: widget.focusNode,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    setState(() {
                      _latterPartOfPhone = value;
                    });

                    widget.onPhoneNumberChanged(
                        _generatePhoneNo(_selectedCountry.phoneCode, value));
                  },
                  initialValue: _latterPartOfPhone,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

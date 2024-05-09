import 'dart:developer';

import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

class CountryPicker extends StatefulWidget {
  const CountryPicker({super.key});

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  @override
  Widget build(BuildContext context) {
    return CSCPicker(
      onCountryChanged: (country) {
        log(country);
      },
      onStateChanged: (state) {
        log(state!);
      },
      onCityChanged: (city) {
        log(city!);
      },
    );
  }
}

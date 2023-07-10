import 'dart:convert';
import 'package:country_icons/country_icons.dart';

import 'package:flutter/material.dart';

class CountryFlagIcon extends StatelessWidget {
  final String countryCode;
  final double size;

  const CountryFlagIcon({
    super.key,
    required this.countryCode,
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(const CountryFlagIcon(
      countryCode: 'US',
      size: 48.0,
    ) as IconData?);
  }
}

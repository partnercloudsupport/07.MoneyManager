import 'package:flutter/material.dart';
import 'package:money_manager/utils/countries/countries.dart';
import 'package:money_manager/utils/countries/country.dart';

/// Created by Huan.Huynh on 2019-07-05.
///
/// Copyright © 2019 teqnological. All rights reserved.

void onWidgetDidBuild(Function callback) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    callback();
  });
}

class CountryPickerUtils {
  static Country getCountryByIsoCode(String isoCode) {
    try {
      return countryList.firstWhere(
          (country) => country.isoCode.toLowerCase() == isoCode.toLowerCase(),
      );
    } catch (error) {
      throw Exception("The initialValue provided is not a supported iso code!");
    }
  }

  static String getFlagImageAssetPath(String isoCode) {
    return "images/flags/${isoCode.toLowerCase()}.png";
  }

  static Widget getDefaultFlagImage(Country country) {
    return Image.asset(
      CountryPickerUtils.getFlagImageAssetPath(country.isoCode),
      height: 20.0,
      width: 30.0,
      fit: BoxFit.fill,
    );
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../presentation/const/app_const_assets.dart';

class AppLocalizationService extends Translations {
  final Map<String, Map<String, String>> _translations = {};

  @override
  Map<String, Map<String, String>> get keys => _translations;

  Future<void> loadTranslations() async {
    final languages = ['tr', 'en', 'de', 'ru'];

    for (String lang in languages) {
      try {
        String jsonString = await rootBundle.loadString(
          '${AppConstAssets.ASSET_TRANSELATION}/$lang.json',
        );

        Map<String, dynamic> jsonMap = json.decode(jsonString);

        String countryCode = _getCountryCode(lang);
        String localeKey = '${lang}_$countryCode';

        _translations[localeKey] = jsonMap.map(
          (key, value) => MapEntry(key, value.toString()),
        );
      } catch (e) {
        debugPrint("Could not load $lang.json: $e");
      }
    }
  }

  String _getCountryCode(String lang) {
    switch (lang) {
      case 'tr':
        return 'TR';
      case 'en':
        return 'US';
      case 'de':
        return 'DE';
      case 'ru':
        return 'RU';
      default:
        return 'TR';
    }
  }



}

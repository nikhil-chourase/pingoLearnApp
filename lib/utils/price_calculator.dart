

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class PriceCalculator extends ChangeNotifier {


  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

   Future<bool> get showDiscountedPrice async {
    await _remoteConfig.fetchAndActivate();
    return _remoteConfig.getBool('showDiscountedPrice');
  }

  int calculatePrice(double price) {
    return price.toInt(); // Convert to integer
  }

  int calculateDiscountedPrice(double price, double discountPercentage) {
    double discountedPrice = price - (discountPercentage / 100) * price;
    return discountedPrice.toInt(); // Convert to integer
  }


   Future<void> setupRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

   

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(minutes: 1),
      ),
    );

    try {
      await remoteConfig.fetchAndActivate();
    } catch (e) {
      print('Error fetching remote config: $e');
    }

    remoteConfig.onConfigUpdated.listen((RemoteConfigUpdate event) async {
      await remoteConfig.activate();
    });
  }

   

}

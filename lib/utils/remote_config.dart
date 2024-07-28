

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';


class RemoteConfigService with ChangeNotifier {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  bool _showDiscountedPrice = false;
  bool get showDiscountedPrice => _showDiscountedPrice;

  RemoteConfigService() {
    fetchRemoteConfig();
  }

  Future<void> fetchRemoteConfig() async {
    try {
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 10),
        minimumFetchInterval: Duration(seconds: 0), // For testing
      ));
      await _remoteConfig.fetchAndActivate();
      _showDiscountedPrice = _remoteConfig.getBool('showDiscountedPrice');
      notifyListeners();
    } catch (e) {
      print('Error fetching remote config: $e');
    }
  }
}


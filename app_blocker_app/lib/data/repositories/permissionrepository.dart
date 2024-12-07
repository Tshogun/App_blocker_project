import 'package:permission_handler/permission_handler.dart';

class PermissionRepository {
  PermissionRepository();

  Future<bool> isJurisdictionGranted(final prefs) async {
    return prefs.getBool('isJurisdictionGranted') ?? false;
  }

  Future<void> requestPermission() async {
    if (await Permission.systemAlertWindow.isGranted) {
      print("Permission already granted!");
    } else {
      await Permission.systemAlertWindow.request();
    }
  }

  Future<void> storeJurisdictionPermission(bool granted, final prefs) async {
    prefs.setBool('jurisdictionRequested', true);
    prefs.setBool('jurisdictionGranted', granted);
  }

  // This is for checking if permission has been requested previously
  Future<bool> isJurisdictionRequested(final prefs) async {
    return prefs.getBool('jurisdictionRequested') ?? false;
  }
}

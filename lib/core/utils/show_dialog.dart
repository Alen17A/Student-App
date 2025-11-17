import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Confirmations{
  static Future<bool> showConfirmationDialog(String message) async {
    return await Get.defaultDialog(
          title: "Are you sure?",
          titlePadding: EdgeInsets.only(top: 10, bottom: 10),
          content: Text(message),
          textConfirm: "Yes",
          textCancel: "No",
          onConfirm: () => Get.back(result: true),
        ) ??
        false;
  }

  static SnackbarController snackBarSuccess(String title, String message){
    return Get.snackbar(
      "",
      message,
      titleText: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: Colors.white,
      icon: Icon(Icons.check_circle, color: Colors.green),
      borderRadius: 10,
      borderWidth: 3,
      borderColor: Colors.green,
    );
  }

  static SnackbarController snackBarFailure(String title, String message) {
    return Get.snackbar(
      "",
      message,
      titleText: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: Colors.white,
      icon: Icon(Icons.cancel, color: Colors.red),
      borderRadius: 10,
      borderWidth: 3,
      borderColor: Colors.red,
    );
  }
}

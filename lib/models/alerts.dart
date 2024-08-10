//Interal Packages
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class Alerts {
  Future<bool> repeatPunch(String action, BuildContext context) async {
    if (Platform.isAndroid) {
      return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          titlePadding: const EdgeInsets.symmetric(vertical: 5),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          actionsPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          insetPadding: const EdgeInsets.all(20),
          title: const Text(
            'Alert',
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'You have already set a $action time.',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Are you sure you want to $action again?',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              }, 
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              }, 
            child: const Text('Yes'),
            ),
          ],
        )
      );
    } else if (Platform.isIOS) {
      return await showCupertinoDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text(
            'Alert',
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'You have already set a $action time.',
                textAlign: TextAlign.center,
              ),
              Text(
                'Are you sure you want to $action again?',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              }, 
              child: const Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, false);
              }, 
            child: const Text('Yes'),
            ),
          ],
        )
      );
    }
    else {
      return true;
    }
  }

  emptyInOut(String action, BuildContext context) {
    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog (
          titlePadding: const EdgeInsets.symmetric(vertical: 5),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          actionsPadding: const EdgeInsets.symmetric(vertical: 5),
          insetPadding: const EdgeInsets.all(20),
          actionsAlignment: MainAxisAlignment.center,
          title: const Text(
            'Alert',
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Text(
              'Please $action first.',
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog (
          title: const Text(
            'Alert',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Please punch-in first.',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              }, 
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
import 'package:estore_client/features/auth/login/presentation/screens/login_screen.dart';
import 'package:estore_client/generated/l10n.dart';
import 'package:flutter/material.dart';

void logInDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: Center(
          child: Text(
            "الرجاء تسجيل الدخول",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        content: Text(
          "للإستفادة من كافة مميزات التطبيق, يرجى تسجيل  الدخول",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.grey),
                  child: Text(
                    S.of(context).Later,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    S.of(context).GoNow,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

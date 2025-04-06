import 'package:estore_client/features/auth/reqistration/presentation/screens/registration_screen.dart';
import 'package:estore_client/generated/l10n.dart';
import 'package:flutter/material.dart';

void showProfileCompletionDialog(BuildContext context) {
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
            S.of(context).PleaseComplateYourProfile,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        content: Text(
          S.of(context).PleaseComplateYourProfileMsg,
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
                      MaterialPageRoute(
                        builder: (context) => const RegistrationScreen(),
                      ),
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

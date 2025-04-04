import 'package:estore_client/appSettings/presentation/controllers/settingsCubit.dart';
import '../../../../generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  _AppSettingsScreenState createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: Text(S.of(context).AppSettings)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            key: Key('Settings'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).AppTheme),
                SizedBox(
                  width: 350,
                  child: SwitchListTile(
                    title: Text(S.of(context).EnableDarkMode),
                    value: context.watch<SettingsCubit>().state.isDarkMode,
                    onChanged: (bool value) {
                      context.read<SettingsCubit>().toggleTheme();
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text(S.of(context).SelectLanguage),
                SizedBox(
                  width: 350,
                  child: DropdownButton<String>(
                    value: context.watch<SettingsCubit>().state.languageCode,
                    items: [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text(S.of(context).English),
                      ),
                      DropdownMenuItem(
                        value: 'ar',
                        child: Text(S.of(context).Arabic),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        context.read<SettingsCubit>().changeLanguage(newValue);
                      }
                    },
                    isExpanded: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

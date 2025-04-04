import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsState {
  final bool isDarkMode;
  final String languageCode;

  SettingsState(this.isDarkMode, this.languageCode);
}

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState(false, 'en')) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    String languageCode = prefs.getString('languageCode') ?? 'en';

    emit(SettingsState(isDarkMode, languageCode));
  }

  void toggleTheme() async {
    bool newTheme = !state.isDarkMode;
    emit(SettingsState(newTheme, state.languageCode));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', newTheme);
  }

  void changeLanguage(String languageCode) async {
    emit(SettingsState(state.isDarkMode, languageCode));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `E-Store`
  String get AppTitle {
    return Intl.message('E-Store', name: 'AppTitle', desc: '', args: []);
  }

  /// `Hello, {name}!`
  String Greeting(String name) {
    return Intl.message(
      'Hello, $name!',
      name: 'Greeting',
      desc: '',
      args: [name],
    );
  }

  /// `Dear Guest`
  String get GreetingGuest {
    return Intl.message(
      'Dear Guest',
      name: 'GreetingGuest',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy your shopping experience`
  String get WelcomeToEStore {
    return Intl.message(
      'Enjoy your shopping experience',
      name: 'WelcomeToEStore',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get Categories {
    return Intl.message('Categories', name: 'Categories', desc: '', args: []);
  }

  /// `New Arrivals`
  String get NewArrivals {
    return Intl.message(
      'New Arrivals',
      name: 'NewArrivals',
      desc: '',
      args: [],
    );
  }

  /// `Popular Products`
  String get PopularProducts {
    return Intl.message(
      'Popular Products',
      name: 'PopularProducts',
      desc: '',
      args: [],
    );
  }

  /// `Discount Products`
  String get DiscountProducts {
    return Intl.message(
      'Discount Products',
      name: 'DiscountProducts',
      desc: '',
      args: [],
    );
  }

  /// `Best Sellers`
  String get BestSellers {
    return Intl.message(
      'Best Sellers',
      name: 'BestSellers',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message('Home', name: 'Home', desc: '', args: []);
  }

  /// `Cart`
  String get Cart {
    return Intl.message('Cart', name: 'Cart', desc: '', args: []);
  }

  /// `Search`
  String get Search {
    return Intl.message('Search', name: 'Search', desc: '', args: []);
  }

  /// `Explore`
  String get Explore {
    return Intl.message('Explore', name: 'Explore', desc: '', args: []);
  }

  /// `Orders`
  String get Orders {
    return Intl.message('Orders', name: 'Orders', desc: '', args: []);
  }

  /// `Profile`
  String get Profile {
    return Intl.message('Profile', name: 'Profile', desc: '', args: []);
  }

  /// `Settings`
  String get Settings {
    return Intl.message('Settings', name: 'Settings', desc: '', args: []);
  }

  /// `Logout`
  String get Logout {
    return Intl.message('Logout', name: 'Logout', desc: '', args: []);
  }

  /// `Menu`
  String get Menu {
    return Intl.message('Menu', name: 'Menu', desc: '', args: []);
  }

  /// `App Settings`
  String get AppSettings {
    return Intl.message(
      'App Settings',
      name: 'AppSettings',
      desc: '',
      args: [],
    );
  }

  /// `App Theme`
  String get AppTheme {
    return Intl.message('App Theme', name: 'AppTheme', desc: '', args: []);
  }

  /// `Enable Dark Mode`
  String get EnableDarkMode {
    return Intl.message(
      'Enable Dark Mode',
      name: 'EnableDarkMode',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get SelectLanguage {
    return Intl.message(
      'Select Language',
      name: 'SelectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get Arabic {
    return Intl.message('Arabic', name: 'Arabic', desc: '', args: []);
  }

  /// `English`
  String get English {
    return Intl.message('English', name: 'English', desc: '', args: []);
  }

  /// `View Products`
  String get ViewProducts {
    return Intl.message(
      'View Products',
      name: 'ViewProducts',
      desc: '',
      args: [],
    );
  }

  /// `Specs`
  String get Specs {
    return Intl.message('Specs', name: 'Specs', desc: '', args: []);
  }

  /// `Description`
  String get Description {
    return Intl.message('Description', name: 'Description', desc: '', args: []);
  }

  /// `Add To Cart`
  String get AddToCart {
    return Intl.message('Add To Cart', name: 'AddToCart', desc: '', args: []);
  }

  /// `LYD`
  String get LYD {
    return Intl.message('LYD', name: 'LYD', desc: '', args: []);
  }

  /// `Please Complate Your Profile`
  String get PleaseComplateYourProfile {
    return Intl.message(
      'Please Complate Your Profile',
      name: 'PleaseComplateYourProfile',
      desc: '',
      args: [],
    );
  }

  /// `To benefit from our services, please complete your profile.`
  String get PleaseComplateYourProfileMsg {
    return Intl.message(
      'To benefit from our services, please complete your profile.',
      name: 'PleaseComplateYourProfileMsg',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get Later {
    return Intl.message('Later', name: 'Later', desc: '', args: []);
  }

  /// `Go Now`
  String get GoNow {
    return Intl.message('Go Now', name: 'GoNow', desc: '', args: []);
  }

  /// `First Name`
  String get FirstName {
    return Intl.message('First Name', name: 'FirstName', desc: '', args: []);
  }

  /// `Last Name`
  String get LastName {
    return Intl.message('Last Name', name: 'LastName', desc: '', args: []);
  }

  /// `Phone Number`
  String get PhoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'PhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message('Password', name: 'Password', desc: '', args: []);
  }

  /// `Password Confirmation`
  String get PasswordConfirmation {
    return Intl.message(
      'Password Confirmation',
      name: 'PasswordConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get Registration {
    return Intl.message(
      'Registration',
      name: 'Registration',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get Register {
    return Intl.message('Register', name: 'Register', desc: '', args: []);
  }

  /// `Please enter your First Name`
  String get ValidateFirstNameMsg {
    return Intl.message(
      'Please enter your First Name',
      name: 'ValidateFirstNameMsg',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your Last Name`
  String get ValidateLastNameMsg {
    return Intl.message(
      'Please enter your Last Name',
      name: 'ValidateLastNameMsg',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your Phone Number`
  String get ValidatePhoneMsg {
    return Intl.message(
      'Please enter your Phone Number',
      name: 'ValidatePhoneMsg',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your Password`
  String get ValidatePasswordMsg {
    return Intl.message(
      'Please enter your Password',
      name: 'ValidatePasswordMsg',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters long`
  String get ValidatePasswordWeaknessMsg {
    return Intl.message(
      'Password must be at least 6 characters long',
      name: 'ValidatePasswordWeaknessMsg',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your Password Confirmation`
  String get ValidatePasswordConfirmationMsg {
    return Intl.message(
      'Please enter your Password Confirmation',
      name: 'ValidatePasswordConfirmationMsg',
      desc: '',
      args: [],
    );
  }

  /// `Passwords didn't match`
  String get ValidatePasswordConfirmationMatchingMsg {
    return Intl.message(
      'Passwords didn\'t match',
      name: 'ValidatePasswordConfirmationMatchingMsg',
      desc: '',
      args: [],
    );
  }

  /// `You already have an acount`
  String get YouAlreadyHaveAnAcount {
    return Intl.message(
      'You already have an acount',
      name: 'YouAlreadyHaveAnAcount',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get Login {
    return Intl.message('Login', name: 'Login', desc: '', args: []);
  }

  /// `Continue without signup`
  String get ContinueWithoutSignup {
    return Intl.message(
      'Continue without signup',
      name: 'ContinueWithoutSignup',
      desc: '',
      args: [],
    );
  }

  /// `You don't have an account?`
  String get YouDontHaveAnAccount {
    return Intl.message(
      'You don\'t have an account?',
      name: 'YouDontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `SignUp`
  String get SignUp {
    return Intl.message('SignUp', name: 'SignUp', desc: '', args: []);
  }

  /// `Continue without login`
  String get ContinueWithoutLogin {
    return Intl.message(
      'Continue without login',
      name: 'ContinueWithoutLogin',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get Account {
    return Intl.message('Account', name: 'Account', desc: '', args: []);
  }

  /// `Personal Information`
  String get PersonalInformation {
    return Intl.message(
      'Personal Information',
      name: 'PersonalInformation',
      desc: '',
      args: [],
    );
  }

  /// `My Addresses`
  String get MyAddresses {
    return Intl.message(
      'My Addresses',
      name: 'MyAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Access And Security`
  String get AccessAndSecurity {
    return Intl.message(
      'Access And Security',
      name: 'AccessAndSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Language And Display Settings`
  String get LanguageAndDisplaySettings {
    return Intl.message(
      'Language And Display Settings',
      name: 'LanguageAndDisplaySettings',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get AboutUs {
    return Intl.message('About Us', name: 'AboutUs', desc: '', args: []);
  }

  /// `Terms And Conditions`
  String get TermsAndConditions {
    return Intl.message(
      'Terms And Conditions',
      name: 'TermsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `About The App`
  String get AboutTheApp {
    return Intl.message(
      'About The App',
      name: 'AboutTheApp',
      desc: '',
      args: [],
    );
  }

  /// `Rate Us`
  String get RateUs {
    return Intl.message('Rate Us', name: 'RateUs', desc: '', args: []);
  }

  /// `Email`
  String get Email {
    return Intl.message('Email', name: 'Email', desc: '', args: []);
  }

  /// `Please enter your Email`
  String get ValidateEmailMsg {
    return Intl.message(
      'Please enter your Email',
      name: 'ValidateEmailMsg',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get Save {
    return Intl.message('Save', name: 'Save', desc: '', args: []);
  }

  /// `Old Password`
  String get OldPassword {
    return Intl.message(
      'Old Password',
      name: 'OldPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get NewPassword {
    return Intl.message(
      'New Password',
      name: 'NewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get DeleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'DeleteAccount',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

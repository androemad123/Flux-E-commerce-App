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
    final name = (locale.countryCode?.isEmpty ?? false)
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

  /// `this is english version`
  String get title {
    return Intl.message(
      'this is english version',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `write your email here `
  String get email {
    return Intl.message(
      'write your email here ',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `value`
  String get key {
    return Intl.message('value', name: 'key', desc: '', args: []);
  }

  /// `My Orders`
  String get myOrdersTitle {
    return Intl.message('My Orders', name: 'myOrdersTitle', desc: '', args: []);
  }

  /// `No {status} orders`
  String noOrders(Object status) {
    return Intl.message(
      'No $status orders',
      name: 'noOrders',
      desc: '',
      args: [status],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Delivered`
  String get delivered {
    return Intl.message('Delivered', name: 'delivered', desc: '', args: []);
  }

  /// `Cancelled`
  String get cancelled {
    return Intl.message('Cancelled', name: 'cancelled', desc: '', args: []);
  }

  /// `Details`
  String get details {
    return Intl.message('Details', name: 'details', desc: '', args: []);
  }

  /// `Tracking number`
  String get trackingNumber {
    return Intl.message(
      'Tracking number',
      name: 'trackingNumber',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message('Quantity', name: 'quantity', desc: '', args: []);
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message('Subtotal', name: 'subtotal', desc: '', args: []);
  }

  /// `Your order is`
  String get yourOrderIs {
    return Intl.message(
      'Your order is',
      name: 'yourOrderIs',
      desc: '',
      args: [],
    );
  }

  /// `Order number`
  String get orderNumber {
    return Intl.message(
      'Order number',
      name: 'orderNumber',
      desc: '',
      args: [],
    );
  }

  /// `Delivery address`
  String get deliveryAddress {
    return Intl.message(
      'Delivery address',
      name: 'deliveryAddress',
      desc: '',
      args: [],
    );
  }

  /// `Shipping`
  String get shipping {
    return Intl.message('Shipping', name: 'shipping', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Return home`
  String get returnHome {
    return Intl.message('Return home', name: 'returnHome', desc: '', args: []);
  }

  /// `Rate`
  String get rate {
    return Intl.message('Rate', name: 'rate', desc: '', args: []);
  }

  /// `Continue shopping`
  String get continueShopping {
    return Intl.message(
      'Continue shopping',
      name: 'continueShopping',
      desc: '',
      args: [],
    );
  }

  /// `Rate Product`
  String get rateProductTitle {
    return Intl.message(
      'Rate Product',
      name: 'rateProductTitle',
      desc: '',
      args: [],
    );
  }

  /// `Submit your review to get 5 points`
  String get submitReviewInfo {
    return Intl.message(
      'Submit your review to get 5 points',
      name: 'submitReviewInfo',
      desc: '',
      args: [],
    );
  }

  /// `Tap stars to rate`
  String get ratingHint {
    return Intl.message(
      'Tap stars to rate',
      name: 'ratingHint',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to write anything about this product?`
  String get reviewFieldHint {
    return Intl.message(
      'Would you like to write anything about this product?',
      name: 'reviewFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Image`
  String get uploadImage {
    return Intl.message('Image', name: 'uploadImage', desc: '', args: []);
  }

  /// `Camera`
  String get uploadCamera {
    return Intl.message('Camera', name: 'uploadCamera', desc: '', args: []);
  }

  /// `Submit Review`
  String get submitReview {
    return Intl.message(
      'Submit Review',
      name: 'submitReview',
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

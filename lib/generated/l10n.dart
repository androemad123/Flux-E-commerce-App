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

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
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

  /// `Total:`
  String get total {
    return Intl.message('Total:', name: 'total', desc: '', args: []);
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

  /// `GemStore`
  String get appName {
    return Intl.message('GemStore', name: 'appName', desc: '', args: []);
  }

  /// `Name of user`
  String get nameOfUser {
    return Intl.message('Name of user', name: 'nameOfUser', desc: '', args: []);
  }

  /// `his email`
  String get hisEmail {
    return Intl.message('his email', name: 'hisEmail', desc: '', args: []);
  }

  /// `User`
  String get user {
    return Intl.message('User', name: 'user', desc: '', args: []);
  }

  /// `No email`
  String get noEmail {
    return Intl.message('No email', name: 'noEmail', desc: '', args: []);
  }

  /// `Shop Together`
  String get shopTogether {
    return Intl.message(
      'Shop Together',
      name: 'shopTogether',
      desc: '',
      args: [],
    );
  }

  /// `Discover`
  String get discover {
    return Intl.message('Discover', name: 'discover', desc: '', args: []);
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message('My Profile', name: 'myProfile', desc: '', args: []);
  }

  /// `OTHER`
  String get other {
    return Intl.message('OTHER', name: 'other', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Support`
  String get support {
    return Intl.message('Support', name: 'support', desc: '', args: []);
  }

  /// `About us`
  String get aboutUs {
    return Intl.message('About us', name: 'aboutUs', desc: '', args: []);
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Voucher`
  String get voucher {
    return Intl.message('Voucher', name: 'voucher', desc: '', args: []);
  }

  /// `My Wishlist`
  String get myWishlist {
    return Intl.message('My Wishlist', name: 'myWishlist', desc: '', args: []);
  }

  /// `Rate this app`
  String get rateThisApp {
    return Intl.message(
      'Rate this app',
      name: 'rateThisApp',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logOut {
    return Intl.message('Log out', name: 'logOut', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Are you sure you want to logout?`
  String get areYouSureYouWantToLogout {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'areYouSureYouWantToLogout',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Error logging out: {error}`
  String errorLoggingOut(Object error) {
    return Intl.message(
      'Error logging out: $error',
      name: 'errorLoggingOut',
      desc: '',
      args: [error],
    );
  }

  /// `Error logging out: {error}`
  String errorLoggingOutPlaceholder(Object error) {
    return Intl.message(
      'Error logging out: $error',
      name: 'errorLoggingOutPlaceholder',
      desc: '',
      args: [error],
    );
  }

  /// `Shared cart created successfully!`
  String get sharedCartCreatedSuccessfully {
    return Intl.message(
      'Shared cart created successfully!',
      name: 'sharedCartCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `No shared carts yet`
  String get noSharedCartsYet {
    return Intl.message(
      'No shared carts yet',
      name: 'noSharedCartsYet',
      desc: '',
      args: [],
    );
  }

  /// `Create one to start shopping together!`
  String get createOneToStartShoppingTogether {
    return Intl.message(
      'Create one to start shopping together!',
      name: 'createOneToStartShoppingTogether',
      desc: '',
      args: [],
    );
  }

  /// `Owner`
  String get owner {
    return Intl.message('Owner', name: 'owner', desc: '', args: []);
  }

  /// `Collaborator`
  String get collaborator {
    return Intl.message(
      'Collaborator',
      name: 'collaborator',
      desc: '',
      args: [],
    );
  }

  /// `No Shared Carts`
  String get noSharedCarts {
    return Intl.message(
      'No Shared Carts',
      name: 'noSharedCarts',
      desc: '',
      args: [],
    );
  }

  /// `You need to create or join a shared cart first. Go to Shop Together to create one.`
  String get youNeedToCreateOrJoinSharedCart {
    return Intl.message(
      'You need to create or join a shared cart first. Go to Shop Together to create one.',
      name: 'youNeedToCreateOrJoinSharedCart',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Select Shared Cart`
  String get selectSharedCart {
    return Intl.message(
      'Select Shared Cart',
      name: 'selectSharedCart',
      desc: '',
      args: [],
    );
  }

  /// `added to`
  String get addedTo {
    return Intl.message('added to', name: 'addedTo', desc: '', args: []);
  }

  /// `Add to Cart`
  String get addToCart {
    return Intl.message('Add to Cart', name: 'addToCart', desc: '', args: []);
  }

  /// `View Cart`
  String get viewCart {
    return Intl.message('View Cart', name: 'viewCart', desc: '', args: []);
  }

  /// `No items in this cart yet`
  String get noItemsInThisCartYet {
    return Intl.message(
      'No items in this cart yet',
      name: 'noItemsInThisCartYet',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Added by:`
  String get addedBy {
    return Intl.message('Added by:', name: 'addedBy', desc: '', args: []);
  }

  /// `Proceed to checkout`
  String get proceedToCheckout {
    return Intl.message(
      'Proceed to checkout',
      name: 'proceedToCheckout',
      desc: '',
      args: [],
    );
  }

  /// `Create Shared Cart`
  String get createSharedCart {
    return Intl.message(
      'Create Shared Cart',
      name: 'createSharedCart',
      desc: '',
      args: [],
    );
  }

  /// `Enter cart name`
  String get enterCartName {
    return Intl.message(
      'Enter cart name',
      name: 'enterCartName',
      desc: '',
      args: [],
    );
  }

  /// `Cart Name`
  String get cartName {
    return Intl.message('Cart Name', name: 'cartName', desc: '', args: []);
  }

  /// `Invite people by email:`
  String get invitePeopleByEmail {
    return Intl.message(
      'Invite people by email:',
      name: 'invitePeopleByEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter email`
  String get enterEmail {
    return Intl.message('Enter email', name: 'enterEmail', desc: '', args: []);
  }

  /// `Create`
  String get create {
    return Intl.message('Create', name: 'create', desc: '', args: []);
  }

  /// `Featured Products`
  String get featuredProducts {
    return Intl.message(
      'Featured Products',
      name: 'featuredProducts',
      desc: '',
      args: [],
    );
  }

  /// `Show all`
  String get showAll {
    return Intl.message('Show all', name: 'showAll', desc: '', args: []);
  }

  /// `No featured products found`
  String get noFeaturedProductsFound {
    return Intl.message(
      'No featured products found',
      name: 'noFeaturedProductsFound',
      desc: '',
      args: [],
    );
  }

  /// `Product Not Found`
  String get productNotFound {
    return Intl.message(
      'Product Not Found',
      name: 'productNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Loading product...`
  String get loadingProduct {
    return Intl.message(
      'Loading product...',
      name: 'loadingProduct',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your feedback!`
  String get thankYouForYourFeedback {
    return Intl.message(
      'Thank you for your feedback!',
      name: 'thankYouForYourFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Submitting...`
  String get submitting {
    return Intl.message(
      'Submitting...',
      name: 'submitting',
      desc: '',
      args: [],
    );
  }

  /// `Your Cart`
  String get yourCart {
    return Intl.message('Your Cart', name: 'yourCart', desc: '', args: []);
  }

  /// `Your cart is empty`
  String get yourCartIsEmpty {
    return Intl.message(
      'Your cart is empty',
      name: 'yourCartIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Login failed. Please try again.`
  String get loginFailed {
    return Intl.message(
      'Login failed. Please try again.',
      name: 'loginFailed',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get userName {
    return Intl.message('User Name', name: 'userName', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get pleaseConfirmYourPassword {
    return Intl.message(
      'Please confirm your password',
      name: 'pleaseConfirmYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Registration failed. Please try again.`
  String get registrationFailed {
    return Intl.message(
      'Registration failed. Please try again.',
      name: 'registrationFailed',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Flux Store`
  String get welcomeToFluxStore {
    return Intl.message(
      'Welcome to Flux Store',
      name: 'welcomeToFluxStore',
      desc: '',
      args: [],
    );
  }

  /// `The home for a fashionista`
  String get theHomeForAFashionista {
    return Intl.message(
      'The home for a fashionista',
      name: 'theHomeForAFashionista',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Shopping Now`
  String get shoppingNow {
    return Intl.message(
      'Shopping Now',
      name: 'shoppingNow',
      desc: '',
      args: [],
    );
  }

  /// `Check Out`
  String get checkOut {
    return Intl.message('Check Out', name: 'checkOut', desc: '', args: []);
  }

  /// `Your cart is empty.`
  String get yourCartIsEmptyFull {
    return Intl.message(
      'Your cart is empty.',
      name: 'yourCartIsEmptyFull',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Clothing`
  String get clothing {
    return Intl.message('Clothing', name: 'clothing', desc: '', args: []);
  }

  /// `Accessories`
  String get accessories {
    return Intl.message('Accessories', name: 'accessories', desc: '', args: []);
  }

  /// `Shoes`
  String get shoes {
    return Intl.message('Shoes', name: 'shoes', desc: '', args: []);
  }

  /// `Collection`
  String get collection {
    return Intl.message('Collection', name: 'collection', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `No notifications`
  String get noNotifications {
    return Intl.message(
      'No notifications',
      name: 'noNotifications',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get noData {
    return Intl.message('No data', name: 'noData', desc: '', args: []);
  }

  /// `invited you to join`
  String get invitedYouToJoin {
    return Intl.message(
      'invited you to join',
      name: 'invitedYouToJoin',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message('Accept', name: 'accept', desc: '', args: []);
  }

  /// `Decline`
  String get decline {
    return Intl.message('Decline', name: 'decline', desc: '', args: []);
  }

  /// `Invitation accepted!`
  String get invitationAccepted {
    return Intl.message(
      'Invitation accepted!',
      name: 'invitationAccepted',
      desc: '',
      args: [],
    );
  }

  /// `Invitation declined`
  String get invitationDeclined {
    return Intl.message(
      'Invitation declined',
      name: 'invitationDeclined',
      desc: '',
      args: [],
    );
  }

  /// `ago`
  String get ago {
    return Intl.message('ago', name: 'ago', desc: '', args: []);
  }

  /// `d`
  String get d {
    return Intl.message('d', name: 'd', desc: '', args: []);
  }

  /// `h`
  String get h {
    return Intl.message('h', name: 'h', desc: '', args: []);
  }

  /// `m`
  String get m {
    return Intl.message('m', name: 'm', desc: '', args: []);
  }

  /// `Just now`
  String get justNow {
    return Intl.message('Just now', name: 'justNow', desc: '', args: []);
  }

  /// `Invitation updated`
  String get invitationUpdated {
    return Intl.message(
      'Invitation updated',
      name: 'invitationUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get selected {
    return Intl.message('Selected', name: 'selected', desc: '', args: []);
  }

  /// `Shared Cart`
  String get sharedCart {
    return Intl.message('Shared Cart', name: 'sharedCart', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `No valid products to checkout`
  String get noValidProductsToCheckout {
    return Intl.message(
      'No valid products to checkout',
      name: 'noValidProductsToCheckout',
      desc: '',
      args: [],
    );
  }

  /// `Processing`
  String get processing {
    return Intl.message('Processing', name: 'processing', desc: '', args: []);
  }

  /// `Shipped`
  String get shipped {
    return Intl.message('Shipped', name: 'shipped', desc: '', args: []);
  }

  /// `Reject`
  String get reject {
    return Intl.message('Reject', name: 'reject', desc: '', args: []);
  }

  /// `Cart shared with you`
  String get cartSharedWithYou {
    return Intl.message(
      'Cart shared with you',
      name: 'cartSharedWithYou',
      desc: '',
      args: [],
    );
  }

  /// `New invitation`
  String get newInvitation {
    return Intl.message(
      'New invitation',
      name: 'newInvitation',
      desc: '',
      args: [],
    );
  }

  /// `sent you an invitation.`
  String get sentYouAnInvitation {
    return Intl.message(
      'sent you an invitation.',
      name: 'sentYouAnInvitation',
      desc: '',
      args: [],
    );
  }

  /// `Error:`
  String get error {
    return Intl.message('Error:', name: 'error', desc: '', args: []);
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Delete Item`
  String get deleteItem {
    return Intl.message('Delete Item', name: 'deleteItem', desc: '', args: []);
  }

  /// `Are you sure you want to remove this item from the cart?`
  String get areYouSureYouWantToRemoveItem {
    return Intl.message(
      'Are you sure you want to remove this item from the cart?',
      name: 'areYouSureYouWantToRemoveItem',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `Delete Cart`
  String get deleteCart {
    return Intl.message('Delete Cart', name: 'deleteCart', desc: '', args: []);
  }

  /// `Leave Cart`
  String get leaveCart {
    return Intl.message('Leave Cart', name: 'leaveCart', desc: '', args: []);
  }

  /// `Are you sure you want to delete this cart? This action cannot be undone.`
  String get areYouSureYouWantToDeleteCart {
    return Intl.message(
      'Are you sure you want to delete this cart? This action cannot be undone.',
      name: 'areYouSureYouWantToDeleteCart',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to leave this cart?`
  String get areYouSureYouWantToLeaveCart {
    return Intl.message(
      'Are you sure you want to leave this cart?',
      name: 'areYouSureYouWantToLeaveCart',
      desc: '',
      args: [],
    );
  }

  /// `Cart deleted successfully`
  String get cartDeleted {
    return Intl.message(
      'Cart deleted successfully',
      name: 'cartDeleted',
      desc: '',
      args: [],
    );
  }

  /// `You have left the cart`
  String get cartLeft {
    return Intl.message(
      'You have left the cart',
      name: 'cartLeft',
      desc: '',
      args: [],
    );
  }

  /// `Error deleting cart`
  String get errorDeletingCart {
    return Intl.message(
      'Error deleting cart',
      name: 'errorDeletingCart',
      desc: '',
      args: [],
    );
  }

  /// `Error leaving cart`
  String get errorLeavingCart {
    return Intl.message(
      'Error leaving cart',
      name: 'errorLeavingCart',
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

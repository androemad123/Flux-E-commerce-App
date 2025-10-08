// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(status) => "No ${status} orders";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "cancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
    "continueShopping": MessageLookupByLibrary.simpleMessage(
      "Continue shopping",
    ),
    "delivered": MessageLookupByLibrary.simpleMessage("Delivered"),
    "deliveryAddress": MessageLookupByLibrary.simpleMessage("Delivery address"),
    "details": MessageLookupByLibrary.simpleMessage("Details"),
    "email": MessageLookupByLibrary.simpleMessage("write your email here "),
    "key": MessageLookupByLibrary.simpleMessage("value"),
    "myOrdersTitle": MessageLookupByLibrary.simpleMessage("My Orders"),
    "noOrders": m0,
    "orderNumber": MessageLookupByLibrary.simpleMessage("Order number"),
    "pending": MessageLookupByLibrary.simpleMessage("Pending"),
    "quantity": MessageLookupByLibrary.simpleMessage("Quantity"),
    "rate": MessageLookupByLibrary.simpleMessage("Rate"),
    "rateProductTitle": MessageLookupByLibrary.simpleMessage("Rate Product"),
    "ratingHint": MessageLookupByLibrary.simpleMessage("Tap stars to rate"),
    "returnHome": MessageLookupByLibrary.simpleMessage("Return home"),
    "reviewFieldHint": MessageLookupByLibrary.simpleMessage(
      "Would you like to write anything about this product?",
    ),
    "shipping": MessageLookupByLibrary.simpleMessage("Shipping"),
    "submitReview": MessageLookupByLibrary.simpleMessage("Submit Review"),
    "submitReviewInfo": MessageLookupByLibrary.simpleMessage(
      "Submit your review to get 5 points",
    ),
    "subtotal": MessageLookupByLibrary.simpleMessage("Subtotal"),
    "title": MessageLookupByLibrary.simpleMessage("this is english version"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "trackingNumber": MessageLookupByLibrary.simpleMessage("Tracking number"),
    "uploadCamera": MessageLookupByLibrary.simpleMessage("Camera"),
    "uploadImage": MessageLookupByLibrary.simpleMessage("Image"),
    "yourOrderIs": MessageLookupByLibrary.simpleMessage("Your order is"),
  };
}

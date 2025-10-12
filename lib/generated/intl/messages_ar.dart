// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(status) => "لا توجد طلبات ${status}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "cancelled": MessageLookupByLibrary.simpleMessage("أُلغيت"),
    "continueShopping": MessageLookupByLibrary.simpleMessage("اكمل التسوق"),
    "delivered": MessageLookupByLibrary.simpleMessage("تم التوصيل"),
    "deliveryAddress": MessageLookupByLibrary.simpleMessage("عنوان التوصيل"),
    "details": MessageLookupByLibrary.simpleMessage("التفاصيل"),
    "email": MessageLookupByLibrary.simpleMessage("اكتب بريدك الإلكتروني هنا"),
    "key": MessageLookupByLibrary.simpleMessage("قيمة"),
    "myOrdersTitle": MessageLookupByLibrary.simpleMessage("طلباتي"),
    "noOrders": m0,
    "orderNumber": MessageLookupByLibrary.simpleMessage("رقم الطلب"),
    "pending": MessageLookupByLibrary.simpleMessage("قيد الانتظار"),
    "quantity": MessageLookupByLibrary.simpleMessage("الكمية"),
    "rate": MessageLookupByLibrary.simpleMessage("تقييم"),
    "rateProductTitle": MessageLookupByLibrary.simpleMessage("تقييم المنتج"),
    "ratingHint": MessageLookupByLibrary.simpleMessage(
      "اضغط على النجوم للتقييم",
    ),
    "returnHome": MessageLookupByLibrary.simpleMessage("العودة للرئيسية"),
    "reviewFieldHint": MessageLookupByLibrary.simpleMessage(
      "هل تود كتابة شيء عن هذا المنتج؟",
    ),
    "shipping": MessageLookupByLibrary.simpleMessage("الشحن"),
    "submitReview": MessageLookupByLibrary.simpleMessage("إرسال التقييم"),
    "submitReviewInfo": MessageLookupByLibrary.simpleMessage(
      "قم بتقديم مراجعتك لتحصل على 5 نقاط",
    ),
    "subtotal": MessageLookupByLibrary.simpleMessage("المجموع"),
    "title": MessageLookupByLibrary.simpleMessage("هذا هو الإصدار العربي"),
    "total": MessageLookupByLibrary.simpleMessage("الإجمالي"),
    "trackingNumber": MessageLookupByLibrary.simpleMessage("رقم التتبع"),
    "uploadCamera": MessageLookupByLibrary.simpleMessage("الكاميرا"),
    "uploadImage": MessageLookupByLibrary.simpleMessage("صورة"),
    "yourOrderIs": MessageLookupByLibrary.simpleMessage("طلبك"),
  };
}

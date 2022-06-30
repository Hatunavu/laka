import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

extension DateFormatting on DateTime {
  String tohhmmddMMyyyy() {
    final f = DateFormat('HH:mm dd/MM/yyyy');
    return f.format(this);
  }

  String humanity() {
    return timeago.format(this, locale: 'vi');
  }
}

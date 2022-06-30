import 'package:flutter/widgets.dart';

/// {@template custom_rect_tween}
/// Linear RectTween with a [Curves.easeOut] curve.
///
/// Less dramatic that the regular [RectTween] used in [Hero] animations.
/// {@endtemplate}
class CustomRectTween extends RectTween {
  /// {@macro custom_rect_tween}
  CustomRectTween({
    required Rect begin,
    required Rect end,
  }) : super(begin: begin, end: end);
  final double a = 10.0;
  @override
  Rect lerp(double t) {
    final elasticCurveValue = Curves.easeOut.transform(t);
    return Rect.fromLTRB(
      begin!.left * (1.0 - t) + end!.left * elasticCurveValue,
      begin!.top * (1.0 - t) + end!.top * elasticCurveValue,
      begin!.right * (1.0 - t) + end!.right * elasticCurveValue,
      begin!.bottom * (1.0 - t) + end!.bottom * elasticCurveValue,
    );
    // lerpDouble(begin!.left, end!.left, elasticCurveValue),
    // lerpDouble(begin!.top, end!.top, elasticCurveValue),
    // lerpDouble(begin!.right, end!.right, elasticCurveValue),
    // lerpDouble(begin!.bottom, end!.bottom, elasticCurveValue));
  }
}

// double? lerpDouble(num? a, num? b, double? t) {
//   if (a == b || (a?.isNaN == true) && (b?.isNaN == true)) return a?.toDouble();
//   a ??= 0.0;
//   b ??= 0.0;
//   assert(a.isFinite, 'Cannot interpolate between finite and non-finite values');
//   assert(b.isFinite, 'Cannot interpolate between finite and non-finite values');
//   assert(t!.isFinite, 't must be finite when interpolating between values');
//   return a * (1.0 - t!) + b * t;
// }

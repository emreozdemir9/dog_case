import 'package:flutter/material.dart';

class Utils {
  static int updateTextLineCountForSearchHeight(BuildContext context, text) {
    final span = TextSpan(text: text);
    final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout(
        maxWidth: MediaQuery.of(context).size.width *
            0.7);
    return tp.computeLineMetrics().length;
  }
}
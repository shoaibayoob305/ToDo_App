import 'package:flutter/material.dart';

extension SizedBoxExtension on num {
  // Extension method for height
  SizedBox get sbh => SizedBox(height: this.toDouble());

  // Extension method for width
  SizedBox get sbw => SizedBox(width: this.toDouble());
}
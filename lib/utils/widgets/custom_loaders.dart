import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ELoadingWidget extends StatelessWidget {
  const ELoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

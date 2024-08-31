import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return const NutsActivityIndicator(
      radius: 20,
      activeColor: Colors.yellow,
      inactiveColor: Colors.white,
      animationDuration: Duration(milliseconds: 300),
    );
  }
}

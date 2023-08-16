import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BarbershopLoader extends StatefulWidget {
  const BarbershopLoader({super.key});

  @override
  State<BarbershopLoader> createState() => _BarbershopLoaderState();
}

class _BarbershopLoaderState extends State<BarbershopLoader> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
          color: Colors.brown, size: 60),
    );
  }
}

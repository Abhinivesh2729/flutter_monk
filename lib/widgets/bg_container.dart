import 'package:flutter/material.dart';

class BgContainer extends StatelessWidget {
  final Widget? child;
  const BgContainer({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}

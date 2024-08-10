//Internal Packages
import 'package:flutter/material.dart';

class AppbarTitle extends StatelessWidget {
  const AppbarTitle({
    required this.title,
    super.key
  });

  final String title;

  @override
  Widget build(context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        const Spacer(),
        Image.asset(
          'assets/images/cpLogo.png',
          fit: BoxFit.cover,
          height: 80,
          width: 80,
        ),
      ],
    ); 
  }
}
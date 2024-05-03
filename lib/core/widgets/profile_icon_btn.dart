import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';

class ProfileIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(Routes.profile);
      },
      icon: Icon(Icons.person),
    );
  }
}

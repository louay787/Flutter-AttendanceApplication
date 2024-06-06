import 'package:flutter/material.dart';

class MyDrawerTile extends StatelessWidget {
  final String text;
  final IconData? icon;
  final void Function()? onTap;

  const MyDrawerTile({super.key, required this.text, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.white, // Change the color here
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: ListTile(
          title: Text(
            text,
            style: TextStyle(color: Colors.white), // Change color here
          ),
          leading: Icon(
            icon,
            color: Colors.white, // Change color here
          ),
        ),
      ),
    );
  }
}

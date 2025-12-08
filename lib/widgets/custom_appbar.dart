import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar(
  String title, {
  List<IconButton>? actions, // optional list of icons
  Widget? leading,
}) {
  return AppBar(
    backgroundColor: const Color(0xFFE5E7EB),
    elevation: 0,
    //automaticallyImplyLeading: false,
    // leading: Container(), // removes default back button
    centerTitle: false,
    //  IconButton(
    //   icon: const Icon(Icons.arrow_back, color: Colors.black),
    //   onPressed: () {
    //     // Go back to previous screen
    //     Navigator.pop;
    //   },
    // ),
    leading: leading ?? SizedBox.shrink(),
    title: Text(
      title,
      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
    ),
    actions: actions, // can be null, one, or multiple
  );
}

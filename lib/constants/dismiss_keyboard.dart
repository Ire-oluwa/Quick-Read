import'package:flutter/material.dart';

Widget kUnfocus({child}) => GestureDetector(
  behavior: HitTestBehavior.translucent,
  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
  child: child,
);
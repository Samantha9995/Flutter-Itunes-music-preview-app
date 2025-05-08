import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Copyright (c) 2025 SADev. All rights reserved.

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const CustomText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.bodyMedium;

    return Text(
      text,
      style: style ?? defaultStyle,
    ).tr();
  }
}

import 'package:flutter/material.dart';

TextStyle bodyMedium(BuildContext context) => Theme.of(context)
    .textTheme
    .bodyMedium!
    .copyWith(color: Theme.of(context).primaryColor);

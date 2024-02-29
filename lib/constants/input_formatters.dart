import 'package:flutter/services.dart';



/// Text Inputs
const kTextInputAction = TextInputAction.next;
//FORMATTERS

final kNameFormatter = [
  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]'))
];
final kTextFormatter = [
  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9 ]')),
];
final kEmailFormatter = [
  FilteringTextInputFormatter.allow(
    RegExp('[a-zA-Z@0-9._]'),
  ),
];
final kNumberFormatter = [FilteringTextInputFormatter.digitsOnly];
final kPasswordFormatter = [
  FilteringTextInputFormatter.allow(
    RegExp(
      ('[a-zA-Z0-9_|#@!*?+%]'),
    ),
  ),
];

const kNameCapitalization = TextCapitalization.words;
const kEmailKeyboard = TextInputType.emailAddress;
const kNameKeyboard = TextInputType.text;
const kNumberKeyboard = TextInputType.number;

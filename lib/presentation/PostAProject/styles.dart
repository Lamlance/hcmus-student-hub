import 'package:flutter/material.dart';

class AppStyles {
  static Color activeRadioColor =
      Colors.blue; // Define the active color for the radio button

  static RadioListTile<T> customRadioTile<T>(
      T value, T groupValue, ValueChanged<T?> onChanged, String title) {
    return RadioListTile<T>(
      title: Text(title),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: activeRadioColor, // Use the active color
    );
  }

  static const TextStyle titleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Colors.black,
  );
  static const TextStyle normalTextStyle = TextStyle(
    fontSize: 15,
    color: Colors.black,
  );

  static const InputDecoration inputDecoration = InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'Write a title for your post',
    labelStyle: TextStyle(
        color: Colors.blue), // Change the color of the label // Add a hint text
    hintStyle:
        TextStyle(color: Colors.grey), // Change the color of the hint text
    filled: true, // Fill the text field with the fill color
    fillColor: Colors.white, // Change the fill color
    focusColor: Colors.blue, // Change the color when the text field is focused
    enabledBorder: OutlineInputBorder(
      // Change the border when the text field is enabled
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      // Change the border when the text field is focused
      borderSide: BorderSide(color: Colors.green, width: 2.0),
    ),
  );

  static final ButtonStyle elevatedButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.blue), // background color
    foregroundColor: MaterialStateProperty.all(Colors.white), // text color
  );

  static TextSpan bulletListStyle(String text, TextStyle textStyle) {
    return TextSpan(
      children: <TextSpan>[
        TextSpan(
            text: '\u2022 ', style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: text, style: textStyle),
      ],
    );
  }

  static const InputDecoration inputDecorationHeight = InputDecoration(
    border: OutlineInputBorder(),
    labelText: 'Write something for your post',
    labelStyle: TextStyle(
        color: Colors.blue), // Change the color of the label // Add a hint text
    hintStyle:
        TextStyle(color: Colors.grey), // Change the color of the hint text
    filled: true, // Fill the text field with the fill color
    fillColor: Colors.white, // Change the fill color
    focusColor: Colors.blue, // Change the color when the text field is focused
    enabledBorder: OutlineInputBorder(
      // Change the border when the text field is enabled
      borderSide: BorderSide(color: Colors.blue, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      // Change the border when the text field is focused
      borderSide: BorderSide(color: Colors.green, width: 2.0),
    ),
    isDense: true,
  );
}

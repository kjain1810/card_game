import 'package:flutter/material.dart';

inputBox(String text) => InputDecoration(
  labelText: text,
  fillColor: Colors.white10,
  filled: true,
  labelStyle: TextStyle(
    color: Colors.grey[500],
    backgroundColor: Colors.transparent
  ),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
);
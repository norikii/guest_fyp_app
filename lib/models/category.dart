import 'package:flutter/material.dart';

/// Defines a structure of a category object
class Category {
  @required final String id;
  @required final String title;
  final Color color;

  // constructor create immutable object
  const Category({this.id, this.title, this.color = Colors.orange});
}
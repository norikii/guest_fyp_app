import 'package:flutter/material.dart';
import 'package:guest_fyp_app/widgets/category_item.dart';

import '../dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(25),
        // setts the scrollable areas on the screen
        // for structuring a grid
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3/2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20
        ),
        children: DUMMY_CATEGORIES.map( (categoryData) {
          return CategoryItem(categoryData.id, categoryData.title, categoryData.color);
        }).toList(),
      );
  }
}

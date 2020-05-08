import 'package:flutter/material.dart';
import 'package:guest_fyp_app/screens/item_screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(this.id, this.title, this.color);

  // redirects to the item page
  void selectCategory(BuildContext ctx) {
    /// for using normal routes
//    Navigator.of(ctx).push(MaterialPageRoute(builder: (c) {
//      return ItemScreen(id, title);
//    }));

  /// for using named routes
    /// and passing id and title to the /item route
    Navigator.of(ctx).pushNamed('/item', arguments: {'id': id, 'title': title});

  }

  @override
  Widget build(BuildContext context) {
    // clickable container this is a gesture detector with a ripple effect
    return InkWell(
      // getting to the different page
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(title,
          style: Theme.of(context).textTheme.title,),
        // defining the styling of the category_tem widget
        decoration: BoxDecoration(
          //
            gradient: LinearGradient(
              colors: [color.withOpacity(0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15)
        ),
      ),
    );
  }
}

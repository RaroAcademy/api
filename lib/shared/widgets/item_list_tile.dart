import 'package:api/shared/models/post.dart';
import 'package:flutter/material.dart';

class ItemListTileWidget extends StatelessWidget {
  final String title;
  const ItemListTileWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
    );
  }
}

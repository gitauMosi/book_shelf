import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/utils/download_count_utils.dart';
import '../../../data/models/bookshelf.dart';

class BookShelfTile extends StatelessWidget {
  final Bookshelf shelf;
  const BookShelfTile({super.key, required this.shelf});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).cardColor,
          ),
          child: Center(child: Icon(Icons.shelves, size: 24)),
        ),
        title: Text(shelf.name),
        subtitle: Text('${shelf.bookCount} books'),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 2,
          children: [
            Icon(Icons.download_outlined, size: 14),
            Text(getBookDownloadCountText(shelf.downloadCount)),
          ],
        ),
        onTap: () {
          Navigator.of(
            context,
          ).pushNamed(AppRoutes.bookshelfView, arguments: shelf.id.toString());
        },
      ),
    );
  }
}

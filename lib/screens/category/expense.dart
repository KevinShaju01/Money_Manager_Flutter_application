import 'package:flutter/material.dart';
import 'package:money_manager/db/category/categorydb.dart';

import '../../models/category/categorymodel.dart';

class expense extends StatelessWidget {
  const expense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: categorydb().expense,
        builder: (BuildContext ctx, List<categorymodel> l, W) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final cat = l[index];
                return Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(cat.name),
                    trailing: IconButton(
                        onPressed: () {
                          categorydb.instance.delete(cat.id);
                        },
                        icon: const Icon(Icons.delete)),
                  ),
                );
              },
              separatorBuilder: (ctx, index) => const SizedBox(height: 10),
              itemCount: l.length);
        });
  }
}

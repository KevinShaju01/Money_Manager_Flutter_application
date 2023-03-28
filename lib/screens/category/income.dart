import 'package:flutter/material.dart';
import 'package:money_manager/db/category/categorydb.dart';

import '../../models/category/categorymodel.dart';

class income extends StatelessWidget {
  const income({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: categorydb().income,
        builder: (BuildContext context, List<categorymodel> l, w) {
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

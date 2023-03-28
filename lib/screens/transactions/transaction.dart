import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db/transaction/transactiondb.dart';

import '../../models/transactions/transactionmodel.dart';

class transactionscreen extends StatelessWidget {
  const transactionscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ValueListenableBuilder(
            valueListenable: transactiondb.instance.trans,
            builder: (BuildContext ctx, List<transactionmodel> l, W) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    final cat = l[index];
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Slidable(
                        key: Key(cat.id),
                        startActionPane:
                            ActionPane(motion: ScrollMotion(), children: [
                          SlidableAction(
                            onPressed: (ctx) {
                              transactiondb.instance.delete(cat.id);
                              transactiondb.instance.RefreshTransUI();
                            },
                            icon: Icons.delete,
                          )
                        ]),
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 60,
                              child: Text(
                                P(cat.date),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            title: Text("Rs ${cat.amount}"),
                            subtitle: Text(cat.category),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 0,
                      ),
                  itemCount: l.length);
            }));
  }

  String P(DateTime t) {
    final str = DateFormat.Md().format(t);
    return (str);
  }
}

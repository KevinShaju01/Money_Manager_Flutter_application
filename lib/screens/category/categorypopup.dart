import 'package:flutter/material.dart';
import 'package:money_manager/db/category/categorydb.dart';
import 'package:money_manager/models/category/categorymodel.dart';

final text = TextEditingController();
Future<void> categorypopup(BuildContext context) async {
  showDialog(
      context: context,
      builder: (ctx1) {
        return SimpleDialog(
          title: const Text("Add Category"),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Category"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                RadioButton(title: "Income", type: categorytype.income),
                RadioButton(title: "Expense", type: categorytype.expense),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 35, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        final name = text.text;
                        final type = pop.value;
                        final cat = categorymodel(
                            id: DateTime.now()
                                .microsecondsSinceEpoch
                                .toString(),
                            name: name,
                            type: type);
                        categorydb().insert(cat);
                        Navigator.of(ctx1).pop();
                        text.clear();
                      },
                      icon: const Icon(
                        Icons.arrow_circle_right,
                        size: 35,
                      )),
                ],
              ),
            )
          ],
        );
      });
}

ValueNotifier<categorytype> pop = ValueNotifier(categorytype.income);

class RadioButton extends StatelessWidget {
  final String title;
  final categorytype type;

  const RadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: pop,
            builder: (ctx, categorytype update, w) {
              return Radio<categorytype>(
                  value: type,
                  groupValue: update,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    pop.value = value;
                    pop.notifyListeners();
                  });
            }),
        Text(title)
      ],
    );
  }
}

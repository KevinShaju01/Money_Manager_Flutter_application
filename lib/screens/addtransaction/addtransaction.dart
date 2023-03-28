import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:money_manager/db/category/categorydb.dart';
import 'package:money_manager/db/transaction/transactiondb.dart';
import 'package:money_manager/models/category/categorymodel.dart';
import 'package:money_manager/models/transactions/transactionmodel.dart';
import 'package:money_manager/screens/category/categorypopup.dart';

class addtransaction extends StatefulWidget {
  const addtransaction({Key? key}) : super(key: key);

  @override
  State<addtransaction> createState() => _addtransactionState();
}

class _addtransactionState extends State<addtransaction> {
  DateTime? selectdate;
  categorytype? selected;
  String? id;
  categorymodel? c;
  TextEditingController purpose = TextEditingController();
  TextEditingController amount = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    categorydb.instance.RefreshUI();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            TextFormField(
                controller: purpose,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    hintText: "Purpose", border: OutlineInputBorder())),
            const SizedBox(height: 20),
            TextFormField(
              controller: amount,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Amount"),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton.icon(
                onPressed: () async {
                  final select = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now());
                  setState(() {
                    selectdate = select;
                  });
                },
                icon: const Icon(
                  Icons.calendar_view_day_rounded,
                  size: 35,
                ),
                label: Text(
                    selectdate == null ? "Calender" : selectdate.toString())),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio<categorytype>(
                        value: categorytype.income,
                        groupValue: selected,
                        onChanged: (value) {
                          setState(() {
                            selected = value;
                          });
                        }),
                    const Text("Income"),
                  ],
                ),
                Row(
                  children: [
                    Radio<categorytype>(
                        value: categorytype.expense,
                        groupValue: selected,
                        onChanged: (value) {
                          setState(() {
                            selected = value;
                            id = null;
                          });
                        }),
                    const Text("Expense")
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButton<String>(
              hint: const Text("Select Category"),
              value: id,
              items: (selected == categorytype.income
                      ? categorydb.instance.income
                      : categorydb.instance.expense)
                  .value
                  .map((e) {
                return DropdownMenuItem(
                    value: e.id, onTap: () => c = e, child: Text(e.name));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  id = value;
                });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (purpose.text.isEmpty) return;
                      if (amount.text.isEmpty) return;
                      if (selectdate == null) return;
                      final num = double.tryParse(amount.text);
                      transactiondb.instance.insert(transactionmodel(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          purpose: purpose.text,
                          amount: num!,
                          date: selectdate!,
                          type: selected!,
                          category: c!.name));
                      Navigator.of(context).pop();
                    },
                    child: const Text("Submit")),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel"))
              ],
            )
          ]),
        )));
  }
}

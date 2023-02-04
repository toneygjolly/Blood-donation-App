import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final bloodGroups = ['A+', 'A', 'B+', 'B'];
  String? selectedGroup;
  final CollectionReference donar =
      FirebaseFirestore.instance.collection('donar');

  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();

  void addDonor() {
    final data = {
      'name': donorName.text,
      'phone': donorPhone.text,
      'group': selectedGroup
    };
    donar.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: donorName,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text("Donar Name")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: donorPhone,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), label: Text("Phone Number")),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField(
                    decoration:
                        InputDecoration(label: Text("select blood group")),
                    items: bloodGroups
                        .map((e) => DropdownMenuItem(
                              child: Text(e),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (val) {
                      selectedGroup = val as String?;
                    })),
            ElevatedButton(
                onPressed: () {
                  addDonor();
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 50)),
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}

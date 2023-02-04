import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UpdateDonor extends StatefulWidget {
  const UpdateDonor({Key? key}) : super(key: key);

  @override
  State<UpdateDonor> createState() => _UpdateDonorState();
}

class _UpdateDonorState extends State<UpdateDonor> {
  final bloodGroups = ['A+', 'A', 'B+', 'B'];
  String? selectedGroup;
  final CollectionReference donar =
      FirebaseFirestore.instance.collection('donar');

  TextEditingController donorName = TextEditingController();
  TextEditingController donorPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    donorName.text = args['name'];
    donorPhone.text = args['phone'];
    selectedGroup = args['group'];
    final docid = args['id'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Update Donor"),
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
                  print(args);
                },
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 50)),
                    backgroundColor: MaterialStateProperty.all(Colors.red)),
                child: Text("Update"))
          ],
        ),
      ),
    );
  }
}

import 'home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  final CollectionReference donar =
      FirebaseFirestore.instance.collection('donar');
  void deleteDonar(docId) {
    donar.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Donation APP"),
        backgroundColor: Colors.yellow,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        backgroundColor: Colors.greenAccent,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: StreamBuilder(
        stream: donar.orderBy('name').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot donarsnap = snapshot.data.docs[index];
                return Container(
                  height: 80,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: CircleAvatar(
                          backgroundColor: Colors.lightGreen,
                          radius: 30,
                          child: Text(
                            donarsnap['group'].toString(),
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            donarsnap['name'.toString()],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            donarsnap['phone'].toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/update',
                                  arguments: {
                                    
                                    
                                    
                                    'name': donarsnap['name'],
                                    'phone': donarsnap['phone'],
                                    'group': donarsnap['group'],
                                    'id': donarsnap.id,
                                  });
                            },
                            icon: Icon(Icons.edit),
                            iconSize: 30,
                          ),
                          IconButton(
                            onPressed: () {
                              deleteDonar(donarsnap.id);
                            },
                            icon: Icon(Icons.delete),
                            iconSize: 30,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}

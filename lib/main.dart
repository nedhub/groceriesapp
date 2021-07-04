import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Firebase'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => FirebaseFirestore.instance
                .collection("testing")
                .add({'timestamp': Timestamp.fromDate(DateTime.now())}),
            child: Icon(Icons.add),
          ),
          body: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('testing').snapshots(),
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot,
            ) {
              if (!snapshot.hasData) return const SizedBox.shrink();

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  final docData = snapshot.data!.docs[index].data();
                  final dataTime =
                      ((docData as dynamic)['timestamp'] as Timestamp).toDate();

                  return ListTile(
                    title: Text(dataTime.toString()),
                  );
                },
              );
            },
          )),
    );
  }
}

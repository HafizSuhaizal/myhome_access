/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'History Logs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('History Logs'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Emergency'),
              Tab(text: 'Visitor'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Emergency Tab
            _buildTab("emergency"),

            // Visitor Tab
            _buildTab("visitor"),
          ],
        ),
      ),
    );
  }

 Widget _buildTab(String collection) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection(collection).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        var data = snapshot.data!.docs;

        // Display your data here, for example:
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var item = data[index];
            return ListTile(
              title: Text(item['name']),
              subtitle: Text(item['timestamp']),
            );
          },
        );
      },
    );
  }
} */
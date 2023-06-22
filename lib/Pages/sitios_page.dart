import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ptoyecto_ciclo4/Pages/principal.dart';
import 'package:ptoyecto_ciclo4/models/sitio.dart';

class SitiosPage extends StatefulWidget {
  const SitiosPage({super.key});

  @override
  State<SitiosPage> createState() => _SitiosPageState();
}

class _SitiosPageState extends State<SitiosPage> {
  List<Sitio> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sitios turisticos'),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('sitios')
                .doc(FirebaseAuth.instance.currentUser?.uid)
                .collection('sitios')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading');
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot sitio = snapshot.data!.docs[index];
                  return Card(
                      child: ListTile(
                    title: Text(sitio['nombre']),
                    subtitle: Text(sitio['ciudad']),
                  ));
                },
              );
            },
          )),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Principal()));
      }),
    );
  }
}

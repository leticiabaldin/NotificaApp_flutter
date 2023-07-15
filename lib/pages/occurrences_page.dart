import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../entities/occurrence.dart';
import '../widgets/occurrenceListTile.dart';

class OccurrencesPage extends StatefulWidget {
  const OccurrencesPage({Key? key}) : super(key: key);

  @override
  State<OccurrencesPage> createState() => _OccurrencesPageState();
}

class _OccurrencesPageState extends State<OccurrencesPage> {
  bool loading = false;

  //pega o nome após passar no fireAuth

  StreamSubscription? subscription;
  List<Occurrence> occurrences = [];

  getOccurrences() async {
    final fireAuth = FirebaseAuth.instance;
    final user = fireAuth.currentUser;

    if (user == null || loading) return;
    setState(() => loading = true);

    final id = user!.uid;
    final firestore = FirebaseFirestore.instance;
    //conecta coma  collection do firebase
    final collection = firestore.collection("occurrences/$id/history").orderBy(
          "date",
          descending: true,
        );

    final result = await collection.get();
    final occurrences = result.docs
        .map(
          (doc) => Occurrence(
            doc.data()['title'],
            doc.data()['description'],
            doc.id,
            Options.values.firstWhere(
              (option) => option.name == doc.data()['type'],
            ),
          ),
        )
        .toList();

    setState(() {
      this.occurrences = occurrences;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getOccurrences();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 40,
        top: 32,
        right: 40,
      ),
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              Theme.of(context).brightness == Brightness.light
                  ? 'lib/assets/images/logo_dark.png'
                  : 'lib/assets/images/logo.png',
            ),
            const SizedBox(height: 32),
            const Text(
              'Lista de ocorrências:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
                itemCount: occurrences.length,
                itemBuilder: (context, index) {
                  final occurrence = occurrences[index];
                  return Card(
                    margin: const EdgeInsets.all(0),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: OccurrenceListTile(
                      occurrence: occurrence,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

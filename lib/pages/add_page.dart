import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../assets/colors/colors.dart';
import '../entities/occurrence.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Options optionsView = Options.open;

  bool loading = false;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> createOccurrence() async {
    if (loading) return;
    setState(() => loading = true);

    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final fireAuth = FirebaseAuth.instance;
    final firestore = FirebaseFirestore.instance;
    final id = fireAuth.currentUser!.uid;

    ScaffoldMessenger.of(context).clearSnackBars();

    final data = {
      "title": title,
      "description": description,
      "type": optionsView.name,
      "date": Timestamp.now(),
    };

    final collection = firestore.collection("occurrences/$id/history");
    await collection.add(data);

    titleController.clear();
    descriptionController.clear();

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
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
              'Nova ocorrência:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: titleController,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo é obrigatório.';
                      }
                      return null;
                    },
                    cursorColor: AppNotificaColors.whiteApp,
                    cursorHeight: 14,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppNotificaColors.blackApp
                                  : AppNotificaColors.whiteApp,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppNotificaColors.blackApp
                                  : AppNotificaColors.whiteApp,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppNotificaColors.blackApp
                                  : AppNotificaColors.whiteApp,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppNotificaColors.blackApp
                                  : AppNotificaColors.whiteApp,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: 'Título:',
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo é obrigatório.';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    cursorColor: AppNotificaColors.whiteApp,
                    cursorHeight: 14,
                    decoration: InputDecoration(
                      //fillColor: AppNotificaColors.whiteApp,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppNotificaColors.blackApp
                                  : AppNotificaColors.whiteApp,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppNotificaColors.blackApp
                                  : AppNotificaColors.whiteApp,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppNotificaColors.blackApp
                                  : AppNotificaColors.whiteApp,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppNotificaColors.blackApp
                                  : AppNotificaColors.whiteApp,
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: 'Descrição:',
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'Status:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: SegmentedButton(
                      showSelectedIcon: false,
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 20)),
                      segments: const [
                        ButtonSegment<Options>(
                          value: Options.open,
                          icon: Icon(
                            Icons.pending_actions_outlined,
                            size: 22,
                          ),
                          label: Text('Em aberto'),
                        ),
                        ButtonSegment<Options>(
                          value: Options.closed,
                          icon: Icon(
                            Icons.check_circle_outline,
                            size: 22,
                          ),
                          label: Text('Resolvida'),
                        ),
                      ],
                      selected: <Options>{optionsView},
                      onSelectionChanged: (Set<Options> newSelection) {
                        setState(() {
                          // By default there is only a single segment that can be
                          // selected at one time, so its value is always the first
                          // item in the selected set.
                          optionsView = newSelection.first;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.maxFinite,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: loading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                createOccurrence();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppNotificaColors.greenApp,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                      child: const Text(
                        'Registrar',
                        style: TextStyle(
                            color: AppNotificaColors.blackApp,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

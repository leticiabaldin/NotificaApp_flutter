import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notifica_app/pages/occurrences_page.dart';
import 'package:notifica_app/widgets/modal_logout.dart';
import 'about_page.dart';
import 'add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final fireAuth = FirebaseAuth.instance;
  late final user = fireAuth.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Olá, ${user?.displayName}!'),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const ModalLogout();
                  });
            },
            icon: Icon(
              Icons.logout_outlined,
              size: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (_selectedIndex == 1) {
            return const AddPage();
          }
          if (_selectedIndex == 2) {
            return const AboutPage();
          }
          return const OccurrencesPage();
        },
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 0,
        height: 88,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              size: 32,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.add_circle_outline,
              size: 32,
            ),
            label: 'Adicionar',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.announcement_outlined,
              size: 32,
            ),
            label: 'Sobre',
          ),
        ],
      ),
    );
  }
}

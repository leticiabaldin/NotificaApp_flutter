import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
                'Objetivo do App:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                child: const Text(
                  'Aplicativo desenvolvido em Flutter no curso do IFB, com intuito de permitir que as ocorrências sejam registradas e acompanhadas.',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Desenvolvedor:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    CircleAvatar(),
                    SizedBox(width: 16),
                    Text(
                      'Letícia Baldin Galvani',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

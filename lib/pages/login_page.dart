import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../assets/colors/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final reference = FirebaseFirestore.instance.doc(
  'userProfile/${FirebaseAuth.instance.currentUser!.uid}',
); //conexão com a collections do banco de dados

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  Future<void> login() async {
    if (loading) return;

    setState(() => loading = true);

    final fireAuth = FirebaseAuth.instance;
    final email = emailController.text.trim();
    final password = passwordController.text;

    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      final credentials = await fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      scaffoldMessenger.clearSnackBars();
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
            'Bem vindo(a), ${credentials.user!.displayName}!',
            //pega o nome do usuário
          ),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(milliseconds: 2000),
        ),
      );

      goToHome();

      emailController.clear();
      passwordController.clear();
    } catch (e) {
      scaffoldMessenger.clearSnackBars();
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Verifique suas credenciais ou crie uma conta.',
          ),
          behavior: SnackBarBehavior.floating,
          duration: Duration(milliseconds: 3000),
        ),
      );
    }
    setState(() => loading = false);
  }

  void goToHome() {
    context.go('/homePage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 280,
            width: 240,
            margin: const EdgeInsets.only(top: 72),
            child: Image.asset(
              Theme.of(context).brightness == Brightness.light
                  ? 'lib/assets/images/login_image_dark.png'
                  : 'lib/assets/images/login_image.png',
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 0,
              bottom: 32,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Registre e gerencie as ocorrências do seu IF.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      color: AppNotificaColors.blackApp,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo é obrigatório.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppNotificaColors.whiteApp,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: 'Digite seu email',
                      labelText: 'Email:',
                      labelStyle: const TextStyle(
                          color: AppNotificaColors.blackApp, fontSize: 18),
                    ),
                    cursorColor: AppNotificaColors.greyApp,
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      color: AppNotificaColors.blackApp,
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo é obrigatório.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppNotificaColors.whiteApp,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Senha:',
                      hintText: 'Digite sua senha',
                      labelStyle: const TextStyle(
                          color: AppNotificaColors.blackApp, fontSize: 18),
                    ),
                    cursorColor: AppNotificaColors.greyApp,
                  ),
                  const SizedBox(height: 64),
                  SizedBox(
                    width: double.maxFinite,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: loading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                login();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppNotificaColors.greenApp,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          )),
                      child: const Text(
                        'Entrar',
                        style: TextStyle(
                            color: AppNotificaColors.blackApp,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Não possui uma conta?',
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () => context.go('/createAccount'),
                        child: const Text(
                          'Clique aqui!',
                          style: TextStyle(
                            color: AppNotificaColors.greenApp,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

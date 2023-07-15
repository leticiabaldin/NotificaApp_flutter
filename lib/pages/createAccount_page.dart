import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../assets/colors/colors.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  Future<void> createAccount() async {
    if (loading) return;

    setState(() => loading = true);

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;

    final fireAuth = FirebaseAuth.instance;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    try {
      final credentials = await fireAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credentials.user!.updateDisplayName(name);
      scaffoldMessenger.clearSnackBars();
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text('Seja bem-vindo(a), $name'),
          duration: const Duration(milliseconds: 2000),
        ),
      );

      goToHome();
    } catch (e) {
      scaffoldMessenger.clearSnackBars();
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Não foi possível criar a sua conta. Tente novamente.'),
          duration: Duration(milliseconds: 2000),
        ),
      );
    }

    setState(() => loading = false);
  }

  void goToHome() {
    context.go('/homePage');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => context.go('/'),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: AppNotificaColors.whiteApp,
                    size: 28,
                  ),
                ),
              ],
            ),
            Image.asset(
              'lib/assets/images/createAccount_image.png',
              height: 148,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 0),
              child: const Text(
                'Crie sua conta aqui!',
                style: TextStyle(
                  color: AppNotificaColors.whiteApp,
                  fontSize: 18,
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 12,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                        color: AppNotificaColors.blackApp,
                      ),
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
                        hintText: 'Digite seu nome completo',
                        labelText: 'Nome completo:',
                        labelStyle: const TextStyle(
                            color: AppNotificaColors.blackApp, fontSize: 18),
                      ),
                      cursorColor: AppNotificaColors.greyApp,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(
                        color: AppNotificaColors.blackApp,
                      ),
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
                        labelText: 'Email:',
                        hintText: 'Digite seu email:',
                        labelStyle: const TextStyle(
                            color: AppNotificaColors.blackApp, fontSize: 18),
                      ),
                      cursorColor: AppNotificaColors.greyApp,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: passwordController,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      style: const TextStyle(
                        color: AppNotificaColors.blackApp,
                      ),
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
                        onPressed: !loading
                            ? () {
                                if (formKey.currentState!.validate()) {
                                  createAccount();
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppNotificaColors.greenApp,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )),
                        child: const Text(
                          'Confirmar',
                          style: TextStyle(
                              color: AppNotificaColors.blackApp,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

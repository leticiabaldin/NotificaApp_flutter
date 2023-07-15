import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ModalLogout extends StatefulWidget {
  const ModalLogout({Key? key}) : super(key: key);

  @override
  State<ModalLogout> createState() => _ModalLogoutState();
}

class _ModalLogoutState extends State<ModalLogout> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 28,
              horizontal: 50,
            ),
            alignment: Alignment.center,
            child: const Text(
              'Você tem certeza que deseja sair do aplicativo?',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.go('/');
                },
                style: ElevatedButton.styleFrom(
                  //backgroundColor: AppColors.greyDarkApp,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 32,
                  ),
                ),
                child: const Text(
                  'Confirmar',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 32,
                    )),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

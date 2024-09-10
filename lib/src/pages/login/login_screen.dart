import 'package:app_cadastro_goiais/src/utils/colors_static.dart';
import 'package:app_cadastro_goiais/src/utils/text_style_utils.dart';
import 'package:flutter/material.dart';

import '../../models/cadastro_model.dart';

class LoginScreen extends StatefulWidget {
  final CadastroModel cadastroModel;
  const LoginScreen({super.key, required this.cadastroModel});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bem Vindo", style: TextStylesUtils.titleAppBar),
        backgroundColor: ColorsStatic.backgroudColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Ola: ${widget.cadastroModel.nome.toUpperCase()}",
              style: TextStylesUtils.titleText,
            ),
          ),
        ],
      ),
    );
  }
}

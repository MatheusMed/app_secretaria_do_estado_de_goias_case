import 'package:app_cadastro_goiais/src/utils/colors_static.dart';
import 'package:app_cadastro_goiais/src/utils/text_style_utils.dart';
import 'package:flutter/material.dart';

import '../../models/cadastro_model.dart';

class HomeScreen extends StatefulWidget {
  final CadastroModel cadastroModel;
  const HomeScreen({super.key, required this.cadastroModel});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bem Vindo", style: TextStylesUtils.titleAppBar),
        backgroundColor: ColorsStatic.backgroudColor,
        centerTitle: true,
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

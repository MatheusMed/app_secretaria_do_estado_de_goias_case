import 'package:app_cadastro_goiais/src/controllers/cadastro_controller.dart';
import 'package:app_cadastro_goiais/src/utils/colors_static.dart';
import 'package:app_cadastro_goiais/src/utils/text_style_utils.dart';
import 'package:flutter/material.dart';

import '../cadastro/cadastro_screen.dart';
import '../login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cadastroController = CadastroController();

  final TextEditingController loginController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    cadastroController.getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Secretaria do Estado de Goias',
          style: TextStylesUtils.titleAppBar,
        ),
        centerTitle: true,
        backgroundColor: ColorsStatic.backgroudColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: loginController,
                  decoration: const InputDecoration(
                    labelText: 'Login',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o login';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                ValueListenableBuilder(
                    valueListenable: cadastroController.osbcureText,
                    builder: (context, osbcure, _) {
                      return TextFormField(
                        controller: senhaController,
                        obscureText: osbcure,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              cadastroController.osbcureText.value =
                                  !cadastroController.osbcureText.value;
                            },
                            icon: Icon(osbcure
                                ? Icons.remove_red_eye
                                : Icons.visibility_off_sharp),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a senha';
                          }

                          return null;
                        },
                      );
                    }),
                const SizedBox(height: 32.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final login = cadastroController.listaTasks.value.any(
                            (elemento) =>
                                elemento.login == loginController.text &&
                                elemento.senha == senhaController.text);

                        if (login) {
                          final id = cadastroController
                              .obterIdPeloLogin(loginController.text);

                          final model =
                              await cadastroController.getCadastro(id!);

                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(
                                cadastroModel: model!,
                              ),
                            ),
                          );
                          loginController.clear();
                          senhaController.clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Usuário não encontrado. Por favor, cadastre-se.'),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(height: 20.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CadastroScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Cadastre-se",
                      style: TextStylesUtils.styleButton,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

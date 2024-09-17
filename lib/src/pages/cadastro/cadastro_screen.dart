// ignore_for_file: use_build_context_synchronously

import 'package:app_cadastro_goiais/src/models/cadastro_model.dart';
import 'package:app_cadastro_goiais/src/utils/colors_static.dart';
import 'package:app_cadastro_goiais/src/utils/text_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../controllers/cadastro_controller.dart';
import '../../utils/cpf_input_mask.dart';
import '../../utils/text_style_utils.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final cadastroController = CadastroController();

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController dataNascController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        dataNascController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    cpfController.dispose();
    dataNascController.dispose();
    senhaController.dispose();
    loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cadastro',
          style: TextStylesUtils.titleAppBar,
        ),
        backgroundColor: ColorsStatic.backgroudColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: ColorsStatic.whiteColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 5),
              TextFormWidget(
                controller: loginController,
                labelError: "o Login",
                labelText: 'Login',
              ),
              const SizedBox(height: 16.0),
              ValueListenableBuilder(
                  valueListenable: cadastroController.osbcureText,
                  builder: (context, osbcure, _) {
                    return TextFormWidget(
                      controller: senhaController,
                      labelError: "a Senha",
                      labelText: 'Senha',
                      obscureText: osbcure,
                      suffixIcon: IconButton(
                        onPressed: () {
                          cadastroController.osbcureText.value =
                              !cadastroController.osbcureText.value;
                        },
                        icon: Icon(osbcure
                            ? Icons.remove_red_eye
                            : Icons.visibility_off_sharp),
                      ),
                    );
                  }),
              const SizedBox(height: 16.0),
              TextFormWidget(
                controller: nomeController,
                labelError: "o Nome",
                labelText: "Nome",
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: cpfController,
                keyboardType: TextInputType.number,
                inputFormatters: [CpfInputFormatter()],
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o CPF';
                  }
                  final cpfValidator = value.replaceAll(RegExp(r'\D'), '');
                  if (cpfValidator.length != 11) {
                    return 'CPF inválido. Deve ter 11 dígitos.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormWidget(
                controller: dataNascController,
                labelError: "a Data de Nascimento",
                isReadOnly: true,
                labelText: 'Data de Nascimento',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final modelCadastro = CadastroModel(
                      nome: nomeController.text,
                      cpf: cpfController.text,
                      dataDeNasc: dataNascController.text,
                      login: loginController.text,
                      senha: senhaController.text,
                    );
                    await cadastroController.addUser(modelCadastro);

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Cadastro realizado com sucesso!')),
                    );
                  }
                },
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

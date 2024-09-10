import 'package:app_cadastro_goiais/src/models/cadastro_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../controllers/cadastro_controller.dart';
import '../../utils/cpf_input_mask.dart'; // Para formatação de data

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
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
              const SizedBox(height: 16.0),
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
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
              TextFormField(
                controller: dataNascController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Data de Nascimento',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a data de nascimento';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
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
                    await cadastroController.addTask(modelCadastro);
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

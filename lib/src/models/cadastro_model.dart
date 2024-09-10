// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CadastroModel {
  final int? id;
  final String nome;
  final String cpf;
  final String dataDeNasc;
  final String login;
  final String senha;
  CadastroModel({
    this.id,
    required this.nome,
    required this.cpf,
    required this.dataDeNasc,
    required this.login,
    required this.senha,
  });

  CadastroModel copyWith({
    int? id,
    String? nome,
    String? cpf,
    String? dataDeNasc,
    String? login,
    String? senha,
  }) {
    return CadastroModel(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      cpf: cpf ?? this.cpf,
      dataDeNasc: dataDeNasc ?? this.dataDeNasc,
      login: login ?? this.login,
      senha: senha ?? this.senha,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'dataDeNasc': dataDeNasc,
      'login': login,
      'senha': senha,
    };
  }

  factory CadastroModel.fromMap(Map<String, dynamic> map) {
    return CadastroModel(
      id: map['id'] != null ? map['id'] as int : null,
      nome: map['nome'] as String,
      cpf: map['cpf'] as String,
      dataDeNasc: map['dataDeNasc'] as String,
      login: map['login'] as String,
      senha: map['senha'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CadastroModel.fromJson(String source) =>
      CadastroModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CadastroModel(id: $id, nome: $nome, cpf: $cpf, dataDeNasc: $dataDeNasc, login: $login, senha: $senha)';
  }

  @override
  bool operator ==(covariant CadastroModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        other.cpf == cpf &&
        other.dataDeNasc == dataDeNasc &&
        other.login == login &&
        other.senha == senha;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        cpf.hashCode ^
        dataDeNasc.hashCode ^
        login.hashCode ^
        senha.hashCode;
  }
}

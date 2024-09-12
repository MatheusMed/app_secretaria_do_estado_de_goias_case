## Descrição

Este aplicativo foi criado para fornecer uma solução básica para cadastro de usuários. Ele inclui um formulário com os seguintes campos:

- **Nome**: O nome completo do usuário.
- **CPF**: O CPF do usuário (formato `XXX.XXX.XXX-XX`).
- **Data de Nascimento**: A data de nascimento do usuário.
- **Login**: Nome de usuário para autenticação.
- **Senha**: Senha para autenticação.

Os dados inseridos no formulário são armazenados em um banco de dados SQLite local utilizando o pacote `sqflite`. A aplicação demonstra a inserção, visualização e validação dos dados no banco de dados.

## Funcionalidades

- **Formulário de Cadastro**: Permite que o usuário insira informações pessoais e crie uma conta.
- **Máscara de CPF**: O campo CPF possui uma máscara que formata automaticamente a entrada do usuário no formato `XXX.XXX.XXX-XX`.
- **Validação de Campos**: Verifica se todos os campos obrigatórios foram preenchidos e se o CPF tem o formato correto.
- **Armazenamento Local**: Salva os dados do usuário em um banco de dados SQLite local, usando o pacote `sqflite`.

## Tecnologias Utilizadas

- **Flutter**: Framework para criar interfaces nativas compiladas para dispositivos móveis a partir de uma única base de código.
- **sqflite**: Biblioteca para gerenciamento de banco de dados SQLite no Flutter.

## Como Executar o Projeto

1. **Clone o repositório**:

   ```sh
   git clone https://github.com/MatheusMed/app_secretaria_do_estado_de_goias_case

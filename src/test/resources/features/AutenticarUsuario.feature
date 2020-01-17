#language: pt
@AutenticarUsuario
Funcionalidade: 02) Autenticar Usuario
  Como usuário eu quero realizar a autenticacao no sistema para realizar o gerenciamento de contas
  Seguindo as seguintes restrições:
  1) Devera haver validacao de obrigatoriedade dos campos Email e Senha.
  2) So devera acessar o sistema o usuario que informar os dados corretos para autenticacao.

  Contexto: Acessa a pagina de login
    Dado Dado que o usuario queira realizar autenticacao

  Esquema do Cenario: 01) Validar campos obrigatorios
    E E que o usuario informe os dados necessarios para autenticacao "<email>" "<senha>"
    Entao Entao o usuario e informado que campos obrigatorios nao foram preenchidos "<email>" "<senha>"

    Exemplos: 
      | email                   | senha  |
      |                         |        |
      |                         | 123456 |
      | teste@naocadastrado.com |        |

  Cenario: 02) Validar login invalido
    E E que o usuario informe os dados necessarios para autenticacao
      | email                   | senha  |
      | teste@logininvalido.com | 123456 |
    Entao Entao o usuario e informado que nao foi realizada autenticacao

  Cenario: 03) Realizar login
    E E que o usuario informe os dados necessarios para autenticacao
    Entao Entao o usuario e informado que foi realizada a autenticacao com sucesso

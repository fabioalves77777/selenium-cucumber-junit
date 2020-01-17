#language: pt
@CadastrarUsuario
Funcionalidade: 01) Cadastrar Usuario
  Como usuário eu quero cadastrar meus dados de usuário para acessar o sistema de gerenciamento de contas
  Seguindo as seguintes restrições:
  1) Devera haver validacao de obrigatoriedade dos campos Username e Email.
  2) Nao devera criar uma nova conta caso o e-mail informado ja esteja cadastrado.

  Contexto: Acessa a pagina de cadastro
    Dado Dado que o usuario queira criar uma conta

  Esquema do Cenario: 01) Validar campos obrigatorios
    E E que o usuario informe os dados necessarios para cadastro "<nome>" "<email>" "<senha>"
    Entao Entao o usuario e informado que campos obrigatorios do cadastro nao foram preenchidos "<nome>" "<email>" "<senha>"

    Exemplos: 
      | nome          | email                   | senha  |
      |               |                         |        |
      |               | teste@naocadastrado.com | 123456 |
      | naocadastrado |                         | 123456 |
      | naocadastrado | teste@naocadastrado.com |        |

  Cenario: 02) Validar e-mail ja cadastrado
    E E que o usuario informe os dados necessarios para cadastrar
      | nome        | email                       | senha  |
      | Fabio Alves | fabioaraujo.alves@email.com | 123456 |
    Entao Entao o usuario e informado que ja existe um registro cadastrado para esse e-mail

  Cenario: 03) Realizar cadastro
    E E que o usuario informe os dados necessarios para cadastro
    Entao Entao o usuario e informado que foi realizado o cadastro com sucesso

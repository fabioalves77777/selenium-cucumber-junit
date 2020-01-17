#language: pt
@AutenticarUsuario
Funcionalidade: 03) Manter Conta
  Como usuário eu quero configurar os tipos de conta no sistema para realizar as movimentações informando o tipo de conta
  Seguindo as seguintes restrições:
  1) Devera haver validacao de obrigatoriedade do campo Nome.
  2) Devera haver validacao de registro duplicado Nome

  Contexto: Acessa a pagina inicial
    Dado Dado que o usuario realize a autenticacao no sistema

  Cenario: 01) Adicionar Conta - Validar campos obrigatorios
    E E que o usuario acesse a tela de adicionar conta
    E E que o usuario informe os dados necessarios para criacao da conta
      | nome |
      |      |
    Entao Entao o usuario e informado que campos obrigatorios nao foram preenchidos na inclusao

  Cenario: 02) Adicionar Conta - Validar conta ja cadastrada
    E E que o usuario acesse a tela de adicionar conta
    E E que o usuario informe os dados necessarios para criacao da conta
      | nome             |
      | Conta mesmo nome |
    Entao Entao o usuario e informado que ja existe uma conta cadastrada com o mesmo nome na inclusao

  Cenario: 03) Adicionar conta
    E E que o usuario acesse a tela de adicionar conta
    E E que o usuario informe os dados necessarios para criacao da conta
    Entao Entao o usuario e informado que foi realizada a inclusao da conta com sucesso

  Cenario: 04) Alterar Conta - Validar campos obrigatorios
    E E que o usuario acesse a tela de listar conta
    E E que o usuario acesse a tela de alterar conta
    E E que o usuario informe os dados necessarios para alteracao da conta
      | nome |
      |      |
    Entao Entao o usuario e informado que campos obrigatorios nao foram preenchidos na alteracao

  Cenario: 05) Alterar Conta - Validar conta ja cadastrada
    E E que o usuario acesse a tela de listar conta
    E E que o usuario acesse a tela de alterar conta
    E E que o usuario informe os dados necessarios para alteracao da conta
      | nome             |
      | Conta mesmo nome |
    Entao Entao o usuario e informado que ja existe uma conta cadastrada com o mesmo nome na alteracao

  Cenario: 06) Alterar conta
    E E que o usuario acesse a tela de listar conta
    E E que o usuario acesse a tela de alterar conta
    E E que o usuario informe os dados necessarios para alteracao da conta
    Entao Entao o usuario e informado que foi realizada a alteracao da conta com sucesso

  Cenario: 07) Excluir conta - Validar exclusao de conta com movimentacao
    E E que o usuario acesse a tela de listar conta
    E E que o usuario solicite a exclusao da conta com movimentacao
    Entao Entao o usuario e informado que nao pode excluir conta com movimentacao

  Cenario: 08) Excluir conta
    E E que o usuario acesse a tela de listar conta
    E E que o usuario solicite a exclusao da conta
    Entao Entao o usuario e informado que foi realizada a exclusao da conta com sucesso
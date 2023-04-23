*** Settings ***
Resource            navegacaoSiteResource.robot

Suite Setup         Acessar Amazon
Suite Teardown      Fechar Navegador


*** Test Cases ***
Navegar pelo pelo menu de navegação lateral
    Expandir o menu lateral do site
    Clicar no botão Ver Tudo da seção Comprar Por Categoria
    Navegar para a categoria Games e Console
    Verificar o título da página "Games e Consoles | Amazon.com.br"
    Verificar que "Games" é o filtro que esta sendo usado
    Verificar que "Games e Consoles" é o departamento que esta sendo analisado

Navegar pelo menu suspenso das opções do usuário
    Fazer Login com o email "test@hotmail.com" e a senha "test"
    Passe o mouse sobre o campo que indica o nome do usuário
    Navegue para a lista de pedidos do usuário pelo menu suspeso que apareceu na tela
    Verifique que foi redirecionado para a página da lista de pedidos do usuário

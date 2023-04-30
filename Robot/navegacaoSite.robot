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

Navegar pelo widget tipo Slider
    Verifique que o botão da esquerda está desabilitado
    Verifique que o botão da direita está habilitado
    Clique para avançar as categorias do widget
    Verifique que o botão da esquerda está habilitado
    Verifique que o botão da direita está desabilitado
    Clique para voltar as categorias do widget
    Verifique que o botão da esquerda está desabilitado
    Verifique que o botão da direita está habilitado

Interagir com o modal de endereços salvos
    Fazer Login com o email "test@hotmail.com" e a senha "test"
    Clique no campo para mudar o endereço
    ${ENDERECO_1}    Get Text    ${ENDERECO_SELECIONADO}
    Verifique que todo os endereços cadastrados aparecem no modal
    Mude para um novo endereço
    Verifique que o CEP e o nome da cidade são diferentes de "${ENDERECO_1}"
    Clique no campo para mudar o endereço
    ${ENDERECO_2}    Get Text    ${ENDERECO_SELECIONADO}
    Coloque o número de um CEP "50050" "900"
    Verifique que o CEP e o nome da cidade são diferentes de "${ENDERECO_2}"
    Clique no campo para mudar o endereço
    Coloque o número de um CEP "00000" "900"
    Verifique que o alerta de erro aparece

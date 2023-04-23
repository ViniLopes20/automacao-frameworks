*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${BROWSER}                              chrome
${URL}                                  https://www.amazon.com.br/

${BOTAO_LOGIN}                          xpath=//div[@id='nav-signin-tooltip']//span[@class='nav-action-inner']
${CAMPO_EMAIL}                          xpath=//input[@id='ap_email']
${BOTAO_CONTINUAR}                      xpath=//input[@id='continue']
${CAMPO_SENHA}                          xpath=//input[@id='ap_password']
${BOTAO_FAZER_LOGIN}                    xpath=//input[@id='signInSubmit']

${BOTAO_CONTA_USUARIO}                  xpath=//a[@data-nav-ref='nav_youraccount_btn']
${BOTAO_SEUS_PEDIDOS}                   xpath=//a[@id='nav_prefetch_yourorders']

${FILTRO_SELECIONADO}                   xpath=//option[@selected='selected']

${DEPARTAMENTO_SELECIONADO}             xpath=//span[contains(@class,'apb-browse-refinements-indent-1')]

${BOTAO_MENU_LATERAL}                   xpath=//a[@id='nav-hamburger-menu']
${PRIMEIRO_BOTAO_VER_TUDO}              xpath=(//a[contains(@class,'hmenu-compressed-btn')])[1]
${OPCAO_CATEGORIA_GAMES_CONSOLE}        xpath=//a[@class='hmenu-item']//div[text()='Games e Consoles']
${OPCAO_SUBCATEGORIA_GAMES_CONSOLE}     xpath=//a[@class='hmenu-item' and text()='Tudo em Games e Consoles']

${TITULO_PAGINA}                        xpath=//h1[text()='Seus pedidos']


*** Keywords ***
Acessar Amazon
    Open Browser    ${URL}    ${BROWSER}
    Title Should Be    Amazon.com.br | Tudo pra você, de A a Z.

Fazer Login com o email "${EMAIL}" e a senha "${SENHA}"
    Click Element    ${BOTAO_LOGIN}
    Wait Until Element Is Visible    ${CAMPO_EMAIL}
    Input Text    ${CAMPO_EMAIL}    ${EMAIL}
    Click Element    ${BOTAO_CONTINUAR}
    Wait Until Element Is Visible    ${CAMPO_SENHA}
    Input Text    ${CAMPO_SENHA}    ${SENHA}
    Click Element    ${BOTAO_FAZER_LOGIN}

Clicar no botão Ver Tudo da seção Comprar Por Categoria
    Click Element    ${PRIMEIRO_BOTAO_VER_TUDO}
    Wait Until Element Is Visible    ${OPCAO_CATEGORIA_GAMES_CONSOLE}

Expandir o menu lateral do site
    Click Element    ${BOTAO_MENU_LATERAL}
    Wait Until Element Is Visible    ${PRIMEIRO_BOTAO_VER_TUDO}

Navegar para a categoria Games e Console
    Click Element    ${OPCAO_CATEGORIA_GAMES_CONSOLE}
    Click Element    ${OPCAO_SUBCATEGORIA_GAMES_CONSOLE}

Verificar o título da página "${TITULO_PAGINA}"
    Title Should Be    ${TITULO_PAGINA}

Verificar que "${NOME_FILTRO}" é o filtro que esta sendo usado
    Element Text Should Be    ${FILTRO_SELECIONADO}    ${NOME_FILTRO}

Verificar que "${NOME_DEPARTAMENTO}" é o departamento que esta sendo analisado
    Element Text Should Be    ${DEPARTAMENTO_SELECIONADO}    ${NOME_DEPARTAMENTO}

Passe o mouse sobre o campo que indica o nome do usuário
    Wait Until Element Is Visible    ${BOTAO_CONTA_USUARIO}
    Mouse Over    ${BOTAO_CONTA_USUARIO}

Navegue para a lista de pedidos do usuário pelo menu suspeso que apareceu na tela
    Wait Until Element Is Visible    ${BOTAO_SEUS_PEDIDOS}
    Click Element    ${BOTAO_SEUS_PEDIDOS}

Verifique que foi redirecionado para a página da lista de pedidos do usuário
    Page Should Contain Element    ${TITULO_PAGINA}
    Location Should Contain    AccountFlyout_orders

Fechar Navegador
    Close Browser

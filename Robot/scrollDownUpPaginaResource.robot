*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${BROWSER}              chrome
${URL}                  https://www.amazon.com.br/

${CAMPO_PESQUISAR}      xpath=//input[@id='twotabsearchtextbox']


*** Keywords ***
Acessar Amazon
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Title Should Be    Amazon.com.br | Tudo pra você, de A a Z.
    Wait Until Element Is Visible    ${CAMPO_PESQUISAR}

Scroll down na página até o fim da página
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)

Verificar que chegou no final da página
    ${scroll_height}=    Execute Javascript    return document.body.scrollHeight
    ${window_height_Down}=    Execute Javascript    return window.innerHeight
    ${scroll_position_Down}=    Execute Javascript    return window.scrollY
    Should Be True    ${scroll_position_Down} == ${scroll_height} - ${window_height_Down}

Scroll up na página até o início da página
    Execute Javascript    window.scrollTo(0, 0)

Verificar que chegou no topo da página
    ${scroll_position_Up}=    Execute Javascript    return window.scrollY
    Should Be True    ${scroll_position_Up} == 0

Fechar Navegador
    Close Browser

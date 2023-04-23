*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${BROWSER}                  chrome
${URL}                      https://www.amazon.com.br/

${VOLTAR_MENU_SLIDER}       xpath=//i[@class='a-icon a-icon-previous-rounded']
${AVANCAR_MENU_SLIDER}      xpath=//i[@class='a-icon a-icon-next-rounded']
${PROPAGANDA_POSICAO}       xpath=//input[@class='a-carousel-firstvisibleitem']

${CAMPO_PESQUISAR}          xpath=//input[@id='twotabsearchtextbox']
${BOTAO_PESQUISAR}          xpath=//input[@type='submit']

${LINK_PRODUTO}             xpath=//div[@data-component-type='s-search-result'][1]
${TITULO_PRODUTO}           xpath=//span[@id='productTitle']


*** Keywords ***
Acessar Amazon
    Open Browser    ${URL}    ${BROWSER}
    Title Should Be    Amazon.com.br | Tudo pra você, de A a Z.

Click para voltar o anuncio da propaganda
    Click Element    ${VOLTAR_MENU_SLIDER}

Click para avançar o anuncio da propaganda
    Click Element    ${AVANCAR_MENU_SLIDER}

Verifique que o anuncio foi alterado para a propaganda "${PROPAGANDA_NUMERO}"
    Element Attribute Value Should Be    ${PROPAGANDA_POSICAO}    value    ${PROPAGANDA_NUMERO}

Pesquisar o produto "${PRODUTO}"
    Input Text    ${CAMPO_PESQUISAR}    ${PRODUTO}
    Click Element    ${BOTAO_PESQUISAR}
    Wait Until Element Is Visible    ${LINK_PRODUTO}

Clicar no produto primeiro produto encontrado
    Click Element    ${LINK_PRODUTO}
    Wait Until Element Is Visible    ${TITULO_PRODUTO}

Verifique que o produto "${NOME_PRODUTO}" aparece no resultado da pesquisa
    Page Should Contain    ${NOME_PRODUTO}

Fechar Navegador
    Close Browser

*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${BROWSER}                  chrome
${URL}                      https://www.google.com.br/

${CAMPO_PESQUISA_GOOGLE}    xpath=//textarea[@type='search']

${LISTA_RESULTADOS}         xpath=//div[@id="result-stats"]
${LINK_SITE_AMAZON}         xpath=//a[@href='https://www.amazon.com.br/']

${CAMPO_PESQUISA_AMAZON}    xpath=//input[@id='twotabsearchtextbox']
${LOGO_SITE_AMAZON}         xpath=//a[@aria-label='Amazon.com.br']


*** Keywords ***
Acessar Google
    Open Browser    ${URL}    ${BROWSER}
    Title Should Be    Google

Pesquisar o site da "${NOME_SITE}"
    Input Text    ${CAMPO_PESQUISA_GOOGLE}    ${NOME_SITE}
    Press Keys    ${CAMPO_PESQUISA_GOOGLE}    ENTER
    Wait Until Element Is Visible    ${LISTA_RESULTADOS}

Selecionar o site da Amazon pelos resultados do Google
    Wait Until Element Is Visible    ${LISTA_RESULTADOS}
    Click Element    ${LINK_SITE_AMAZON}

Verificar que o site da Amazon foi carregado corretamente
    Wait Until Element Is Visible    ${CAMPO_PESQUISA_AMAZON}
    Element Should Be Visible    ${CAMPO_PESQUISA_AMAZON}
    Element Should Be Visible    ${LOGO_SITE_AMAZON}

Fechar Navegador
    Close Browser

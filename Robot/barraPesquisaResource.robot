*** Settings ***
Library     SeleniumLibrary
Library     XML


*** Variables ***
${BROWSER}                      chrome
${URL}                          https://www.amazon.com.br/

${FILTRO_PESQUISA}              xpath=//select[@aria-describedby='searchDropdownDescription']
${FILTRO_SELECIONADO}           xpath=//option[@selected='selected']
${CAMPO_PESQUISAR}              xpath=//input[@id='twotabsearchtextbox']
${BOTAO_PESQUISAR}              xpath=//input[@type='submit']
${CAMPO_AUTO_COMPLETE}          xpath=//div[@class='autocomplete-results-container']
${SUGESTAO_AUTO_COMPLETE}       xpath=//div[@aria-label='logitech mx master 3s']

${DEPARTAMENTO_SELECIONADO}     xpath=//span[@class='a-list-item']//*[contains(@class,'a-text-bold')]

${LINK_PRODUTO}                 xpath=//div[@data-component-type='s-search-result'][1]


*** Keywords ***
Acessar Amazon
    Open Browser    ${URL}    ${BROWSER}
    Title Should Be    Amazon.com.br | Tudo pra você, de A a Z.

Seleciona a opção "${OPCAO_FILTRO}" do filtro de pesquisa
    Click Element    ${FILTRO_PESQUISA}
    Select From List By Index    ${FILTRO_PESQUISA}    ${OPCAO_FILTRO}

Verificar que "${NOME_FILTRO}" é o filtro que esta sendo usado
    Element Text Should Be    ${FILTRO_SELECIONADO}    ${NOME_FILTRO}

Pesquisar o produto "${PRODUTO}"
    Input Text    ${CAMPO_PESQUISAR}    ${PRODUTO}
    Click Element    ${BOTAO_PESQUISAR}
    Wait Until Element Is Visible    ${LINK_PRODUTO}

Verificar a sugestão de auto complete para a pesquisa de "${PRODUTO}"
    Input Text    ${CAMPO_PESQUISAR}    ${PRODUTO}
    Wait Until Element Is Visible    ${CAMPO_AUTO_COMPLETE}
    Element Should Be Visible    ${CAMPO_AUTO_COMPLETE}

Selecionar a sugestão logitech mx master 3s do auto complete da pesquisa
    Click Element    ${SUGESTAO_AUTO_COMPLETE}

Verifique que o produto "${NOME_PRODUTO}" aparece no resultado da pesquisa
    Wait Until Element Is Visible    ${LINK_PRODUTO}
    Page Should Contain    ${NOME_PRODUTO}

Verificar que "${NOME_DEPARTAMENTO}" é o departamento que esta sendo analisado
    Element Text Should Be    ${DEPARTAMENTO_SELECIONADO}    ${NOME_DEPARTAMENTO}

Fechar Navegador
    Close Browser

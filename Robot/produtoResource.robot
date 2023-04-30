*** Settings ***
Library     SeleniumLibrary
Library     XML
Library     BuiltIn


*** Variables ***
${BROWSER}                      chrome
${URL}                          https://www.amazon.com.br/
${URL_PRODUTO_VIDEO}
...                             https://www.amazon.com.br/Logitech-MX-Master-3S-Superf%C3%ADcie/dp/B0B11LJ69K/ref=sr_1_2?__mk_pt_BR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=EY6N70D07TZP&keywords=logitech+mx+master+3s&qid=1682869534&sprefix=logitech+mx+master+3s%2Caps%2C251&sr=8-2&ufe=app_do%3Aamzn1.fos.25548f35-0de7-44b3-b28e-0f56f3f96147

${BOTAO_LOGIN}                  xpath=//div[@id='nav-signin-tooltip']//span[@class='nav-action-inner']
${CAMPO_EMAIL}                  xpath=//input[@id='ap_email']
${BOTAO_CONTINUAR}              xpath=//input[@id='continue']
${CAMPO_SENHA}                  xpath=//input[@id='ap_password']
${BOTAO_FAZER_LOGIN}            xpath=//input[@id='signInSubmit']

${CAMPO_PESQUISAR}              xpath=//input[@id='twotabsearchtextbox']
${BOTAO_PESQUISAR}              xpath=//input[@type='submit']

${FILTRO_MARCA}                 xpath=//div[@id='brandsRefinements']//li[@aria-label='Logitech']//i
${FILTRO_VALOR}                 xpath=//div[@id='priceRefinements']//span[text()='Até R$50']

${LINK_PRIMEIRO_PRODUTO}        xpath=//div[@data-component-type='s-search-result'][1]
${PRODUTO_1}                    xpath=//div[@data-cel-widget='search_result_1']//span[@class='a-price-whole']
${PRODUTO_2}                    xpath=//div[@data-cel-widget='search_result_1']//span[@class='a-price-whole']
${PRODUTO_3}                    xpath=//div[@data-cel-widget='search_result_1']//span[@class='a-price-whole']

${TITULO_PRODUTO}               xpath=//span[@id='productTitle']
${BOTAO_AVALIACAO_PRODUTO}      xpath=//span[contains(@class,'writeReviewButton')]

${CINCO_ESTRELAS}               xpath=//img[contains(@alt,'cinco estrelas')]
${CAMPO_TITULO_AVALIACAO}       xpath=//input[@id='scarface-review-title-label']
${CAMPO_AVALICAO_DETALHES}      xpath=//textarea[@id='scarface-review-text-card-title']
${UPLOAD_IMAGEM_PRODUTO}        xpath=//input[@id='ryp__media-upload-banner-input']
${ENVIAR_AVALIACAO}             xpath=//button[@value='Enviar']

${ALERTA_AVALIACAO_ENVIADA}     xpath=//div[contains(@class,'a-alert-success')]

${CONTAINER_VIDEO}              xpath=//div[contains(@class,'vse-player-container')]
${REPRODUZIR_VIDEO}             xpath=//button[@title='Play Video']
${PAUSAR_VIDEO}                 xpath=//button[@title='Pause']
${TEMPO_REPRODUCAO}             xpath=//span[@class='vjs-remaining-time-display']
${VOLUME_SOM}                   xpath=//button[contains(@class,'vjs-mute-control')]


*** Keywords ***
Acessar Amazon
    Open Browser    ${URL}    ${BROWSER}
    Title Should Be    Amazon.com.br | Tudo pra você, de A a Z.

Acessar o produto que possui um vídeo para ser reproduzido no site da Amazon
    Open Browser    ${URL_PRODUTO_VIDEO}    ${BROWSER}
    Maximize Browser Window
    Title Should Be
    ...    Mouse sem fio Logitech MX Master 3S com Sensor Darkfield para Uso em Qualquer Superfície, Design Ergonômico, Clique Silencioso, Conexão USB-C ou Bluetooth - Grafite | Amazon.com.br

Fazer Login com o email "${EMAIL}" e a senha "${SENHA}"
    Click Element    ${BOTAO_LOGIN}
    Wait Until Element Is Visible    ${CAMPO_EMAIL}
    Input Text    ${CAMPO_EMAIL}    ${EMAIL}
    Click Element    ${BOTAO_CONTINUAR}
    Wait Until Element Is Visible    ${CAMPO_SENHA}
    Input Text    ${CAMPO_SENHA}    ${SENHA}
    Click Element    ${BOTAO_FAZER_LOGIN}

Pesquisar o produto "${PRODUTO}"
    Wait Until Element Is Visible    ${CAMPO_PESQUISAR}
    Input Text    ${CAMPO_PESQUISAR}    ${PRODUTO}
    Click Element    ${BOTAO_PESQUISAR}
    Wait Until Element Is Visible    ${LINK_PRIMEIRO_PRODUTO}

Adicionar o filtro para a marca Logitech
    Wait Until Element Is Visible    ${FILTRO_MARCA}
    Click Element    ${FILTRO_MARCA}

Adicionar o filtro para o valor de Até R$50
    Wait Until Element Is Visible    ${FILTRO_VALOR}
    Click Element    ${FILTRO_VALOR}

Verifique que o produto "${NOME_PRODUTO}" aparece no resultado da pesquisa
    Wait Until Element Is Visible    ${LINK_PRIMEIRO_PRODUTO}
    Page Should Contain    ${NOME_PRODUTO}

Verifique que o produto "${NOME_PRODUTO}" não aparece no resultado da pesquisa
    Wait Until Element Is Visible    ${LINK_PRIMEIRO_PRODUTO}
    Page Should Not Contain    ${NOME_PRODUTO}

Verificar que o valor dos três primeiros pedido são menores que "${VALOR_MAX}" reais
    Wait Until Element Is Visible    ${PRODUTO_1}
    ${PRECO_1}    Get Text    ${PRODUTO_1}
    ${PRECO_2}    Get Text    ${PRODUTO_2}
    ${PRECO_3}    Get Text    ${PRODUTO_3}

    ${resultado}    Set Variable If    '${PRECO_1}' < '${VALOR_MAX}'    True    False
    Should Be True
    ...    ${resultado}
    ...    Verificando se o preço do produto 1 é menor que o valor máximo de "${VALOR_MAX}" reais

    ${resultado}    Set Variable If    '${PRECO_2}' < '${VALOR_MAX}'    True    False
    Should Be True
    ...    ${resultado}
    ...    Verificando se o preço do produto 2 é menor que o valor máximo de "${VALOR_MAX}" reais

    ${resultado}    Set Variable If    '${PRECO_3}' < '${VALOR_MAX}'    True    False
    Should Be True
    ...    ${resultado}
    ...    Verificando se o preço do produto 3 é menor que o valor máximo de "${VALOR_MAX}" reais

Abrir o primeiro produto do resultado da pesquisa
    Wait Until Element Is Visible    ${LINK_PRIMEIRO_PRODUTO}
    Click Element    ${LINK_PRIMEIRO_PRODUTO}
    Wait Until Element Is Visible    ${TITULO_PRODUTO}

Clique no botão para escrever uma avaliação
    Execute Javascript    window.scrollBy(0,7000)
    Wait Until Element Is Visible    ${BOTAO_AVALIACAO_PRODUTO}
    Click Element    ${BOTAO_AVALIACAO_PRODUTO}

Escrever a avaliação do produto com o título "${TITULO_AVALIACAO}" e os detalhes da avalição com "${AVALICAO_DETALHES}"
    Wait Until Element Is Visible    ${CINCO_ESTRELAS}
    Click Element    ${CINCO_ESTRELAS}
    Input Text    ${CAMPO_TITULO_AVALIACAO}    ${TITULO_AVALIACAO}
    Choose File    ${UPLOAD_IMAGEM_PRODUTO}    /home/me/Vinicius/automacao-frameworks/automacao.png
    Input Text    ${CAMPO_AVALICAO_DETALHES}    ${AVALICAO_DETALHES}

Enviar a avaliação
    Wait Until Element Is Enabled    ${ENVIAR_AVALIACAO}
    Click Button    ${ENVIAR_AVALIACAO}

Verificar que a avalição foi enviada com sucesso
    Wait Until Element Is Visible    ${ALERTA_AVALIACAO_ENVIADA}
    Page Should Contain Element    ${ALERTA_AVALIACAO_ENVIADA}

Scroll Down na página até seção do vídeo
    Execute Javascript    window.scrollBy(0,3300)
    Wait Until Element Is Visible    ${CONTAINER_VIDEO}

Clique para reproduzir o vídeo
    Click Element    ${REPRODUZIR_VIDEO}

Clique para pausar o vídeo
    Click Element    ${PAUSAR_VIDEO}

Clique para desligar/ligar o som do vídeo
    Click Element    ${VOLUME_SOM}

Verifique que o vídeo está sendo reproduzido
    ${valorTempoReproducao1}    Get Text    ${TEMPO_REPRODUCAO}
    Sleep    3s
    ${valorTempoReproducao2}    Get Text    ${TEMPO_REPRODUCAO}
    Should Not Be Equal    ${valorTempoReproducao1}    ${valorTempoReproducao2}

Verifique que o vídeo não está sendo reproduzido
    ${valorTempoReproducao1}    Get Text    ${TEMPO_REPRODUCAO}
    Sleep    3s
    ${valorTempoReproducao2}    Get Text    ${TEMPO_REPRODUCAO}
    Should Be Equal    ${valorTempoReproducao1}    ${valorTempoReproducao2}

Verifique que o som foi desligado
    ${VOLUME_SOM_DESLIGADO_CLASS}    Get Element Attribute    ${VOLUME_SOM}    class
    Should Contain    ${VOLUME_SOM_DESLIGADO_CLASS}    vjs-vol-0

Verifique que o som foi ligado
    ${VOLUME_SOM_LIGADO_CLASS}    Get Element Attribute    ${VOLUME_SOM}    class
    Should Not Contain    ${VOLUME_SOM_LIGADO_CLASS}    vjs-vol-0

Fechar Navegador
    Close Browser

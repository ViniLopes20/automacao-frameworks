*** Settings ***
Library     SeleniumLibrary


*** Variables ***
${BROWSER}              chrome
${URL}                  https://www.amazon.com.br/

${SECAO_OFERTAS_DIA}    xpath=//a[text()='Ofertas do Dia']


*** Keywords ***
Acessar Amazon
    Open Browser    ${URL}    ${BROWSER}
    Title Should Be    Amazon.com.br | Tudo pra você, de A a Z.

Abrir a seção Ofertas do Dia em uma nova aba do navegador
    Wait Until Element Is Visible    ${SECAO_OFERTAS_DIA}
    ${link}=    Get Element Attribute    ${SECAO_OFERTAS_DIA}    href
    Execute JavaScript    window.open('${link}');
    Wait Until Keyword Succeeds    30s    1s    nova aba está presente

nova aba está presente
    ${handles}=    Get Window Handles
    ${num_abas}=    Get Length    ${handles}
    IF    ${num_abas} < 2    Fail    Ainda não há segunda aba

Mudar para a aba "${NUMERO_ABA}"
    ${handles}=    Get Window Handles
    Switch Window    ${handles}[${NUMERO_ABA}]

Verificar que existem "${QUANTIDADE_ABAS_ESPERADAS}" aba aberta no navegador
    ${handles}=    Get Window Handles
    ${num_abas}=    Get Length    ${handles}
    IF    '${num_abas}' != '${QUANTIDADE_ABAS_ESPERADAS}'
        Fail    There should be exactly ${QUANTIDADE_ABAS_ESPERADAS} tabs open, but ${num_abas} are open.
    END

Verificar que está acessando a primeira aba
    Location Should Be    https://www.amazon.com.br/
    Title Should Be    Amazon.com.br | Tudo pra você, de A a Z.

Verificar que está acessando a segunda aba
    Location Should Be    https://www.amazon.com.br/deals?ref_=nav_cs_gb
    Title Should Be    Ofertas e Promoções | Amazon.com.br

Fechar Navegador
    Close Browser

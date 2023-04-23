*** Settings ***
Resource            diferentesDominiosResource.robot

Suite Setup         Acessar Google
Suite Teardown      Fechar Navegador


*** Test Cases ***
Acessar o site da amazon via serviço de busca
    Pesquisar o site da "Amazon"
    Selecionar o site da Amazon pelos resultados do Google
    Verificar que o site da Amazon foi carregado corretamente

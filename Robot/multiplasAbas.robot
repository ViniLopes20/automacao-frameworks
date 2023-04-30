*** Settings ***
Resource            multiplasAbasResource.robot

Suite Setup         Acessar Amazon
Suite Teardown      Fechar Navegador


*** Test Cases ***
Abrir um produto em uma nova aba
    Verificar que existem "1" aba aberta no navegador
    Abrir a seção Ofertas do Dia em uma nova aba do navegador
    Verificar que existem "2" aba aberta no navegador
    Mudar para a aba "0"
    Verificar que está acessando a primeira aba
    Mudar para a aba "1"
    Verificar que está acessando a segunda aba

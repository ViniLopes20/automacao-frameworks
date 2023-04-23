*** Settings ***
Resource            ResourceAmazon.robot

Suite Setup         Acessar Amazon
Suite Teardown      Fechar Navegador


*** Test Cases ***
Interagir com o menu tipo slider
    Click para voltar o anuncio da propaganda
    Verifique que o anuncio foi alterado para a propaganda "8"
    Click para avançar o anuncio da propaganda
    Verifique que o anuncio foi alterado para a propaganda "1"

Validar pesquisa de produto
    Pesquisar o produto "mx master 3"
    Clicar no produto primeiro produto encontrado
    Verifique que o produto "mx master 3" aparece no resultado da pesquisa

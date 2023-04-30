*** Settings ***
Resource            scrollDownUpPaginaResource.robot

Suite Setup         Acessar Amazon
Suite Teardown      Fechar Navegador


*** Test Cases ***
Scroll down e up na tela de um produto
    Scroll down na página até o fim da página
    Verificar que chegou no final da página
    Scroll up na página até o início da página
    Verificar que chegou no topo da página

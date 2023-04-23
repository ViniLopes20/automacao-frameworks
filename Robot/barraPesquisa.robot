*** Settings ***
Resource            barraPesquisaResource.robot

Suite Setup         Acessar Amazon
Suite Teardown      Fechar Navegador


*** Test Cases ***
Usar o filtro de busca antes de realizar uma pesquisa
    Seleciona a opção "12" do filtro de pesquisa
    Pesquisar o produto "Mac"
    Verifique que o produto "Apple notebook MacBook" aparece no resultado da pesquisa
    Verificar que "Computadores e Informática" é o departamento que esta sendo analisado
    Verificar que "Computadores e Informática" é o filtro que esta sendo usado
    Seleciona a opção "2" do filtro de pesquisa
    Pesquisar o produto "Mac"
    Verifique que o produto "Maçã Verde" aparece no resultado da pesquisa
    Verificar que "Alimentos e Bebidas" é o departamento que esta sendo analisado
    Verificar que "Alimentos e Bebidas" é o filtro que esta sendo usado

Auto Complete durante uma pesquisa
    Verificar a sugestão de auto complete para a pesquisa de "Logitech MX"
    Selecionar a sugestão logitech mx master 3s do auto complete da pesquisa
    Verifique que o produto "Mouse sem fio Logitech MX Master 3S" aparece no resultado da pesquisa

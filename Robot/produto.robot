*** Settings ***
Resource            produtoResource.robot

Suite Setup         Acessar Amazon
Suite Teardown      Fechar Navegador


*** Test Cases ***
Adicionar novos filtros para o resultado dos produtos
    Pesquisar o produto "Mac"
    Verifique que o produto "Apple notebook MacBook" aparece no resultado da pesquisa
    Verifique que o produto "Batom Mac" aparece no resultado da pesquisa
    Adicionar o filtro para a marca Logitech
    Verifique que o produto "Apple notebook MacBook" não aparece no resultado da pesquisa
    Verifique que o produto "Batom Mac" não aparece no resultado da pesquisa
    Verifique que o produto "Logitech Teclado mecânico" aparece no resultado da pesquisa
    Verifique que o produto "Logitech MX Master" aparece no resultado da pesquisa
    Adicionar o filtro para o valor de Até R$50
    Verificar que o valor dos três primeiros pedido são menores que "50" reais

Interagir com as funcionalidades do reprodutor de vídeo dos produtos
    Acessar o produto que possui um vídeo para ser reproduzido no site da Amazon
    Scroll Down na página até seção do vídeo
    Clique para reproduzir o vídeo
    Verifique que o vídeo está sendo reproduzido
    Clique para pausar o vídeo
    Verifique que o vídeo não está sendo reproduzido
    Clique para desligar/ligar o som do vídeo
    Verifique que o som foi desligado
    Clique para desligar/ligar o som do vídeo
    Verifique que o som foi ligado

Escrever uma avaliação para um produto
    Fazer Login com o email "test@hotmail.com" e a senha "test"
    Pesquisar o produto "logitech mx master 3s"
    Abrir o primeiro produto do resultado da pesquisa
    Clique no botão para escrever uma avaliação
    Escrever a avaliação do produto com o título "Test Avaliação" e os detalhes da avalição com "Muito bom Test"
    Enviar a avaliação
    Verificar que a avalição foi enviada com sucesso

describe('My First Test', () => {
  beforeEach(() => {
    cy.visit('https://amazon.com.br');
  });

  it('Teste para pesquisar um produto', () => {
    cy.get('.nav-search-field').type('Logitech mx master 3');

    cy.get('[id=nav-search-submit-text]').click();

    cy.get('[data-cel-widget="search_result_4"]').click();

    cy.get('[id="productTitle"]').should("contain.text", "Logitech MX Master 3");
  });

  it('Mudar a propaganda do menu tipo slider quando abre o site da Amazon', () => { 
    cy.get('[class="a-icon a-icon-previous-rounded"]').click();

    cy.get('[class="a-carousel-firstvisibleitem"][value="8"]').should("exist");

    cy.get('.a-carousel-goto-nextpage').click();

    cy.get('[class="a-carousel-firstvisibleitem"][value="1"]').should("exist");
  });

  it('Selecionar uma categoria para a pesquisa e verificar que os produtos exibidos são relacionados com a categoria escolhida', () => { 
    cy.get('[id="searchDropdownBox"]').select('Alimentos e Bebidas',{force: true});

    cy.get('.nav-search-field').type('Preto');

    cy.get('[id=nav-search-submit-text]').click();

    cy.get('[selected][value="search-alias=grocery"]').should("exist");

    cy.get('.a-list-item > .a-size-base').should("contain.text", "Alimentos e Bebidas");
    
    cy.get('[data-component-type="s-search-results"]').should("contain.text", "Uva Passas Preta");
  });
});
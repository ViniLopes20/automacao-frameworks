describe('Testes relacionados com a Barra de Pesquisa', () => {
  beforeEach(() => {
    cy.visit('https://amazon.com.br');
  });

  it('Usar o filtro de busca antes de realizar uma pesquisa', () => { 
      cy.get('[id="searchDropdownBox"]').select('Computadores e Informática',{force: true});
  
      cy.get('.nav-search-field').type('Mac');
  
      cy.get('[id=nav-search-submit-text]').click();
  
      cy.get('[selected][value="search-alias=computers"]').should("exist");
  
      cy.get('.a-list-item > .a-size-base').should("contain.text", "Computadores e Informática");
      
      cy.get('[data-component-type="s-search-results"]').should("contain.text", "Apple notebook MacBook");

      cy.get('[id="searchDropdownBox"]').select('Alimentos e Bebidas',{force: true});

      cy.get('[id=nav-search-submit-text]').click();

      cy.get('[selected][value="search-alias=grocery"]').should("exist");

      cy.get('.a-list-item > .a-size-base').should("contain.text", "Alimentos e Bebidas");

      cy.get('[data-component-type="s-search-results"]').should("contain.text", "Maçã Verde");
    });

    it('Auto Complete durante uma pesquisa', () => { 
      cy.get('.nav-search-field').type('Logitech MX');

      cy.get('.autocomplete-results-container').should("exist");

      cy.get('[aria-label="logitech mx master 3s"]').click();

      cy.get('[data-component-type="s-search-results"]').should("contain.text", "Mouse sem fio Logitech MX Master 3S");
    });
});
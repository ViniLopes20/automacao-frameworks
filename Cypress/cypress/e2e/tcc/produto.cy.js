describe('Testes relacionados com a lista de produtos', () => {
  beforeEach(() => {
    cy.visit('https://amazon.com.br');
  });

  it('Adicionar novos filtros para o resultado dos produtos', () => { 
    cy.get('.nav-search-field').type('Mac');

    cy.get('[id=nav-search-submit-text]').click();
    
    cy.get('[data-component-type="s-search-results"]').should("contain.text", "Apple notebook MacBook");

    cy.get('[data-component-type="s-search-results"]').should("contain.text", "Batom Mac");

    cy.get('a:contains(Logitech)[data-routing]').click();

    cy.get('[data-component-type="s-search-results"]').should("not.contain.text", "Apple notebook MacBook");

    cy.get('[data-component-type="s-search-results"]').should("not.contain.text", "Batom Mac");

    cy.get('[data-component-type="s-search-results"]').should("contain.text", "Logitech Teclado mecânico");

    cy.get('[data-component-type="s-search-results"]').should("contain.text", "Logitech MX Master");

    cy.contains('Até R$50').click();

    cy.get('.a-price-whole').eq(0).invoke('text').then((texto) => {
      const valorNumerico = parseInt(texto);
      expect(valorNumerico).to.be.lessThan(50);
    });

    cy.get('.a-price-whole').eq(1).invoke('text').then((texto) => {
      const valorNumerico = parseInt(texto);
      expect(valorNumerico).to.be.lessThan(50);
    });

    cy.get('.a-price-whole').eq(2).invoke('text').then((texto) => {
      const valorNumerico = parseInt(texto);
      expect(valorNumerico).to.be.lessThan(50);
    });
  });

  it('Escrever uma avaliação para um produto', () => { 
    cy.get('#nav-link-accountList').click();

    cy.get('#ap_email').type('test@hotmail.com');

    cy.get('.a-button-inner > #continue').click();

    cy.get('#ap_password').type('test');

    cy.get('#signInSubmit').click();

    cy.get('.nav-search-field').type('logitech mx master 3s');

    cy.get('[id=nav-search-submit-text]').click();

    cy.get('[data-cel-widget="search_result_3"]').click();

    cy.scrollTo(0, 7000);

    cy.get('[data-hook="write-review-button"]').click();

    cy.get(':nth-child(5) > .ryp__review-stars__star').click();

    cy.get('#scarface-review-title-label').type('Test Avaliação');

    cy.get('input[type="file"]').selectFile('/home/me/Vinicius/automacao.png', { force: true });

    cy.get('#scarface-review-text-card-title').type('Muito bom Test');

    cy.get('.a-button-text').should('be.enabled').click();

    cy.get('.a-alert-success').should("exist");
  });
});
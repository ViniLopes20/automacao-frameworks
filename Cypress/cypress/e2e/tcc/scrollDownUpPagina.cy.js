describe('Testes relacionados com Scroll na tela', () => {
  beforeEach(() => {
    cy.visit('https://amazon.com.br');
  });

  it('Scroll down e up na tela de um produto', () => { 
    cy.window().then((win) => {
      const scrollHeight = win.document.documentElement.scrollHeight;

      cy.scrollTo('bottom');

      cy.window().its('scrollY').should('be.closeTo', scrollHeight - win.innerHeight, 300);
    });

    cy.scrollTo('top');

    cy.window().its('scrollY').should('eq', 0);
  });
});
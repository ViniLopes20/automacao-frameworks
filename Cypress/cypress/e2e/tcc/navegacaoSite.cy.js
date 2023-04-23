describe('Testes relacionados com navegação pelo site', () => {
    beforeEach(() => {
      cy.visit('https://amazon.com.br');
    });
  
    it('Navegar pelo pelo menu de navegação lateral', () => { 
        cy.get('#nav-hamburger-menu').click();

        cy.get('.hmenu-compressed-btn').first().click();

        cy.contains('Games e Consoles').click();

        cy.contains('Tudo em Games e Consoles').click();

        cy.title().should('eq', 'Games e Consoles | Amazon.com.br');

        cy.get('[selected][value="search-alias=videogames"]').should("exist");
        
        cy.get('.a-list-item > .a-size-base').should("contain.text", "Games e Consoles");

      });
  });
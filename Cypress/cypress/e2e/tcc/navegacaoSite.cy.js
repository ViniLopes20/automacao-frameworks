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

    it('Navegar pelo menu suspenso das opções do usuário', () => {
      cy.get('#nav-link-accountList').click();

      cy.get('#ap_email').type('test@hotmail.com');

      cy.get('.a-button-inner > #continue').click();

      cy.get('#ap_password').type('test');

      cy.get('#signInSubmit').click();

      cy.get('#nav-link-accountList').trigger('mouseover');

      cy.get('[id="nav_prefetch_yourorders"]').click();

      cy.get('h1').should('contain', 'Seus pedidos');

      cy.url().should('include', 'AccountFlyout_orders')
    });

    it('Interagir com o modal de endereços salvos', () => {
      cy.get('#nav-link-accountList').click();

      cy.get('#ap_email').type('test@hotmail.com');

      cy.get('.a-button-inner > #continue').click();

      cy.get('#ap_password').type('test');

      cy.get('#signInSubmit').click();

      const endereco1 = cy.get('#glow-ingress-line2').invoke('text');

      cy.get('#nav-global-location-popover-link').click();

      cy.get(':nth-child(1) > .a-list-item > .a-button').should("exist");

      cy.get(':nth-child(2) > .a-list-item > .a-button').should("exist");

      cy.get(':nth-child(2) > .a-list-item > .a-button').click();

      const endereco2 = cy.get('#glow-ingress-line2').invoke('text');
      
      expect(endereco1).not.equal(endereco2);

      cy.get('#nav-global-location-popover-link').click();

      cy.get('#GLUXZipUpdateInput_0').type('50050');

      cy.get('#GLUXZipUpdateInput_1').type('900');

      cy.get('#GLUXZipUpdate').click();

      const endereco3 = cy.get('#glow-ingress-line2').invoke('text');

      expect(endereco2).not.equal(endereco3);

      cy.get('#nav-global-location-popover-link').click();

      cy.get('#GLUXZipUpdateInput_0').clear();

      cy.get('#GLUXZipUpdateInput_0').type('00000');

      cy.get('#GLUXZipUpdate').click();

      cy.get('#GLUXZipError').should('be.visible');
    });
  });
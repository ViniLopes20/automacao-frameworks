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

    cy.get('[data-component-type="s-search-results"]').should("contain.text", "Teclado sem fio Logitech");

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

  it('Interagir com as funcionalidades do reprodutor de vídeo dos produtos', () => {
    cy.visit('https://www.amazon.com.br/Logitech-MX-Master-3S-Superf%C3%ADcie/dp/B0B11LJ69K/ref=sr_1_2?__mk_pt_BR=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=EY6N70D07TZP&keywords=logitech+mx+master+3s&qid=1682869534&sprefix=logitech+mx+master+3s%2Caps%2C251&sr=8-2&ufe=app_do%3Aamzn1.fos.25548f35-0de7-44b3-b28e-0f56f3f96147');

    cy.scrollTo(0, 4200);

    cy.get('.vjs-big-play-button').click();

    cy.get('.vjs-remaining-time').invoke('text').then((valorTempoReproducao1) => {
      cy.wait(3000);
      cy.get('.vjs-remaining-time').invoke('text').then((valorTempoReproducao2) => {
        assert.notEqual(valorTempoReproducao1, valorTempoReproducao2, 'Os valores das variáveis são iguais');
      });
    });

    cy.get('[title="Pause"]').click();

    cy.get('.vjs-remaining-time').invoke('text').then((valorTempoPausado1) => {
      cy.wait(2000);
      cy.get('.vjs-remaining-time').invoke('text').then((valorTempoPausado2) => {
        expect(valorTempoPausado1).to.equal(valorTempoPausado2);
      });
    });

    cy.get('.vjs-mute-control').click();

    cy.get('.vjs-mute-control').should('have.class', 'vjs-vol-0');

    cy.get('.vjs-mute-control').click();

    cy.get('.vjs-mute-control').should('not.have.class', 'vjs-vol-0');
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

    cy.get('input[type="file"]').selectFile('/home/me/Vinicius/automacao-frameworks/automacao.png', { force: true });

    cy.get('#scarface-review-text-card-title').type('Muito bom Test');

    cy.get('.a-button-text').should('be.enabled').click();

    cy.get('.a-alert-success').should("exist");
  });
});
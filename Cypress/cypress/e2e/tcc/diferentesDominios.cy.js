describe('Testes relacionados com mudança de domínio durante a execução dos testes', () => {
  beforeEach(() => {
    cy.visit('https://google.com.br');
  });

  it('Acessar o site da amazon via serviço de busca', () => { 
    cy.get('[type="search"]').type('Amazon{enter}');

    cy.get('[href="https://www.amazon.com.br/"]').first().click();

    cy.get('[aria-label="Amazon.com.br"]').should("exist");

    cy.get('[id="twotabsearchtextbox"]').should("exist");

    // cy.origin('somesite.com', () => {
    //   cy.visit('https://amazon.com.br');
    // });
  });
});
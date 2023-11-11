describe('home page', () => {

    it('can visit the homepage', () => {
        cy.visit('/')
    });

    it('can add product to the cart and count of the cart increases', () => {
        cy.contains('My Cart (0)')
        cy.contains('Add').first().click({force:true})
        cy.contains('My Cart (1)')
    });
});
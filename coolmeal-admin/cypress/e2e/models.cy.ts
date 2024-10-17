// cypress/e2e/models.cy.ts
describe("Models Page Load Test", () => {
  beforeEach(() => {
    // Navigate to the models page
    cy.visit("/dashboard/model");
  });

  it("should load the Models page and display the Models component", () => {
    // Assert that the Models component is rendered
    cy.contains("Models").should("exist");
  });
});

// cypress/e2e/meals.cy.ts
describe("Meals Page Load Test", () => {
  beforeEach(() => {
    // Navigate to the meals page
    cy.visit("/dashboard/meals");
  });

  it("should load the Meals page and display the MealTable component", () => {
    // Assert that the MealTable component is rendered
    cy.get('[data-testid="meal-table"]').should("exist"); // Ensure MealTable is rendered
  });
});

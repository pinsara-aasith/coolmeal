describe("Users Page Load Test", () => {
  beforeEach(() => {
    // Navigate to the users page
    cy.visit("/dashboard/users");
  });

  it("should load the Users page and display the UserTable component", () => {
    // Check that the UserTable component is rendered
    cy.get('[data-testid="user-table"]').should("exist"); // Ensure UserTable is rendered
  });
});

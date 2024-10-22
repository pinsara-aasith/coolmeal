describe("User Table Tests", () => {
  beforeEach(() => {
    // Intercept the API call to mock the user data response
    cy.intercept("GET", "api/dashboard/users", {
      statusCode: 200,
      body: [
        {
          id: "1",
          name: "Alice Johnson",
          email: "alice@example.com",
          gender: "female",
        },
        {
          id: "2",
          name: "Bob Smith",
          email: "bob@example.com",
          gender: "male",
        },
        {
          id: "3",
          name: "Charlie Brown",
          email: "charlie@example.com",
          gender: "male",
        },
      ],
    }).as("getUsers");

    // Visit the user table page
    cy.visit("/dashboard/users");
  });

  it("Loads the user table and displays users correctly", () => {
    // Wait for the API request to finish
    cy.wait("@getUsers");

    // Check that the search bar is visible
    cy.get('input[placeholder="Search for user"]').should("be.visible");

    // Check if the user data table loads correctly
    cy.get("table").should("be.visible");

    // Check that user names, emails, and genders are displayed correctly
    cy.get("tbody tr").should("have.length", 3); // Should show 3 users
    cy.get("tbody tr").eq(0).should("contain", "Alice Johnson");
    cy.get("tbody tr").eq(1).should("contain", "Bob Smith");
    cy.get("tbody tr").eq(2).should("contain", "Charlie Brown");

    // Check the badges (gender display)
    cy.get("tbody tr").eq(0).should("contain", "female");
    cy.get("tbody tr").eq(1).should("contain", "male");
  });

  it("Searches for users and filters results", () => {
    // Wait for the users to be fetched
    cy.wait("@getUsers");

    // Search for "Alice"
    cy.get('input[placeholder="Search for user"]').type("Alice");

    // Check that only Alice is displayed
    cy.get("tbody tr").should("have.length", 1);
    cy.get("tbody tr").eq(0).should("contain", "Alice Johnson");

    // Search for "Bob"
    cy.get('input[placeholder="Search for user"]').clear().type("Bob");

    // Check that only Bob is displayed
    cy.get("tbody tr").should("have.length", 1);
    cy.get("tbody tr").eq(0).should("contain", "Bob Smith");
  });

  it("Checks the user profile link works correctly", () => {
    // Wait for the API request to finish
    cy.wait("@getUsers");

    // Check that each user row contains a valid link to the user profile
    cy.get("tbody tr")
      .eq(0)
      .find("a")
      .should("have.attr", "href", "/dashboard/users/1");
    cy.get("tbody tr")
      .eq(1)
      .find("a")
      .should("have.attr", "href", "/dashboard/users/2");
    cy.get("tbody tr")
      .eq(2)
      .find("a")
      .should("have.attr", "href", "/dashboard/users/3");
  });
});

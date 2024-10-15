// cypress/e2e/login.cy.ts

describe("Admin Login Page Tests", () => {
  beforeEach(() => {
    // Visit the login page before each test
    cy.visit("login"); // Update this if the URL is different
  });

  it("Displays login page correctly", () => {
    // Check if the login page elements are displayed correctly
    cy.get('input[id="email"]').should("be.visible");
    cy.get('input[id="password"]').should("be.visible");
    cy.get('button[type="submit"]').should("contain", "Login");
    cy.get('a[href="#"]').should("contain", "Forgot password?");
  });

  it("Fails login with invalid credentials", () => {
    // Attempt to log in with invalid credentials
    cy.get('input[id="email"]').type("invaliduser@example.com");
    cy.get('input[id="password"]').type("wrongpassword");
    cy.get('button[type="submit"]').click();

    // Assert that an error message is shown (you can adjust this based on your toast/snackbar)
    cy.get("body").should("contain", "Check your Credentials");
  });

  it("Logs in successfully with valid credentials", () => {
    // Intercept the NextAuth or login API request
    cy.intercept("POST", "/api/auth/**").as("loginRequest");

    // Type in valid credentials
    cy.get('input[id="email"]').type("a@gmail.com");
    cy.get('input[id="password"]').type("123456");
    cy.get('button[type="submit"]').click();

    // Wait for the login request to finish before asserting the URL change
    cy.wait("@loginRequest").then(() => {
      cy.url().should("include", "/dashboard");
      cy.get("body").should("contain", "Login successful!");
    });
  });

  it("Displays forgot password link", () => {
    // Check if the forgot password link is visible and correct
    cy.get('a[href="#"]')
      .should("be.visible")
      .and("contain", "Forgot password?");
  });

  it("Disables login button while logging in", () => {
    // Type in valid credentials
    cy.get('input[id="email"]').type("a@gmail.com");
    cy.get('input[id="password"]').type("123456");
    cy.get('button[type="submit"]').click();

    // Assert that the button is disabled while loading
    cy.get('button[type="submit"]').should("contain", "Logging in...");
  });
});

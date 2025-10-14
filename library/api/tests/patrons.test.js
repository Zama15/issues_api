import request from "supertest";
import app from "../index.js";
import { faker } from "@faker-js/faker";

describe("Patrons API", () => {
  let newPatronData;

  beforeAll(() => {
    newPatronData = {
      universityId: parseInt(`19${faker.string.numeric(6)}`),
      firstName: faker.person.firstName(),
      lastName: faker.person.lastName(),
      email: faker.internet.email(),
      patronTypeId: 1,
    };
  });

  describe("POST /patrons", () => {
    it("should create a new patron successfully", async () => {
      const response = await request(app).post("/patrons").send(newPatronData);

      expect(response.status).toBe(201);
      expect(response.body.success).toBe(true);
      expect(response.body.message).toBe("Patron created successfully.");
    });

    it("should fail if a patron with the same universityId already exists", async () => {
      const response = await request(app).post("/patrons").send(newPatronData);

      expect(response.status).toBe(409); // Conflict
      expect(response.body.success).toBe(false);
      expect(response.body.error).toContain("already exists");
    });

    it("should fail if required fields are missing", async () => {
      const response = await request(app)
        .post("/patrons")
        .send({ firstName: "Test", lastName: "User" });

      expect(response.status).toBe(400);
      expect(response.body.success).toBe(false);
      expect(response.body.error).toContain("Missing required fields");
    });
  });

  describe("GET /patrons/:id/loans/count", () => {
    it("should return the active loan count for a patron", async () => {
      const patronId = 1;

      const response = await request(app).get(
        `/patrons/${patronId}/loans/count`
      );

      expect(response.status).toBe(200);
      expect(response.body.success).toBe(true);
      expect(response.body.data).toHaveProperty("patronId", patronId);
      expect(response.body.data).toHaveProperty("activeLoans");
      expect(typeof response.body.data.activeLoans).toBe("number");
    });
  });
});

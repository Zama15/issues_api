import request from "supertest";
import app from "../index.js";

describe("Loans API", () => {
  const testData = {
    itemCopyId: 2,
    patronId: 1,
    staffId: 1,
  };

  describe("POST /loans (Checkout)", () => {
    it("should successfully create a loan for an available item", async () => {
      const response = await request(app).post("/loans").send(testData);

      expect(response.status).toBe(201);
      expect(response.body.success).toBe(true);
    });

    it("should fail to create a loan for the same item copy (since it is now on loan)", async () => {
      const response = await request(app).post("/loans").send(testData);

      expect(response.status).toBe(400);
      expect(response.body.success).toBe(false);
      expect(response.body.error).toContain("Item is not available for loan.");
    });
  });

  describe("PUT /loans/return", () => {
    it("should successfully process the return of a loaned item", async () => {
      const response = await request(app).put("/loans/return").send({
        itemCopyId: testData.itemCopyId,
        staffId: testData.staffId,
      });

      expect(response.status).toBe(200);
      expect(response.body.success).toBe(true);
    });

    it("should fail to return the same item copy again (as there is no active loan)", async () => {
      const response = await request(app).put("/loans/return").send({
        itemCopyId: testData.itemCopyId,
        staffId: testData.staffId,
      });

      expect(response.status).toBe(400);
      expect(response.body.success).toBe(false);
      expect(response.body.error).toContain("No active loan found");
    });
  });

  describe("GET /loans/active-count", () => {
    it("should return the total number of active loans", async () => {
      const response = await request(app).get("/loans/active-count");

      expect(response.status).toBe(200);
      expect(response.body.success).toBe(true);
      expect(response.body.data).toHaveProperty("totalActiveLoans");
      expect(typeof response.body.data.totalActiveLoans).toBe("number");
    });
  });
});

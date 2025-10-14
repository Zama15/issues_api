import request from "supertest";
import app from "../index.js";
import { faker } from "@faker-js/faker";

describe("Items API", () => {
  describe("POST /items", () => {
    it("should create a new item successfully with required fields", async () => {
      const newItemData = {
        title: faker.lorem.words(3).replace(/\b\w/g, (l) => l.toUpperCase()),
        languageId: 1,
        itemTypeId: 1,
        isbn: faker.commerce.isbn({ variant: 13, separator: "" }),
      };

      const response = await request(app).post("/items").send(newItemData);

      expect(response.status).toBe(201);
      expect(response.body.success).toBe(true);
      expect(response.body.message).toBe("Item created successfully.");
    });

    it("should fail to create an item if required fields are missing", async () => {
      const incompleteData = {
        title: "Incomplete Book",
      };

      const response = await request(app).post("/items").send(incompleteData);

      expect(response.status).toBe(400);
      expect(response.body.success).toBe(false);
      expect(response.body.error).toContain("Missing required fields");
    });
  });

  describe("GET /items/copies/:id/available", () => {
    it("should return the availability status of an item copy", async () => {
      const itemCopyId = 1;

      const response = await request(app).get(
        `/items/copies/${itemCopyId}/available`
      );

      expect(response.status).toBe(200);
      expect(response.body.success).toBe(true);
      expect(response.body.data).toHaveProperty("itemCopyId", itemCopyId);
      expect(response.body.data).toHaveProperty("isAvailable");
    });

    it("should return an error for a non-numeric item copy ID", async () => {
      const invalidId = "abc";
      const response = await request(app).get(
        `/items/copies/${invalidId}/available`
      );

      expect(response.status).toBe(400);
      expect(response.body.error).toBe("Item copy ID must be a number.");
    });
  });
});

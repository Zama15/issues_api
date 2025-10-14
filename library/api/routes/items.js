import express from "express";
import { connection } from "../config.db.js";

const router = express.Router();

/**
 * @route   POST /items
 * @desc    Create a new library item
 */
router.post("/", (req, res) => {
  // Basic validation for required fields
  const { title, languageId, itemTypeId, ...optionalFields } = req.body;

  if (!title || !languageId || !itemTypeId) {
    return res.status(400).json({
      success: false,
      error:
        "Missing required fields: title, languageId, itemTypeId are required.",
    });
  }

  const params = [
    title,
    languageId,
    itemTypeId,
    optionalFields.publisherId ?? null,
    optionalFields.publicationDate ?? null,
    optionalFields.edition ?? null,
    optionalFields.isbn ?? null,
    optionalFields.issn ?? null,
    optionalFields.deweyDecimalCode ?? null,
    optionalFields.seriesId ?? null,
    optionalFields.description ?? null,
    optionalFields.tableOfContents
      ? JSON.stringify(optionalFields.tableOfContents)
      : null,
  ];

  connection.query(
    "CALL sp_create_new_item(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
    params,
    (error, results) => {
      if (error) {
        return res.status(500).json({
          success: false,
          error:
            error.sqlMessage || "An error occurred while creating the item.",
        });
      }
      res.status(201).json({
        success: true,
        message: "Item created successfully.",
      });
    }
  );
});

/**
 * @route   GET /items/copies/:id/available
 * @desc    Check if a specific item copy is available
 */
router.get("/copies/:id/available", (req, res) => {
  const { id } = req.params;
  if (isNaN(id)) {
    return res
      .status(400)
      .json({ success: false, error: "Item copy ID must be a number." });
  }

  connection.query(
    "SELECT fn_is_item_copy_available(?) AS isAvailable",
    [id],
    (error, results) => {
      if (error) {
        return res.status(500).json({
          success: false,
          error: "An error occurred while checking item availability.",
        });
      }

      const isAvailable = results[0].isAvailable;

      res.status(200).json({
        success: true,
        data: {
          itemCopyId: parseInt(id, 10),
          isAvailable: Boolean(isAvailable),
        },
      });
    }
  );
});

export default router;

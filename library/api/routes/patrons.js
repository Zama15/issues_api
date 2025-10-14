import express from "express";
import { connection } from "../config.db.js";

const router = express.Router();

/**
 * @route   POST /patrons
 * @desc    Create a new patron
 */
router.post("/", (req, res) => {
  const { universityId, firstName, lastName, email, patronTypeId } = req.body;
  if (!universityId || !firstName || !lastName || !email || !patronTypeId) {
    return res.status(400).json({
      success: false,
      error:
        "Missing required fields: universityId, firstName, lastName, email, and patronTypeId are required.",
    });
  }

  const params = [universityId, firstName, lastName, email, patronTypeId];

  connection.query(
    "CALL sp_create_new_patron(?, ?, ?, ?, ?)",
    params,
    (error, results) => {
      if (error) {
        if (error.code === "ER_DUP_ENTRY") {
          return res.status(409).json({
            success: false,
            error: "A patron with this University ID or Email already exists.",
          });
        }
        return res.status(500).json({
          success: false,
          error:
            error.sqlMessage || "An error occurred while creating the patron.",
        });
      }
      res.status(201).json({
        success: true,
        message: "Patron created successfully.",
      });
    }
  );
});

/**
 * @route   GET /patrons/:id/loans/count
 * @desc    Get the active loan count for a specific patron
 */
router.get("/:id/loans/count", (req, res) => {
  const { id } = req.params;
  if (isNaN(id)) {
    return res
      .status(400)
      .json({ success: false, error: "Patron ID must be a number." });
  }

  connection.query(
    "SELECT fn_calculate_patron_loan_count(?) AS activeLoans",
    [id],
    (error, results) => {
      if (error) {
        return res.status(500).json({
          success: false,
          error: "An error occurred while fetching the loan count.",
        });
      }

      const activeLoans = results[0].activeLoans;

      res.status(200).json({
        success: true,
        data: {
          patronId: parseInt(id, 10),
          activeLoans: activeLoans,
        },
      });
    }
  );
});

export default router;

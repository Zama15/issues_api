import express from "express";
import { connection } from "../config.db.js";

const router = express.Router();

/**
 * @route   POST /loans
 * @desc    Create a new loan (checkout an item)
 * @access  Private (Staff)
 */
router.post("/", (req, res) => {
  const { itemCopyId, patronId, staffId } = req.body;
  if (!itemCopyId || !patronId || !staffId) {
    return res.status(400).json({
      success: false,
      error:
        "Missing required fields: itemCopyId, patronId, and staffId are required.",
    });
  }

  connection.query(
    "CALL sp_make_loan(?, ?, ?)",
    [itemCopyId, patronId, staffId],
    (error, results) => {
      if (error) {
        // The procedure signals a '45000' state for business rule violations
        if (error.sqlState === "45000") {
          return res
            .status(400)
            .json({ success: false, error: error.sqlMessage });
        }
        return res.status(500).json({
          success: false,
          error: "An unexpected error occurred while processing the loan.",
        });
      }
      res.status(201).json({
        success: true,
        message: "Loan processed successfully.",
      });
    }
  );
});

/**
 * @route   PUT /loans/return
 * @desc    Return a loaned item
 * @access  Private (Staff)
 */
router.put("/return", (req, res) => {
  const { itemCopyId, staffId, fineAmountPerDay } = req.body;
  if (!itemCopyId || !staffId) {
    return res.status(400).json({
      success: false,
      error: "Missing required fields: itemCopyId and staffId are required.",
    });
  }

  connection.query(
    "CALL sp_return_loan(?, ?, ?)",
    [itemCopyId, staffId, fineAmountPerDay ?? null],
    (error, results) => {
      if (error) {
        if (error.sqlState === "45000") {
          return res
            .status(400)
            .json({ success: false, error: error.sqlMessage });
        }
        return res.status(500).json({
          success: false,
          error: "An unexpected error occurred while processing the return.",
        });
      }
      res.status(200).json({
        success: true,
        message: "Return processed successfully.",
      });
    }
  );
});

/**
 * @route   GET /loans/active-count
 * @desc    Get the total count of all active loans in the system
 * @access  Private (Staff)
 */
router.get("/active-count", (req, res) => {
  connection.query(
    "SELECT fn_get_total_active_loans() AS totalActiveLoans",
    (error, results) => {
      if (error) {
        return res.status(500).json({
          success: false,
          error: "An error occurred while fetching the total active loans.",
        });
      }
      const totalActiveLoans = results[0].totalActiveLoans;
      res.status(200).json({
        success: true,
        data: {
          totalActiveLoans,
        },
      });
    }
  );
});

export default router;

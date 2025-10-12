const express = require("express");
const app = express();

const dotenv = require("dotenv");
dotenv.config();

app.use(express.json());

const { connection } = require("../config.db");

const getCountByTypeId = (request, response) => {
  const iIdIssueType = request.params.id;

  connection.query(
    `CALL countIssuesByIdIssueTypes(?)`,
    [iIdIssueType],
    (error, result) => {
      if (error) throw error;

      response.status(200).json(result[0][0]);
    }
  );
};

const getCountWithoutContent = (request, response) => {
  connection.query(`CALL countIssuesWithoutContent()`, (error, result) => {
    if (error) throw error;

    response.status(200).json(result[0][0]);
  });
};

const getAllAfterDate = (request, response) => {
  const dateParam = request.params.date;
  const date = new Date(dateParam);

  connection.query(`CALL getIssuesAfterDate(?)`, [date], (error, results) => {
    if (error) {
      if (error.code === "ER_TRUNCATED_WRONG_VALUE")
        return response.status(400).json({
          error:
            "Formato de fecha invalido (e.g. 2025-04-10, 2025-04-10T20:00:00.000Z).",
        });

      throw error;
    }

    if (results[0].lenght === 0) {
      return response
        .status(404)
        .json({ mensaje: "Incidencias no encontradas" });
    }

    response.status(200).json(results[0]);
  });
};

const getWithMostContent = (request, response) => {
  connection.query(`CALL getIssueWithMaxContent()`, (error, result) => {
    if (error) throw error;

    response.status(200).json(result[0][0]);
  });
};

const getOrderByDate = (request, response) => {
  connection.query(`CALL getIssuesOrderByDate()`, (error, results) => {
    if (error) throw error;

    if (results[0].lenght === 0) {
      return response
        .status(404)
        .json({ mensaje: "Incidencias no encontradas" });
    }

    response.status(200).json(results[0]);
  });
};

const getSearch = (request, response) => {
  const keyword = request.query.q;

  if (!keyword || keyword === "" || keyword === " ") {
    return response.status(400).json({
      error: "Palabra clave no valida o no establecida.",
    });
  }

  connection.query(
    `CALL searchIssuesByContent(?)`,
    [keyword],
    (error, results) => {
      if (error) throw error;

      if (results[0].lenght === 0) {
        return response
          .status(404)
          .json({ mensaje: "Incidencias no encontradas" });
      }

      response.status(200).json(results[0]);
    }
  );
};

const patchStatus = (request, response) => {
  const iIdIssue = request.params.id;

  const { eStatus } = request.body;

  connection.query(
    `CALL updateIssueStatusById(?,?)`,
    [iIdIssue, eStatus],
    (error, result) => {
      if (error) throw error;

      response.status(200).json({
        "Incidencia actualizada correctamente": result.affectedRows,
      });
    }
  );
};

const patchContent = (request, response) => {
  const iIdIssue = request.params.id;

  const { sIssueContent } = request.body;

  connection.query(
    `CALL updateIssueContentById(?,?)`,
    [iIdIssue, sIssueContent],
    (error, result) => {
      if (error) throw error;

      response.status(200).json({
        "Incidencia actualizada correctamente": result.affectedRows,
      });
    }
  );
};

const patchBulkOldForReviewToCancelled = (request, response) => {
  connection.query(
    `CALL updateOldForReviewIssuesToCancelled()`,
    (error, result) => {
      if (error) throw error;

      response.status(200).json({
        "Incidencias actualizadas correctamente": result.affectedRows,
      });
    }
  );
};

const deleteBulkCancelled = (request, response) => {
  connection.query(`CALL deleteCancelledIssues()`, (error, result) => {
    if (error) throw error;

    response.status(200).json({
      "Incidencias eliminadas correctamente": result.affectedRows,
    });
  });
};

app.route("/issues/count/by-type/:id").get(getCountByTypeId);
app.route("/issues/count/without-content").get(getCountWithoutContent);
app.route("/issues/after/:date").get(getAllAfterDate);
app.route("/issues/with-max-content").get(getWithMostContent);
app.route("/issues/order-by-date").get(getOrderByDate);
app.route("/issues/search").get(getSearch);

app.route("/issues/:id/status").patch(patchStatus);
app.route("/issues/:id/content").patch(patchContent);

app
  .route("/issues/bulk/old-for-review-to-cancelled")
  .patch(patchBulkOldForReviewToCancelled);

app.route("/issues/bulk/cancelled").delete(deleteBulkCancelled);

module.exports = app;

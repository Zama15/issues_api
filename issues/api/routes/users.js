const express = require("express");
const app = express();

const dotenv = require("dotenv");
dotenv.config();

const bcrypt = require("bcrypt");
app.use(express.json());

const { connection } = require("../config.db");

const getUsers = (request, respose) => {
  connection.query(
    `SELECT
      iIdUsers,
      sFullNameUsers,
      iEnrollmentUsers,
      sGender,
      sInstitutionalEmail,
      sPhone,
      sLocation
    FROM Users
    WHERE
      bStateUsers = TRUE`,
    (error, results) => {
      if (error) throw error;

      if (results.lenght === 0) {
        return respose
          .status(404)
          .json({ mensaje: "No hay informacion registrada" });
      }

      respose.status(200).json(results);
    }
  );
};

const getUserById = (request, response) => {
  const id = request.params.id;

  connection.query(
    `SELECT
      iIdUsers,
      sFullNameUsers,
      iEnrollmentUsers,
      sGender,
      sInstitutionalEmail,
      sPhone,
      sLocation
    FROM Users
    WHERE
      iIdUsers = ?`,
    [id],
    (error, results) => {
      if (error) throw error;

      if (results.lenght === 0) {
        return response.status(404).json({ mensaje: "Usuario no encontrado" });
      }

      response.status(200).json(results[0]);
    }
  );
};

const postUser = async (request, response) => {
  try {
    const {
      sFullNameUsers,
      iEnrollmentUsers,
      sPasswordUser,
      sGender,
      sInstitutionalEmail,
      sPhone,
      sLocation,
    } = request.body;

    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(sPasswordUser, saltRounds);
    const now = new Date();

    connection.query(
      `INSERT
      INTO Users
        (sFullNameUsers,
        iEnrollmentUsers,
        sPasswordUser,
        sGender,
        sInstitutionalEmail,
        sPhone,
        sLocation,
        dtUpdatedAtUsers
        )
      Values (?,?,?,?,?,?,?,?)`,
      [
        sFullNameUsers,
        iEnrollmentUsers,
        hashedPassword,
        sGender,
        sInstitutionalEmail,
        sPhone,
        sLocation,
        now,
      ],
      (error, results) => {
        if (error) throw error;

        response
          .status(201)
          .json({ "Usuario agregado correctamente": results.affectedRows });
      }
    );
  } catch (error) {
    console.error("Error al insertar usuario", error);
  }
};

const putUser = async (request, response) => {
  try {
    const iIdUsers = request.params.id;

    const {
      sFullNameUsers,
      iEnrollmentUsers,
      sPasswordUser,
      sGender,
      sInstitutionalEmail,
      sPhone,
      sLocation,
    } = request.body;

    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(sPasswordUser, saltRounds);
    const now = new Date();

    connection.query(
      `UPDATE Users
      SET
        sFullNameUsers = ?,
        iEnrollmentUsers = ?,
        sPasswordUser = ?,
        sGender = ?,
        sInstitutionalEmail = ?,
        sPhone = ?,
        sLocation = ?,
        dtUpdatedAtUsers = ?
      WHERE iIdUsers = ?`,
      [
        sFullNameUsers,
        iEnrollmentUsers,
        hashedPassword,
        sGender,
        sInstitutionalEmail,
        sPhone,
        sLocation,
        now,
        iIdUsers,
      ],
      (error, results) => {
        if (error) throw error;

        response
          .status(200)
          .json({ "Usuario actualizado correctamente": results.affectedRows });
      }
    );
  } catch (error) {
    console.error("Error al actualizar el usuario", error);
  }
};

const deleteUser = async (request, response) => {
  try {
    const iIdUsers = request.params.id;
    const now = new Date();

    connection.query(
      `UPDATE Users
      SET
        bStateUsers = ?,
        dtUpdatedAtUsers = ?
      WHERE iIdUsers = ?`,
      [false, now, iIdUsers],
      (error, results) => {
        if (error) throw error;

        response
          .status(200)
          .json({ "Usuario eliminado correctamente": results.affectedRows });
      }
    );
  } catch (error) {
    console.error("Error al actualizar el usuario", error);
  }
};

const getUsersSP = (request, response) => {
  connection.query("CALL getAllUsers()", (error, results) => {
    if (error) throw error;

    if (results.lenght === 0) {
      return respose
        .status(404)
        .json({ mensaje: "No hay informacion registrada" });
    }

    response.status(200).json(results[0]);
  });
};

const getUserByIdSP = (request, response) => {
  const id = request.params.id;

  connection.query(`CALL getUserById(?)`, [id], (error, result) => {
    if (error) throw error;

    if (result[0].lenght === 0) {
      return response.status(404).json({ mensaje: "Usuario no encontrado" });
    }

    response.status(200).json(result[0][0]);
  });
};

const postUserSP = async (request, response) => {
  try {
    const {
      sFullNameUsers,
      iEnrollmentUsers,
      sPasswordUser,
      sGender,
      sInstitutionalEmail,
      sPhone,
      sLocation,
    } = request.body;

    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(sPasswordUser, saltRounds);

    connection.query(
      `CALL insertUser(?,?,?,?,?,?,?)`,
      [
        sFullNameUsers,
        iEnrollmentUsers,
        hashedPassword,
        sGender,
        sInstitutionalEmail,
        sPhone,
        sLocation,
      ],
      (error, result) => {
        if (error) throw error;

        response
          .status(201)
          .json({ "Usuario agregado correctamente": result.affectedRows });
      }
    );
  } catch (error) {
    console.error("Error al insertar usuario", error);
  }
};

const putUserSP = async (request, response) => {
  try {
    const iIdUsers = request.params.id;

    const {
      sFullNameUsers,
      iEnrollmentUsers,
      sPasswordUser,
      sGender,
      sInstitutionalEmail,
      sPhone,
      sLocation,
    } = request.body;

    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(sPasswordUser, saltRounds);

    connection.query(
      `CALL updateUser(?,?,?,?,?,?,?,?)`,
      [
        iIdUsers,
        sFullNameUsers,
        iEnrollmentUsers,
        hashedPassword,
        sGender,
        sInstitutionalEmail,
        sPhone,
        sLocation,
      ],
      (error, result) => {
        if (error) throw error;

        response.status(200).json({
          "Usuario actualizado correctamente": result.affectedRows,
        });
      }
    );
  } catch (error) {
    console.error("Error al actualizar el usuario", error);
  }
};

const deleteUserSP = async (request, response) => {
  try {
    const iIdUsers = request.params.id;

    connection.query(`CALL deleteUser(?)`, [iIdUsers], (error, result) => {
      if (error) throw error;

      response
        .status(200)
        .json({ "Usuario eliminado correctamente": result.affectedRows });
    });
  } catch (error) {
    console.error("Error al actualizar el usuario", error);
  }
};

app.route("/users").get(getUsers);
app.route("/sp/users").get(getUsersSP);

app.route("/users/:id").get(getUserById);
app.route("/sp/users/:id").get(getUserByIdSP);

app.route("/users").post(postUser);
app.route("/sp/users").post(postUserSP);

app.route("/users/:id").put(putUser);
app.route("/sp/users/:id").put(putUserSP);

app.route("/users/:id").delete(deleteUser);
app.route("/sp/users/:id").delete(deleteUserSP);

module.exports = app;

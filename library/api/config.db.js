import dotenv from "dotenv";
import mysql from "mysql";

dotenv.config();

let connection;

try {
  connection = mysql.createConnection({
    host: process.env.DBHOST,
    user: process.env.DBUSER,
    password: process.env.DBPASS,
    database: process.env.DBNAME,
  });
} catch (err) {
  console.log("Error al conectar la base de datos");
}

export { connection };

const express = require("express");
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(require("./routes/users"));
app.use(require("./routes/issues"));

app.listen(process.env.PORT || 3300, () => {
  console.log("Servidor ejecutandose en el puerto 3300");
});

module.exports = app;

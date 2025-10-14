import express from "express";
import itemsRouter from "./routes/items.js";
import loansRouter from "./routes/loans.js";
import patronsRouter from "./routes/patrons.js";

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use("/items", itemsRouter);
app.use("/loans", loansRouter);
app.use("/patrons", patronsRouter);

app.listen(process.env.PORT || 3300, () => {
  console.log("Servidor ejecutandose en el puerto 3300");
});

export default app;

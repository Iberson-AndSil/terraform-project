const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const bodyParser = require('body-parser');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(bodyParser.json());

mongoose.connect(process.env.MONGO_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true
}).then(() => console.log("Connected to MongoDB Atlas"))
  .catch(err => console.error("Error connecting to MongoDB:", err));

const diaSchema = new mongoose.Schema({
  nombre: String,
  disponible: Boolean
});

const Dia = mongoose.model('Dia', diaSchema);

const inicializarDias = async () => {
  const diasExistentes = await Dia.countDocuments();
  if (diasExistentes === 0) {
    const diasSemana = [
      { nombre: "Lunes", disponible: false },
      { nombre: "Martes", disponible: false },
      { nombre: "Miércoles", disponible: false },
      { nombre: "Jueves", disponible: false },
      { nombre: "Viernes", disponible: false },
      { nombre: "Sábado", disponible: false },
      { nombre: "Domingo", disponible: false }
    ];
    await Dia.insertMany(diasSemana);
    console.log("Días de la semana inicializados en la base de datos.");
  }
};
inicializarDias();

app.get('/dias', async (req, res) => {
  try {
    const dias = await Dia.find();
    res.json(dias);
  } catch (err) {
    res.status(500).send('Error del servidor');
  }
});

app.put('/dias/:nombre', async (req, res) => {
  const { nombre } = req.params;
  const { disponible } = req.body;

  try {
    const dia = await Dia.findOneAndUpdate({ nombre }, { disponible }, { new: true });
    if (dia) {
      res.json(dia);
    } else {
      res.status(404).json({ message: "Día no encontrado" });
    }
  } catch (err) {
    res.status(500).send('Error del servidor');
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor en funcionamiento en el puerto ${PORT}`);
});

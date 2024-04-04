

const upload = require('../../../middlewares/upload-files');
const artController = require ('../artControllers/artController');
const express = require("express");
const router = express.Router();

  

// Endpoint para editar articulo
router.put('/edit_art', upload.single('img'), artController.editArticulo);
// Endpoint para dar de baja el articulo
router.post('/baja_art', artController.bajaArticulo);
// Endpoint para crear articulo
router.post("/income_art", upload.single('img'), artController.incomeArticulo);
// Endpoint para listar años
router.get('/anios', artController.getAniosFromDataBase)



module.exports = router;












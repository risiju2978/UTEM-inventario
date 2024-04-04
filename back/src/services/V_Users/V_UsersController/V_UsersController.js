const { db } = require("../../../../utils/utils.helpers");
require("dotenv").config();

const vistaUsersController = {
  readVistaUsers: async (req, res) => {
    try {
      const [vistaUserData] = await db.promise().query('CALL Read_Users()');
      res.status(200).json({
        status: 200,
        data: vistaUserData[0], // Devuelve los resultados del SP (en el primer índice del array)
      });
    } catch (error) {
      console.error('Error al llamar al SP Read_Users:', error);
      res.status(500).json({
        status: 500,
        error: 'Error al obtener datos de la vista',
      });
    }
  },
};

module.exports = vistaUsersController;

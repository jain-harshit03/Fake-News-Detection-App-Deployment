const express = require("express")
const router = express.Router()

const modelController = require("../Controller/ModelController")

router.post('/detect',modelController.model)

module.exports=router
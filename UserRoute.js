const express = require("express")
const router = express.Router()

const usercontroller = require("../Controller/UserController")

router.post('/login',usercontroller.login)
router.post('/register',usercontroller.register)
router.post('/uploadpic',usercontroller.uploadpic)

module.exports=router
const User = require('../User')

const login = async(req,res)=>{
    let email = req.body.email;
    let password = req.body.password;
    await User.findOne({email,password}).then((user)=>{
        return res.status(200).json(user);
    }).catch((err)=>{

        return res.status(404).json({
            msg: "User not found"
        })
    })
    console.log("hello");
    return;
}
const register = async(req,res)=>{
    let email = req.body.email;
    let password = req.body.password;
    let name = req.body.name;
    
    let user=new User({
        name,
        email,
        password
    })
    user.save().then((user)=>{
        return res.status(200).json({
            user,
            msg:"User added successfully"
        });
    })
    return;
}
const uploadpic = async(req,res)=>{
    return;
}

module.exports={login,register,uploadpic}
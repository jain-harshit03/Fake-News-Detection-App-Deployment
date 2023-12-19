const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const cors = require("cors");
const morgan = require("morgan");
const userRoute = require("./routes/UserRoute");
const request = require('request')

mongoose.set("strictQuery", false);
mongoose.connect("mongodb://127.0.0.1:27017/flexi", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});
const db = mongoose.connection;

// mongoDB database connection error handing

db.on("error", (err) => {
  console.log(err);
});

db.once("open", () => {
  console.log("database connection done");
});

const app = express();

const corsOptions = {
  origin: "http://localhost:5173",
  credentials: true, //access-control-allow-credentials:true
  optionSuccessStatus: 200,
};

app.use(cors(corsOptions));

app.use(morgan("dev"));
app.use(bodyParser.json({ limit: "50mb" }));
app.use(bodyParser.urlencoded({ limit: "50mb", extended: true }));
app.use(express.json());
app.use(express.static("public"));


const PORT = process.env.PORT || 3000;

// Server listening port

app.listen(PORT, () => {
  console.log("server is running on port 3000");
});

app.use("/user", userRoute);

app.post('/model',function(req,res){
  const options={
    url:'http://127.0.0.1:5000/flask',
    method: 'POST',
    json: true,
    body:{
      text: req.body.text,
    }
  };
  request(options,function(error,response,body){
    if(error){
      return res.status(500).json({
        msg:"Error occured. Try again later!"
      })
    }
    return res.status(200).json(body)
  });
});
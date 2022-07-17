//import from package
const express = require('express');
const mongoose = require('mongoose');

//import from other files
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");


//initializations
const port = 3000;
const app = express();
const DB = "mongodb+srv://ayodeji:ayanbunmi@cluster0.efa4czx.mongodb.net/?retryWrites=true&w=majority"

//midlleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);


//connections to db
mongoose.connect(DB).then(()=>{
    console.log('connection succesful')
}).catch((e)=>{
    console.log(e);
})

app.listen(port,"0.0.0.0", () => console.log(`listening on port ${port}!`));

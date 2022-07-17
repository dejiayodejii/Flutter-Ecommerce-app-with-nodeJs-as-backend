//import from other package
const express = require("express");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");

//import from other files
const User = require("../model/user");
const auth = require("../middleware/auth");

const authRouter = express.Router();


authRouter.post("/api/signup", async (req, res) => {
  try {
    //get incoming data
    const { name, email, password } = req.body;
    //perform validation on incoming Data
    const existingUser = await User.findOne({ email });
    console.log("got here");
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "A user with that email already exist" });
    }

    //encrypt password
    const hashpassword = await bcryptjs.hash(password, 8);

    //save incoming data
    let user = new User({
      name,
      email,
      password: hashpassword,
    });
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});


authRouter.post("/api/tokenIsValid", (req, res) => {
  try {
    const token = req.header("x-auth-token");
    if (!token) {
      return res.json(false);
    }
    const verified = jwt.verify(token, "passwordkey");
    if (!verified) {
      return res.json(false);
    }
    const user = User.findOne({ token });
    if (!user) {
      return res.json(false);
    }
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});




authRouter.get('/api/getUserData', auth, async(req,res)=>{
  const user = await User.findById(req.id);
  res.status(200).json({ ...user._doc, token: req.token });
});

authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });

    if (!user) {
      return res.status(400).json({ mesg: "This email is not registered" });
    }

    const isMatch = await bcryptjs.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ mesg: "Incorrect password" });
    }

    const token = jwt.sign({ id: user._id }, "passwordkey");
    console.log(token);

    //this .... arrange it well in json format
    res.status(200).json({ token, ...user._doc });
  } catch {}
});



module.exports = authRouter;

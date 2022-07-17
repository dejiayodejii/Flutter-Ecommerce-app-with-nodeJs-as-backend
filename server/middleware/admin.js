const jwt = require("jsonwebtoken");
const User = require("../model/user");

const admin = async (req, res, next) => {
    try{
        const token = req.header("x-auth-token");
  if (!token) return res.status(401).json({ mesg: "No authorized token" });
  
  const verified = jwt.verify(token, "passwordkey"); 
  if (!verified)
    return res
      .status(401)
      .json({ msg: "Token verification failed, authorization denied." });
  const user = await User.findById(verified.id);
  if (user.type == "user" || user.type == "seller") {
    return res.status(401).json({ msg: "You are not an admin!" });
  }
  req.id = verified.id;
  req.token = token;
  next();
    }catch(e){
        res.status(500).json({ error: e.message });
    }
  
};

module.exports = admin;

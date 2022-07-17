const express = require("express");

const Product = require("../model/product");
const admin = require("../middleware/admin");

const adminRouter = express.Router();


adminRouter.post("/admin/add-product", admin, async (req, res) => {
    try {
        const { name, description, images, quantity, price, category } = req.body;
        console.log(name);
        let product = new Product({
          name,
          description,
          images,
          quantity,
          price,
          category,
        });
        console.log(product);
        product = await product.save();
        return res.json(product);
      } catch (e) {
        return res.status(500).json({ error: e.message });
      }
  });

  adminRouter.get("/admin/get-products", admin, async (req, res) => {
    try {
   const products = await Product.find({});
        return res.json(products);
      } catch (e) {
        return res.status(500).json({ error: e.message });
      }
  });

  adminRouter.post("/admin/delete-product", admin, async (req, res) => {
    try {
      const { id } = req.body;
      let product = await Product.findByIdAndDelete(id);
      res.json(product);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });

  module.exports = adminRouter;
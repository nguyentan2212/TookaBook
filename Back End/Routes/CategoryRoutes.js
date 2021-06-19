var CategoryController = require("../Controllers/categoryController")

module.exports = app => {
    app.get("/api/category", CategoryController.getCategories);
    app.post("/api/category",CategoryController.addCategory);

}
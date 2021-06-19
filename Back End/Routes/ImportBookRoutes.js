const importBookController = require("../Controllers/ImportBookController")

module.exports = app => {
    app.get("/api/ImportBookList",importBookController.getImportBooks)
    app.get("/api/ImportBook",importBookController.getImportBookByID)
    app.post("/api/ImportBook",importBookController.addImportBooks)
}
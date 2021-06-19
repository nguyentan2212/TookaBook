var AuthorController = require("../Controllers/AuthorController")

module.exports = app => {
    app.get("/api/author", AuthorController.getAuthors);
    app.post("/api/author",AuthorController.addAuthor);

}
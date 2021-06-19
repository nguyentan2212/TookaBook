const accountApiController = require("../Controllers/AccountApiController")
//write your code to link
//service and api
//of every action with account
module.exports = app => {
    app.get("/api/account",accountApiController.getAccountList);
    app.post("/api/account", accountApiController.addAccount);
    app.get("/api/account/login",accountApiController.login)
    // router for get update
    app.post("/api/account/update",accountApiController.update)
}

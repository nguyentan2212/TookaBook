const rulesController = require("../Controllers/RuleController")

module.exports = app => {

  // Get the data of BAOCAODOANHTHU
  app.get("/api/rules", rulesController.getRules);
  app.post("/api/rules", rulesController.updateRules);
}
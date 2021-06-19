const customerController = require("../Controllers/CustomerController")

 module.exports = app => {
  app.post("/api/customer", customerController.postCreate);
  // get list of all of the customers
  app.get("/api/customer", customerController.getList);
  // search customer by id
  app.get("/api/customer/search", customerController.getSearch);
  app.post("/api/customer/search",customerController.postSearch);
  // Update customer by Id
  app.patch("/api/customer/:id", customerController.patchUpdate);
 }

var express = require("express");
var billControllers = require("../Controllers/billControllers")
var {
  getBill,
  createBill,
} = require("../Controllers/billControllers");

module.exports = (app) => {

  app.get("/getBillByCustomerID", billControllers.getBillByCustomerID );
  app.get("/getBillByBillID", billControllers.getBillByBillID);
  var router = express.Router();
  router.route("/").get(getBill).post(createBill);
  //router.route("/:id").get(getBillByID);

  app.use("/api/bill", router);
  
};
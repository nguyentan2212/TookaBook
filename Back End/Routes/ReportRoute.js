const reportController = require("../Controllers/ReportController")

module.exports = app => {

  // Get the data of BAOCAODOANHTHU
  app.get("/api/report/revenue", reportController.getRevenueList);
  app.post("/api/report/revenue", reportController.postRevenueList);

  // Get the data of BAOCAOTON
   app.get("/api/report/inventory", reportController.getInventoryList);
   app.post("/api/report/inventory", reportController.postInventoryList);
}

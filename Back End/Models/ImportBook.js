var db = require("./DatabaseAccessHelper");
var sqlString = require("sqlstring");

const addImportBook = function (data, callBackrs, callbackerr) {
  db.connect();

  //prepare sql
  var BookInfo = [];
  data.DanhSachSachMua.map(function await(DanhSachSachMua) {
    let qr = sqlString.format(
      `CALL USP_AddImportBookInfo(${DanhSachSachMua.MaSach}, ${DanhSachSachMua.SoLuong}, ${DanhSachSachMua.DonGia}, ${DanhSachSachMua.ThanhTien});`
    );
    BookInfo.push(qr);
  });
  const SqlImportBook = sqlString.format(
    `Call USP_AddImportBook('${data.NgayLap}',${data.TongTien})`
  );
  console.log(SqlImportBook);
  //execute
  db.executeQuerry(SqlImportBook)
    .then(() => {
      BookInfo.map(function (eachQueryString) {
        return db.executeQuerry(eachQueryString);
      });
      //.catch((err) => callbackerr(err))
    })
    .then((rs) => callBackrs(rs))
    .catch((err) => {
      return callbackerr(err);
    });
};

const getImportBookByID = function (data, callBackrs, callbackerr) {
  const sql = sqlString.format("Call USP_GetImporByBookID(?)", data);

  db.executeQuerry(sql)
    .then((rs) => callBackrs(rs))
    .catch((err) => callbackerr(err));
};

const getImportBook = (callBackrs, callbackerr) => {
  let sql = "Select * from PhieuNhapSach";
  db.executeQuerry(sql)
    .then((rs) => callBackrs(rs))
    .catch((err) => callbackerr(err));
};

module.exports = { addImportBook, getImportBookByID, getImportBook };

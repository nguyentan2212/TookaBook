-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 15, 2021 at 03:45 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 7.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookstoremanagement`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_AddAccount` (`p_userName` VARCHAR(255), `p_password` VARCHAR(255), `p_type` INT, `p_RealName` VARCHAR(255), `p_PhoneNumber` VARCHAR(255), `p_Email` VARCHAR(255), `p_Address` VARCHAR(255))  BEGIN
INSERT INTO BookStoreManagement.Account (username, password, type, realname, PhoneNumber, Email, Address)
VALUES (p_username,p_password, p_type, p_RealName, p_PhoneNumber, p_Email,p_Address);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_AddAuthor` (`author` VARCHAR(100))  BEGIN
	insert TACGIA(TenTacGia) values(author);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_AddBill` (`dateInput` DATE, `money` FLOAT, `moneyReceive` FLOAT, `moneyChange` FLOAT, `customerID` INT)  BEGIN
	insert HOADON(MaKhachHang,NgayLap,TongTien,ThanhToan,ConLai)
    values(customerID,dateInput,money,moneyReceive,moneyChange);
    update KHACHHANG set SoTienNo=SoTienNo+moneyChange where MaKhachHang=customerID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_AddBillInfo` (`bookID` INT, `countt` INT, `price` FLOAT, `total` FLOAT)  BEGIN
	declare id int;
    set id=(select max(SoHoaDon) from HOADON);
	insert CT_HOADON values(id,bookID,countt,price,total);
    update SACH set SoLuongTon=SoLuongTon-countt where MaSach=bookID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_AddBook` (`name` NVARCHAR(100), `categoryID` INT, `publishCompany` NVARCHAR(200), `publishYear` INT)  BEGIN
	insert SACH(TenSach,MaTheLoai,NhaXuatBan,NamXuatBan,SoLuongTon,DonGiaNhap)
    values(name,categoryID,publishCompany,publishYear,0,0);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_AddBookAuthor` (`authorID` INT)  BEGIN
	declare bookID int;
    set bookID=(select max(MaSach) from SACH);
	insert CT_TACGIA values(bookID,authorID);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_AddBookURL` (`ValueURL` VARCHAR(100) CHARSET utf8)  BEGIN
	declare bookID int;
    set bookID=(select max(MaSach) from SACH);
	insert SACH_URL values(bookID,ValueURL);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_AddCategory` (`categoryName` VARCHAR(100))  BEGIN
if((select count(*) from THELOAISACH where TenTheLoai=categoryname)=0)
then
    insert THELOAISACH(TenTheLoai) values(categoryName);
    end if;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_AddCustomer` (`name` NVARCHAR(100), `phone` VARCHAR(100), `email` VARCHAR(100), `address` NVARCHAR(100))  BEGIN
	insert KHACHHANG(TenKhachHang,DiaChi,SoDienThoai,Email,SoTienNo)
    values(name,address,phone,email,0);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_AddImportBook` (`dateInput` DATE, `money` FLOAT)  BEGIN
	insert PHIEUNHAPSACH(NgayLap,TongTien)values(dateInput,money);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_AddImportBookInfo` (`bookID` INT, `countt` INT, `price` FLOAT, `total` FLOAT)  BEGIN
	declare id int;
    set id=(select max(SoPhieuNhap) from PHIEUNHAPSACH);
	insert CT_PHIEUNHAPSACH values(id,bookID,countt,price,total);
    update SACH set SoLuongTon=SoLuongTon+countt,DonGiaNhap=price where MaSach=bookID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_AddPayment` (`dateInput` DATE, `money` FLOAT, `customerID` INT)  BEGIN
	insert phieuthutien(MaKhachHang,NgayLap,TienThu)
    values(customerID,dateInput,money);

    update KHACHHANG set SoTienNo=SoTienNo-money where MaKhachHang=customerID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_DeleteAccountByUsername` (`p_userName` VARCHAR(255), `p_password` VARCHAR(255), `p_type` INT, `p_RealName` VARCHAR(255), `p_PhoneNumber` VARCHAR(255), `p_Email` VARCHAR(255), `p_Address` VARCHAR(255))  BEGIN
DELETE  from account where account.username=p_username;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_FreshReportInventory` (`month` INT, `year` INT)  BEGIN
	delete from BAOCAOTON where Thang=month and Nam=year;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_FreshReportRevenue` (`month` INT, `year` INT)  BEGIN
	delete from BAOCAODOANHTHU where Thang=month and Nam=year;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_GetAccount` ()  BEGIN
select * from BookStoreManagement.Account;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_GetAccountByUsername` (`p_userName` VARCHAR(255))  BEGIN
select * from BookStoreManagement.Account where username=p_userName;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_GetAuthor` ()  BEGIN
select * from TACGIA;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_GetAuthorByBook` (`bookID` INT)  BEGIN
select TACGIA.MaTacGia,TACGIA.TenTacGia from TACGIA,CT_TACGIA,SACH
where TACGIA.MaTacGia=CT_TACGIA.MaTacGia and CT_TACGIA.MaSach=SACH.MaSach and SACH.MaSach=bookID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_GetBillByBillID` (`billID` INT)  BEGIN
	select h.SoHoaDon,h.MaKhachHang,h.NgayLap,h.TongTien,h.ThanhToan,h.ConLai,ct.MaSach,ct.SoLuong,ct.DonGiaBan,ct.ThanhTien
    from HOADON h,CT_HOADON ct
    where h.SoHoaDon=ct.SoHoaDon and h.SoHoaDon=billID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_GetBillByCustomerID` (`customerID` INT)  BEGIN
	select h.SoHoaDon,h.MaKhachHang,h.NgayLap,h.TongTien,h.ThanhToan,h.ConLai,ct.MaSach,ct.SoLuong,ct.DonGiaBan,ct.ThanhTien
    from HOADON h,CT_HOADON ct
    where h.SoHoaDon=ct.SoHoaDon and h.MaKhachHang=customerID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_GetBook` ()  BEGIN
	select s.MaSach,ct.MaTacGia, tg.TenTacGia, s.TenSach, s.MaTheLoai, tl.TenTheLoai, s.NhaXuatBan, s.NamXuatBan, s.SoLuongTon, s.DonGiaNhap, srl.URL 
    from 
	    SACH s JOIN ct_tacgia ct on s.MaSach = ct.MaSach 
        JOIN tacgia tg on tg.MaTacGia = ct.MaTacGia
        JOIN theloaisach tl on s.MaTheLoai = tl.MaTheLoai 
	    LEFT JOIN sach_url srl ON s.MaSach = srl.MaSach
        
    GROUP by s.MaSach;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_GetBookByID` (`bookID` INT)  BEGIN
	select s.MaSach,ct.MaTacGia, tg.TenTacGia, s.TenSach, s.MaTheLoai, tl.TenTheLoai, s.NhaXuatBan, s.NamXuatBan, s.SoLuongTon, s.DonGiaNhap, srl.URL 
    from 
	    SACH s JOIN ct_tacgia ct on s.MaSach = ct.MaSach 
        JOIN tacgia tg on tg.MaTacGia = ct.MaTacGia
        JOIN theloaisach tl on s.MaTheLoai = tl.MaTheLoai 
	    LEFT JOIN sach_url srl ON s.MaSach = srl.MaSach
    where s.MaSach = bookID    
    GROUP by s.MaSach;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_GetCategory` ()  BEGIN
select * from THELOAISACH;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_GetCategoryByBook` (`bookID` INT)  BEGIN
select THELOAISACH.MaTheLoai,THELOAISACH.TenTheLoai from THELOAISACH,SACH
where THELOAISACH.MaTheLoai=SACH.MaTheLoai and SACH.MaSach=bookID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_GetCategoryByID` (`categoryID` INT)  BEGIN
	select* from THELOAISACH where MaTheLoai=categoryID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_GetCustomer` ()  BEGIN
select * from KHACHHANG;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_GetCustomerByID` (`customerID` INT)  BEGIN
	select * from KHACHHANG where MaKhachHang=customerID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_GetImporByBookID` (`bookID` INT)  BEGIN
	select p.SoPhieuNhap,p.NgayLap,p.TongTien,ct.MaSach,ct.DonGiaNhap,ct.SoLuongNhap,ct.ThanhTien
    from PHIEUNHAPSACH p,CT_PHIEUNHAPSACH ct
    where p.SoPhieuNhap=ct.SoPhieuNhap and ct.MaSach=bookID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_GetReportInventory` (IN `month` INT, IN `year` INT)  BEGIN
	select sach.MaSach, sach.TenSach, baocaoton.TonDau, baocaoton.PhatSinh, baocaoton.TonCuoi from baocaoton, sach where baocaoton.Thang=month and baocaoton.Nam=year and baocaoton.MaSach = sach.MaSach;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_GetReportRevenue` (IN `month` INT, IN `year` INT)  BEGIN
	select sach.MaSach, sach.TenSach, baocaodoanhthu.SoLuongBan, baocaodoanhthu.TongTien from baocaodoanhthu, sach where baocaodoanhthu.Thang=month and baocaodoanhthu.Nam=year and baocaodoanhthu.MaSach = sach.MaSach;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_GetRules` ()  BEGIN
select * from QUYDINH;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_ImportReportInventory` (`month` INT, `year` INT, `bookID` INT)  BEGIN
	declare preMonth int;
    declare preYear int;
    declare first int;
    declare incurred int;
    declare last int;
		if(month =1)
		then
			set preMonth=12;
			set preYear=year-1;
		else
			set preMonth=month-1;
			set preYear=year;
		end if;

        if((select count(*) from BAOCAOTON where Thang=preMonth and Nam=preYear and MaSach=bookID)>0)
        then
			set first=(select TonCuoi from BAOCAOTON where Thang=preMonth and Nam=preYear and MaSach=bookID);
        else
			set first=0;
		end if;
        if((select count(*) from CT_PHIEUNHAPSACH ct,PHIEUNHAPSACH p
			where MaSach=bookID and ct.SoPhieuNhap=p.SoPhieuNhap and month(p.NgayLap)=month and year(p.NgayLap)=year)>0)
        then
			set incurred=(select sum(ct.SoLuongNhap) from CT_PHIEUNHAPSACH ct,PHIEUNHAPSACH p
				where MaSach=bookID and ct.SoPhieuNhap=p.SoPhieuNhap and month(p.NgayLap)=month and year(p.NgayLap)=year);
        else
			set incurred=0;
		end if;

        if((select count(*) from CT_HOADON ct,HOADON h
			where MaSach=bookID and ct.SoHoaDon=h.SoHoaDon and month(h.NgayLap)=month and year(h.NgayLap)=year)>0)
        then
			set last=first+incurred-(select sum(ct.SoLuong) from CT_HOADON ct,HOADON h
										where MaSach=bookID and ct.SoHoaDon=h.SoHoaDon and month(h.NgayLap)=month and year(h.NgayLap)=year);
		else
			set last=first+incurred;
        end if;
        insert BAOCAOTON values(
			month,
			year,
			bookID,
			first,
			incurred,
			last
		);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_ImportReportRevenue` (`month` INT, `year` INT, `bookID` INT)  BEGIN
	declare count int;
    declare money float;
    if((select count(*) from CT_HOADON ct,HOADON h
		where MaSach=bookID and ct.SoHoaDon=h.SoHoaDon and month(h.NgayLap)=month and year(h.NgayLap)=year)>0)
    then
		set count=(select sum(ct.SoLuong) from CT_HOADON ct,HOADON h
        where MaSach=bookID and ct.SoHoaDon=h.SoHoaDon and month(h.NgayLap)=month and year(h.NgayLap)=year);
        set money=(select sum(ct.ThanhTien) from CT_HOADON ct,HOADON h
        where MaSach=bookID and ct.SoHoaDon=h.SoHoaDon and month(h.NgayLap)=month and year(h.NgayLap)=year);
	else
		set count=0;
        set money=0;
	end if;

    insert BAOCAODOANHTHU values(
		month,
        year,
        bookID,
        count,
        money
    );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_Login` (`p_userName` VARCHAR(255), `p_passWord` VARCHAR(255))  BEGIN
select * from BookStoreManagement.Account where username=p_userName and password=p_passWord;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_UpdateAccountByUsername` (`p_userName` VARCHAR(255), `p_password` VARCHAR(255), `p_type` INT, `p_RealName` VARCHAR(255), `p_PhoneNumber` VARCHAR(255), `p_Email` VARCHAR(255), `p_Address` VARCHAR(255))  BEGIN
 UPDATE account
 SET account.PASSWORD=p_password, account.type=p_type,
 account.RealName= p_RealName, account.PhoneNumber=p_PhoneNumber, account.Email=p_Email, account.Address=p_Address

 WHERE account.username=p_username;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_UpdateBook` (`id` INT, `name` NVARCHAR(100), `categoryID` INT, `publishCompany` NVARCHAR(200), `publishYear` INT, `newURL` NVARCHAR(100))  BEGIN
	update SACH 
    set TenSach=name,MaTheLoai=categoryID,NhaXuatBan=publishCompany,NamXuatBan=publishYear
    where MaSach=id;
    
    delete from sach_url WHERE MaSach = id;
	insert into sach_url values (id, newURL);  
    
    delete from CT_TACGIA where MaSach=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_UpdateBookAuthor` (`bookID` INT, `authorID` INT)  BEGIN
	insert CT_TACGIA values(bookID,authorID);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_UpdateCusTomer` (`customerID` INT, `name` NVARCHAR(100), `phone` VARCHAR(100), `email` VARCHAR(100), `address` NVARCHAR(100))  BEGIN
	update KHACHHANG
    set TenKhachHang=name,SoDienThoai=phone,Email=email,DiaChi=address
    where MaKhachHang=customerID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `USP_UpdateRules` (`NhapToiThieu` INT, `TonTruocKhiNhap` INT, `TonSauKhiBan` INT, `NoToiDa` INT)  BEGIN
	UPDATE QUYDINH
 	SET QUYDINH.LuongNhapToiThieu =NhapToiThieu, QUYDINH.LuongTonTruocKhiNhap =TonTruocKhiNhap,QUYDINH.LuongTonSauKhiBan =TonSauKhiBan,QUYDINH.TienNoToiDa =NoToiDa;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `Realname` varchar(255) DEFAULT NULL,
  `PhoneNumber` varchar(255) DEFAULT NULL,
  `Email` varchar(255) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`username`, `password`, `type`, `Realname`, `PhoneNumber`, `Email`, `Address`) VALUES
('admin', 'admin', 0, 'admin is admin', '0123456789', 'ad@admin.com', 'admin\'s home'),
('user1', 'user1', 0, 'user1 is user', '123455789', 'user@user.com', 'Tan An city');

-- --------------------------------------------------------

--
-- Table structure for table `baocaodoanhthu`
--

CREATE TABLE `baocaodoanhthu` (
  `Thang` int(11) NOT NULL,
  `Nam` int(11) NOT NULL,
  `MaSach` int(11) NOT NULL,
  `SoLuongBan` int(11) DEFAULT NULL,
  `TongTien` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `baocaoton`
--

CREATE TABLE `baocaoton` (
  `Thang` int(11) NOT NULL,
  `Nam` int(11) NOT NULL,
  `MaSach` int(11) NOT NULL,
  `TonDau` int(11) NOT NULL DEFAULT 0,
  `PhatSinh` int(11) NOT NULL DEFAULT 0,
  `TonCuoi` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ct_hoadon`
--

CREATE TABLE `ct_hoadon` (
  `SoHoaDon` int(11) NOT NULL,
  `MaSach` int(11) NOT NULL,
  `SoLuong` int(11) NOT NULL DEFAULT 0,
  `DonGiaBan` float NOT NULL DEFAULT 0,
  `ThanhTien` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ct_phieunhapsach`
--

CREATE TABLE `ct_phieunhapsach` (
  `SoPhieuNhap` int(11) NOT NULL,
  `MaSach` int(11) NOT NULL,
  `SoLuongNhap` int(11) NOT NULL DEFAULT 0,
  `DonGiaNhap` float NOT NULL DEFAULT 0,
  `ThanhTien` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ct_tacgia`
--

CREATE TABLE `ct_tacgia` (
  `MaSach` int(11) NOT NULL,
  `MaTacGia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `hoadon`
--

CREATE TABLE `hoadon` (
  `SoHoaDon` int(11) NOT NULL,
  `MaKhachHang` int(11) NOT NULL,
  `NgayLap` datetime DEFAULT current_timestamp(),
  `TongTien` float NOT NULL DEFAULT 0,
  `ThanhToan` float NOT NULL DEFAULT 0,
  `ConLai` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `khachhang`
--

CREATE TABLE `khachhang` (
  `MaKhachHang` int(11) NOT NULL,
  `TenKhachHang` varchar(100) CHARACTER SET utf8 NOT NULL DEFAULT ' ',
  `DiaChi` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT ' ',
  `SoDienThoai` varchar(11) NOT NULL DEFAULT ' ',
  `Email` varchar(100) NOT NULL DEFAULT ' ',
  `SoTienNo` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `phieunhapsach`
--

CREATE TABLE `phieunhapsach` (
  `SoPhieuNhap` int(11) NOT NULL,
  `NgayLap` datetime DEFAULT current_timestamp(),
  `TongTien` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `phieuthutien`
--

CREATE TABLE `phieuthutien` (
  `SoPhieuThu` int(11) NOT NULL,
  `MaKhachHang` int(11) DEFAULT NULL,
  `NgayLap` datetime DEFAULT current_timestamp(),
  `TienThu` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `quydinh`
--

CREATE TABLE `quydinh` (
  `LuongNhapToiThieu` int(11) NOT NULL,
  `LuongTonTruocKhiNhap` int(11) NOT NULL,
  `LuongTonSauKhiBan` int(11) NOT NULL,
  `TienNoToiDa` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `quydinh`
--

INSERT INTO `quydinh` (`LuongNhapToiThieu`, `LuongTonTruocKhiNhap`, `LuongTonSauKhiBan`, `TienNoToiDa`) VALUES
(10, 5, 5, 200000),
(10, 5, 5, 200000);

-- --------------------------------------------------------

--
-- Table structure for table `sach`
--

CREATE TABLE `sach` (
  `MaSach` int(11) NOT NULL,
  `TenSach` varchar(100) CHARACTER SET utf8 DEFAULT NULL,
  `MaTheLoai` int(11) NOT NULL,
  `NhaXuatBan` varchar(100) CHARACTER SET utf8 NOT NULL,
  `NamXuatBan` int(11) NOT NULL,
  `SoLuongTon` int(11) NOT NULL DEFAULT 0,
  `DonGiaNhap` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `sach_url`
--

CREATE TABLE `sach_url` (
  `MaSach` int(11) NOT NULL,
  `URL` varchar(100) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tacgia`
--

CREATE TABLE `tacgia` (
  `MaTacGia` int(11) NOT NULL,
  `TenTacGia` varchar(100) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `theloaisach`
--

CREATE TABLE `theloaisach` (
  `MaTheLoai` int(11) NOT NULL,
  `TenTheLoai` varchar(100) CHARACTER SET utf8 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `baocaodoanhthu`
--
ALTER TABLE `baocaodoanhthu`
  ADD PRIMARY KEY (`Thang`,`Nam`,`MaSach`),
  ADD KEY `BAOCAODOANHTHU_SACH_FK` (`MaSach`);

--
-- Indexes for table `baocaoton`
--
ALTER TABLE `baocaoton`
  ADD PRIMARY KEY (`Thang`,`Nam`,`MaSach`),
  ADD KEY `BAOCAOTON_SACH_FK` (`MaSach`);

--
-- Indexes for table `ct_hoadon`
--
ALTER TABLE `ct_hoadon`
  ADD PRIMARY KEY (`SoHoaDon`,`MaSach`),
  ADD KEY `CT_HOADON_SACH_FK` (`MaSach`);

--
-- Indexes for table `ct_phieunhapsach`
--
ALTER TABLE `ct_phieunhapsach`
  ADD PRIMARY KEY (`SoPhieuNhap`,`MaSach`),
  ADD KEY `CT_PHIEUNHAPSACH_SACH_FK` (`MaSach`);

--
-- Indexes for table `ct_tacgia`
--
ALTER TABLE `ct_tacgia`
  ADD PRIMARY KEY (`MaSach`,`MaTacGia`),
  ADD KEY `CT_TACGIA_TACGIA_FK` (`MaTacGia`);

--
-- Indexes for table `hoadon`
--
ALTER TABLE `hoadon`
  ADD PRIMARY KEY (`SoHoaDon`),
  ADD KEY `HOADON_KHACHHANG_FK` (`MaKhachHang`);

--
-- Indexes for table `khachhang`
--
ALTER TABLE `khachhang`
  ADD PRIMARY KEY (`MaKhachHang`);

--
-- Indexes for table `phieunhapsach`
--
ALTER TABLE `phieunhapsach`
  ADD PRIMARY KEY (`SoPhieuNhap`);

--
-- Indexes for table `phieuthutien`
--
ALTER TABLE `phieuthutien`
  ADD PRIMARY KEY (`SoPhieuThu`),
  ADD KEY `phieuthutien_KHACHHANG_FK` (`MaKhachHang`);

--
-- Indexes for table `sach`
--
ALTER TABLE `sach`
  ADD PRIMARY KEY (`MaSach`),
  ADD KEY `SACH_THELOAISACH_FK` (`MaTheLoai`);

--
-- Indexes for table `sach_url`
--
ALTER TABLE `sach_url`
  ADD PRIMARY KEY (`MaSach`);

--
-- Indexes for table `tacgia`
--
ALTER TABLE `tacgia`
  ADD PRIMARY KEY (`MaTacGia`);

--
-- Indexes for table `theloaisach`
--
ALTER TABLE `theloaisach`
  ADD PRIMARY KEY (`MaTheLoai`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hoadon`
--
ALTER TABLE `hoadon`
  MODIFY `SoHoaDon` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `khachhang`
--
ALTER TABLE `khachhang`
  MODIFY `MaKhachHang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `phieunhapsach`
--
ALTER TABLE `phieunhapsach`
  MODIFY `SoPhieuNhap` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `phieuthutien`
--
ALTER TABLE `phieuthutien`
  MODIFY `SoPhieuThu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `sach`
--
ALTER TABLE `sach`
  MODIFY `MaSach` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tacgia`
--
ALTER TABLE `tacgia`
  MODIFY `MaTacGia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `theloaisach`
--
ALTER TABLE `theloaisach`
  MODIFY `MaTheLoai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `baocaodoanhthu`
--
ALTER TABLE `baocaodoanhthu`
  ADD CONSTRAINT `BAOCAODOANHTHU_SACH_FK` FOREIGN KEY (`MaSach`) REFERENCES `sach` (`MaSach`);

--
-- Constraints for table `baocaoton`
--
ALTER TABLE `baocaoton`
  ADD CONSTRAINT `BAOCAOTON_SACH_FK` FOREIGN KEY (`MaSach`) REFERENCES `sach` (`MaSach`);

--
-- Constraints for table `ct_hoadon`
--
ALTER TABLE `ct_hoadon`
  ADD CONSTRAINT `CT_HOADON_HOADON_FK` FOREIGN KEY (`SoHoaDon`) REFERENCES `hoadon` (`SoHoaDon`),
  ADD CONSTRAINT `CT_HOADON_SACH_FK` FOREIGN KEY (`MaSach`) REFERENCES `sach` (`MaSach`);

--
-- Constraints for table `ct_phieunhapsach`
--
ALTER TABLE `ct_phieunhapsach`
  ADD CONSTRAINT `CT_PHIEUNHAPSACH_PHIEUNHAPSACH_FK` FOREIGN KEY (`SoPhieuNhap`) REFERENCES `phieunhapsach` (`SoPhieuNhap`),
  ADD CONSTRAINT `CT_PHIEUNHAPSACH_SACH_FK` FOREIGN KEY (`MaSach`) REFERENCES `sach` (`MaSach`);

--
-- Constraints for table `ct_tacgia`
--
ALTER TABLE `ct_tacgia`
  ADD CONSTRAINT `CT_TACGIA_SACH_FK` FOREIGN KEY (`MaSach`) REFERENCES `sach` (`MaSach`),
  ADD CONSTRAINT `CT_TACGIA_TACGIA_FK` FOREIGN KEY (`MaTacGia`) REFERENCES `tacgia` (`MaTacGia`);

--
-- Constraints for table `hoadon`
--
ALTER TABLE `hoadon`
  ADD CONSTRAINT `HOADON_KHACHHANG_FK` FOREIGN KEY (`MaKhachHang`) REFERENCES `khachhang` (`MaKhachHang`);

--
-- Constraints for table `phieuthutien`
--
ALTER TABLE `phieuthutien`
  ADD CONSTRAINT `phieuthutien_KHACHHANG_FK` FOREIGN KEY (`MaKhachHang`) REFERENCES `khachhang` (`MaKhachHang`);

--
-- Constraints for table `sach`
--
ALTER TABLE `sach`
  ADD CONSTRAINT `SACH_THELOAISACH_FK` FOREIGN KEY (`MaTheLoai`) REFERENCES `theloaisach` (`MaTheLoai`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

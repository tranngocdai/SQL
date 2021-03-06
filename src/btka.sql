CREATE schema btka;
use btka;
CREATE table VatTu
(
    vattu_id  int not null auto_increment primary key,
    ma_vattu  varchar(50),
    ten_vattu varchar(50),
    dv_tinh   varchar(50),
    gia_vattu double
);
CREATE table TonKho
(
    tonkho_id       int not null auto_increment primary key,
    vattu_id        int,
    soluongdau      int,
    tongsoluongnhap int,
    tongsoluongxuat int,
    foreign key (vattu_id) references VatTu (vattu_id)
);
CREATE table NhaCungCap
(
    nhacungcap_id  int not null auto_increment primary key,
    ma_nhacungcap  varchar(50),
    ten_nhacungcap varchar(50),
    diachi         varchar(100),
    sodienthoat    int
);
CREATE table DonDatHang
(
    dondathang_id int not null auto_increment primary key,
    ma_dondathang varchar(50),
    ngaydathang   datetime,
    nhacungcap_id int,
    foreign key (nhacungcap_id) references NhaCungCap (nhacungcap_id)
);
CREATE table PhieuNhap
(
    phieunhap_id  int not null auto_increment primary key,
    ma_phieunhap  varchar(50),
    ngaynhap      datetime,
    dondathang_id int,
    foreign key (dondathang_id) references DonDatHang (dondathang_id)
);
CREATE table PhieuXuat
(
    phieuxuat_id int not null auto_increment primary key,
    ma_phieuxuat varchar(50),
    ngayxuat     datetime,
    tenkhachhang varchar(50)
);
CREATE table ChiTietDonHang
(
    chitietdonhang_id int not null auto_increment primary key,
    dondathang_id     int,
    vattu_id          int,
    soluongdat        int,
    foreign key (dondathang_id) references DonDatHang (dondathang_id),
    foreign key (vattu_id) references VatTu (vattu_id)
);
CREATE table ChiTietPhieuNhap
(
    chitietphieunhap_id int not null auto_increment primary key,
    phieunhap_id        int,
    vattu_id            int,
    soluongnhap         int,
    donggianhap         varchar(50),
    ghichu              varchar(100),
    dongianhap          int not null,
    foreign key (phieunhap_id) references PhieuNhap (phieunhap_id),
    foreign key (vattu_id) references VatTu (vattu_id)
);
CREATE table ChiTietPhieuXuat
(
    chitietphieuxuat_id int not null auto_increment primary key,
    phieuxuat_id        int,
    vattu_id            int,
    soluongxuat         int,
    dongiaxuat          varchar(50),
    ghichu              varchar(100),
    foreign key (phieuxuat_id) references PhieuXuat (phieuxuat_id),
    foreign key (vattu_id) references VatTu (vattu_id)
);

# C??u 1. T???o view c?? t??n vw_CTPNHAP bao g???m c??c th??ng tin sau:
# s??? phi???u nh???p h??ng, m?? v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p.

CREATE VIEW vw_CTPNHAP
as
SELECT pn.ma_phieunhap,
       vt.ma_vattu,
       ctpn.soluongnhap,
       ctpn.donggianhap,
       sum(ctpn.soluongnhap * ctpn.donggianhap) 'Th??nh ti???n nh???p'
from vattu vt
         join ChiTietPhieuNhap CTPN on vt.vattu_id = CTPN.vattu_id
         join PhieuNhap PN on PN.phieunhap_id = CTPN.phieunhap_id
GROUP BY ctpn.soluongnhap, vt.ma_vattu, pn.ma_phieunhap, ctpn.donggianhap;


# C??u 2. T???o view c?? t??n vw_CTPNHAP_VT bao g???m c??c th??ng tin sau:
# s??? phi???u nh???p h??ng, m?? v???t t??,t t??n v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p.

CREATE VIEW vw_CTPNHAP_VT
AS
SELECT pn.ma_phieunhap,
       vt.ma_vattu,
       vt.ten_vattu,
       ctpn.soluongnhap,
       ctpn.donggianhap,
       sum(ctpn.soluongnhap * ctpn.donggianhap) 'Th??nh ti???n nh???p'
FROM vattu vt
         join ChiTietPhieuNhap ctpn on vt.vattu_id = ctpn.vattu_id
         join PhieuNhap pn on pn.phieunhap_id = ctpn.phieunhap_id
group by ctpn.soluongnhap, vt.ma_vattu, vt.ten_vattu, pn.ma_phieunhap, ctpn.donggianhap;

# C??u 3. T???o view c?? t??n vw_CTPNHAP_VT_PN bao g???m c??c th??ng tin sau:
# s??? phi???u nh???p h??ng, ng??y nh???p h??ng, s??? ????n ?????t h??ng, m?? v???t t??, t??n v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p.

CREATE VIEW vw_CTPNHAP_VT_PN
AS
SELECT pn.ma_phieunhap,
       pn.ngaynhap,
       ddh.ma_dondathang,
       vt.ma_vattu,
       vt.ten_vattu,
       ctpn.soluongnhap,
       ctpn.donggianhap,
       sum(ctpn.soluongnhap * ctpn.donggianhap) 'Th??nh ti???n nh???p'
FROM vattu vt
         join ChiTietPhieuNhap CTPN on vt.vattu_id = CTPN.vattu_id
         join PhieuNhap PN on PN.phieunhap_id = CTPN.phieunhap_id
         join DonDatHang DDH on DDH.dondathang_id = PN.dondathang_id
group by pn.ngaynhap, pn.ma_phieunhap, ddh.ma_dondathang, vt.ma_vattu, vt.ten_vattu, ctpn.soluongnhap, ctpn.donggianhap;

# C??u 4. T???o view c?? t??n vw_CTPNHAP_VT_PN_DH bao g???m c??c th??ng tin sau:
# s??? phi???u nh???p h??ng, ng??y nh???p h??ng, s??? ????n ?????t h??ng, m?? nh?? cung c???p, m?? v???t t??, t??n v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p.

CREATE VIEW vw_CTPNHAP_VT_PN_DH
AS
SELECT pn.ma_phieunhap,
       pn.ngaynhap,
       ddh.ma_dondathang,
       ncc.ma_nhacungcap,
       vt.ma_vattu,
       ctpn.soluongnhap,
       ctpn.donggianhap,
       sum(ctpn.soluongnhap * ctpn.donggianhap) 'Th??nh ti???n nh???p'
FROM vattu vt
         join chitietphieunhap ctpn on vt.vattu_id = ctpn.vattu_id
         join phieunhap pn on pn.phieunhap_id = ctpn.phieunhap_id
         join DonDatHang DDH on DDH.dondathang_id = pn.dondathang_id
         join NhaCungCap ncc on ncc.nhacungcap_id = ddh.nhacungcap_id
GROUP by pn.ma_phieunhap, pn.ngaynhap, ddh.ma_dondathang, ncc.ma_nhacungcap, vt.ma_vattu, ctpn.soluongnhap,
         ctpn.donggianhap;


# C??u 5. T???o view c?? t??n vw_CTPNHAP_loc  bao g???m c??c th??ng tin sau:
# s??? phi???u nh???p h??ng, m?? v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p.
# V?? ch??? li???t k?? c??c chi ti???t nh???p c?? s??? l?????ng nh???p > 5.

CREATE VIEW vw_CTPNHAP_loc
as
SELECT pn.ma_phieunhap,
       vt.ma_vattu,
       ctpn.soluongnhap,
       ctpn.donggianhap,
       sum(ctpn.soluongnhap * ctpn.donggianhap) 'Th??nh ti???n nh???p'
from vattu vt
         join ChiTietPhieuNhap CTPN on vt.vattu_id = CTPN.vattu_id
         join PhieuNhap PN on PN.phieunhap_id = CTPN.phieunhap_id
WHERE soluongnhap > 5
GROUP BY ctpn.soluongnhap, vt.ma_vattu, pn.ma_phieunhap, ctpn.donggianhap
;

# C??u 6. T???o view c?? t??n vw_CTPNHAP_VT_loc bao g???m c??c th??ng tin sau:
# s??? phi???u nh???p h??ng, m?? v???t t??, t??n v???t t??, s??? l?????ng nh???p, ????n gi?? nh???p, th??nh ti???n nh???p.
# V?? ch??? li???t k?? c??c chi ti???t nh???p v???t t?? c?? ????n v??? t??nh l?? B???.

CREATE VIEW vw_CTPNHAP_VT_loc
AS
SELECT pn.ma_phieunhap,
       vt.ma_vattu,
       vt.ten_vattu,
       ctpn.soluongnhap,
       ctpn.donggianhap,
       sum(ctpn.soluongnhap * ctpn.donggianhap) 'Th??nh ti???n nh???p'
FROM vattu vt
         join ChiTietPhieuNhap ctpn on vt.vattu_id = ctpn.vattu_id
         join PhieuNhap pn on pn.phieunhap_id = ctpn.phieunhap_id
WHERE dv_tinh = 'B???'
group by ctpn.soluongnhap, vt.ma_vattu, vt.ten_vattu, pn.ma_phieunhap, ctpn.donggianhap;

# C??u 7. T???o view c?? t??n vw_CTPXUAT bao g???m c??c th??ng tin sau:
# s??? phi???u xu???t h??ng, m?? v???t t??, s??? l?????ng xu???t, ????n gi?? xu???t, th??nh ti???n xu???t.


CREATE VIEW vw_CTPXUAT
AS
SELECT px.ma_phieuxuat,
       vt.ma_vattu,
       vt.ten_vattu,
       ctpx.soluongxuat,
       ctpx.dongiaxuat,
       sum(ctpx.soluongxuat * ctpx.dongiaxuat) 'Th??nh ti???n xu???t'
FROM vattu vt
         join ChiTietPhieuXuat CTPX on vt.vattu_id = CTPX.vattu_id
         join PhieuXuat PX on PX.phieuxuat_id = CTPX.phieuxuat_id
group by ctpx.soluongxuat, vt.ma_vattu, vt.ten_vattu, px.ma_phieuxuat, ctpx.dongiaxuat;

# C??u 8. T???o view c?? t??n vw_CTPXUAT_VT bao g???m c??c th??ng tin sau:
# s??? phi???u xu???t h??ng, m?? v???t t??, t??n v???t t??, s??? l?????ng xu???t, ????n gi?? xu???t.

CREATE VIEW vw_CTPXUAT_VT
AS
SELECT px.ma_phieuxuat,
       vt.ma_vattu,
       vt.ten_vattu,
       ctpx.soluongxuat,
       ctpx.dongiaxuat
FROM vattu vt
         join ChiTietPhieuXuat CTPX on vt.vattu_id = CTPX.vattu_id
         join PhieuXuat PX on PX.phieuxuat_id = CTPX.phieuxuat_id
group by ctpx.soluongxuat, vt.ma_vattu, vt.ten_vattu, px.ma_phieuxuat, ctpx.dongiaxuat;

# C??u 9. T???o view c?? t??n vw_CTPXUAT_VT_PX bao g???m c??c th??ng tin sau:
# s??? phi???u xu???t h??ng, t??n kh??ch h??ng, m?? v???t t??, t??n v???t t??, s??? l?????ng xu???t, ????n gi?? xu???t.

CREATE VIEW vw_CTPXUAT_VT_PX
AS
SELECT px.ma_phieuxuat,
       px.tenkhachhang,
       vt.ma_vattu,
       vt.ten_vattu,
       ctpx.soluongxuat,
       ctpx.dongiaxuat
FROM vattu vt
         join ChiTietPhieuXuat CTPX on vt.vattu_id = CTPX.vattu_id
         join PhieuXuat PX on PX.phieuxuat_id = CTPX.phieuxuat_id
group by ctpx.soluongxuat, px.tenkhachhang, vt.ma_vattu, vt.ten_vattu, px.ma_phieuxuat, ctpx.dongiaxuat;

# T???o c??c stored procedure

# C??u 1. T???o Stored procedure (SP) cho bi???t
# t???ng s??? l?????ng cu???i c???a v???t t?? v???i m?? v???t t?? l?? tham s??? v??o.

CREATE procedure SP_VatTu (in ma_spvattu varchar(50))
Begin
    select ma_vattu,soluongdau + tongsoluongnhap -tongsoluongxuat as 'T???ng s??? l?????ng cu???i'
    from tonkho
             join VatTu VT on VT.vattu_id = TonKho.vattu_id
    WHERE ma_vattu = ma_spvattu;
end;

# C??u 2. T???o SP cho bi???t t???ng ti???n xu???t c???a v???t t?? v???i m?? v???t t?? l?? tham s??? v??o.

# C??u 3. T???o SP cho bi???t t???ng s??? l?????ng ?????t theo s??? ????n h??ng v???i s??? ????n h??ng l?? tham s??? v??o.

# C??u 4. T???o SP d??ng ????? th??m m???t ????n ?????t h??ng.

# C??u 5. T???o SP d??ng ????? th??m m???t chi ti???t ????n ?????t h??ng.

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

# Câu 1. Tạo view có tên vw_CTPNHAP bao gồm các thông tin sau:
# số phiếu nhập hàng, mã vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.

CREATE VIEW vw_CTPNHAP
as
SELECT pn.ma_phieunhap,
       vt.ma_vattu,
       ctpn.soluongnhap,
       ctpn.donggianhap,
       sum(ctpn.soluongnhap * ctpn.donggianhap) 'Thành tiền nhập'
from vattu vt
         join ChiTietPhieuNhap CTPN on vt.vattu_id = CTPN.vattu_id
         join PhieuNhap PN on PN.phieunhap_id = CTPN.phieunhap_id
GROUP BY ctpn.soluongnhap, vt.ma_vattu, pn.ma_phieunhap, ctpn.donggianhap;


# Câu 2. Tạo view có tên vw_CTPNHAP_VT bao gồm các thông tin sau:
# số phiếu nhập hàng, mã vật tư,t tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.

CREATE VIEW vw_CTPNHAP_VT
AS
SELECT pn.ma_phieunhap,
       vt.ma_vattu,
       vt.ten_vattu,
       ctpn.soluongnhap,
       ctpn.donggianhap,
       sum(ctpn.soluongnhap * ctpn.donggianhap) 'Thành tiền nhập'
FROM vattu vt
         join ChiTietPhieuNhap ctpn on vt.vattu_id = ctpn.vattu_id
         join PhieuNhap pn on pn.phieunhap_id = ctpn.phieunhap_id
group by ctpn.soluongnhap, vt.ma_vattu, vt.ten_vattu, pn.ma_phieunhap, ctpn.donggianhap;

# Câu 3. Tạo view có tên vw_CTPNHAP_VT_PN bao gồm các thông tin sau:
# số phiếu nhập hàng, ngày nhập hàng, số đơn đặt hàng, mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.

CREATE VIEW vw_CTPNHAP_VT_PN
AS
SELECT pn.ma_phieunhap,
       pn.ngaynhap,
       ddh.ma_dondathang,
       vt.ma_vattu,
       vt.ten_vattu,
       ctpn.soluongnhap,
       ctpn.donggianhap,
       sum(ctpn.soluongnhap * ctpn.donggianhap) 'Thành tiền nhập'
FROM vattu vt
         join ChiTietPhieuNhap CTPN on vt.vattu_id = CTPN.vattu_id
         join PhieuNhap PN on PN.phieunhap_id = CTPN.phieunhap_id
         join DonDatHang DDH on DDH.dondathang_id = PN.dondathang_id
group by pn.ngaynhap, pn.ma_phieunhap, ddh.ma_dondathang, vt.ma_vattu, vt.ten_vattu, ctpn.soluongnhap, ctpn.donggianhap;

# Câu 4. Tạo view có tên vw_CTPNHAP_VT_PN_DH bao gồm các thông tin sau:
# số phiếu nhập hàng, ngày nhập hàng, số đơn đặt hàng, mã nhà cung cấp, mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.

CREATE VIEW vw_CTPNHAP_VT_PN_DH
AS
SELECT pn.ma_phieunhap,
       pn.ngaynhap,
       ddh.ma_dondathang,
       ncc.ma_nhacungcap,
       vt.ma_vattu,
       ctpn.soluongnhap,
       ctpn.donggianhap,
       sum(ctpn.soluongnhap * ctpn.donggianhap) 'Thành tiền nhập'
FROM vattu vt
         join chitietphieunhap ctpn on vt.vattu_id = ctpn.vattu_id
         join phieunhap pn on pn.phieunhap_id = ctpn.phieunhap_id
         join DonDatHang DDH on DDH.dondathang_id = pn.dondathang_id
         join NhaCungCap ncc on ncc.nhacungcap_id = ddh.nhacungcap_id
GROUP by pn.ma_phieunhap, pn.ngaynhap, ddh.ma_dondathang, ncc.ma_nhacungcap, vt.ma_vattu, ctpn.soluongnhap,
         ctpn.donggianhap;


# Câu 5. Tạo view có tên vw_CTPNHAP_loc  bao gồm các thông tin sau:
# số phiếu nhập hàng, mã vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.
# Và chỉ liệt kê các chi tiết nhập có số lượng nhập > 5.

CREATE VIEW vw_CTPNHAP_loc
as
SELECT pn.ma_phieunhap,
       vt.ma_vattu,
       ctpn.soluongnhap,
       ctpn.donggianhap,
       sum(ctpn.soluongnhap * ctpn.donggianhap) 'Thành tiền nhập'
from vattu vt
         join ChiTietPhieuNhap CTPN on vt.vattu_id = CTPN.vattu_id
         join PhieuNhap PN on PN.phieunhap_id = CTPN.phieunhap_id
WHERE soluongnhap > 5
GROUP BY ctpn.soluongnhap, vt.ma_vattu, pn.ma_phieunhap, ctpn.donggianhap
;

# Câu 6. Tạo view có tên vw_CTPNHAP_VT_loc bao gồm các thông tin sau:
# số phiếu nhập hàng, mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.
# Và chỉ liệt kê các chi tiết nhập vật tư có đơn vị tính là Bộ.

CREATE VIEW vw_CTPNHAP_VT_loc
AS
SELECT pn.ma_phieunhap,
       vt.ma_vattu,
       vt.ten_vattu,
       ctpn.soluongnhap,
       ctpn.donggianhap,
       sum(ctpn.soluongnhap * ctpn.donggianhap) 'Thành tiền nhập'
FROM vattu vt
         join ChiTietPhieuNhap ctpn on vt.vattu_id = ctpn.vattu_id
         join PhieuNhap pn on pn.phieunhap_id = ctpn.phieunhap_id
WHERE dv_tinh = 'Bộ'
group by ctpn.soluongnhap, vt.ma_vattu, vt.ten_vattu, pn.ma_phieunhap, ctpn.donggianhap;

# Câu 7. Tạo view có tên vw_CTPXUAT bao gồm các thông tin sau:
# số phiếu xuất hàng, mã vật tư, số lượng xuất, đơn giá xuất, thành tiền xuất.


CREATE VIEW vw_CTPXUAT
AS
SELECT px.ma_phieuxuat,
       vt.ma_vattu,
       vt.ten_vattu,
       ctpx.soluongxuat,
       ctpx.dongiaxuat,
       sum(ctpx.soluongxuat * ctpx.dongiaxuat) 'Thành tiền xuất'
FROM vattu vt
         join ChiTietPhieuXuat CTPX on vt.vattu_id = CTPX.vattu_id
         join PhieuXuat PX on PX.phieuxuat_id = CTPX.phieuxuat_id
group by ctpx.soluongxuat, vt.ma_vattu, vt.ten_vattu, px.ma_phieuxuat, ctpx.dongiaxuat;

# Câu 8. Tạo view có tên vw_CTPXUAT_VT bao gồm các thông tin sau:
# số phiếu xuất hàng, mã vật tư, tên vật tư, số lượng xuất, đơn giá xuất.

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

# Câu 9. Tạo view có tên vw_CTPXUAT_VT_PX bao gồm các thông tin sau:
# số phiếu xuất hàng, tên khách hàng, mã vật tư, tên vật tư, số lượng xuất, đơn giá xuất.

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

# Tạo các stored procedure

# Câu 1. Tạo Stored procedure (SP) cho biết
# tổng số lượng cuối của vật tư với mã vật tư là tham số vào.

CREATE procedure SP_VatTu (in ma_spvattu varchar(50))
Begin
    select ma_vattu,soluongdau + tongsoluongnhap -tongsoluongxuat as 'Tổng số lượng cuối'
    from tonkho
             join VatTu VT on VT.vattu_id = TonKho.vattu_id
    WHERE ma_vattu = ma_spvattu;
end;

# Câu 2. Tạo SP cho biết tổng tiền xuất của vật tư với mã vật tư là tham số vào.

# Câu 3. Tạo SP cho biết tổng số lượng đặt theo số đơn hàng với số đơn hàng là tham số vào.

# Câu 4. Tạo SP dùng để thêm một đơn đặt hàng.

# Câu 5. Tạo SP dùng để thêm một chi tiết đơn đặt hàng.

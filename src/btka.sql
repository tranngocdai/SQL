CREATE schema btka;
use btka;
CREATE table VatTu(
                      vattu_id int not null auto_increment primary key,
                      ma_vattu varchar(50),
                      ten_vattu varchar(50),
                      dv_tinh varchar(50),
                      gia_vattu double
);
CREATE table TonKho(
                       tonkho_id int not null auto_increment primary key,
                       vattu_id int,
                       soluongdau int,
                       tongsoluongnhap int,
                       tongsoluongxuat int,
                       foreign key(vattu_id) references VatTu(vattu_id)
);
CREATE table NhaCungCap(
                           nhacungcap_id int not null auto_increment primary key,
                           ma_nhacungcap varchar(50),
                           ten_nhacungcap varchar(50),
                           diachi varchar(100),
                           sodienthoat int
);
CREATE table DonDatHang(
                           dondathang_id int not null auto_increment primary key,
                           ma_dondathang varchar(50),
                           ngaydathang datetime,
                           nhacungcap_id int,
                           foreign key (nhacungcap_id) references NhaCungCap(nhacungcap_id)
);
CREATE table PhieuNhap(
                          phieunhap_id int not null auto_increment primary key,
                          ma_phieunhap varchar(50),
                          ngaynhap datetime,
                          dondathang_id int,
                          foreign key(dondathang_id) references DonDatHang(dondathang_id)
);
CREATE table PhieuXuat(
                          phieuxuat_id int not null auto_increment primary key,
                          ma_phieuxuat varchar(50),
                          ngayxuat datetime,
                          tenkhachhang varchar(50)
);
CREATE table ChiTietDonHang(
                               chitietdonhang_id int not null auto_increment primary key,
                               dondathang_id int,
                               vattu_id int,
                               soluongdat int,
                               foreign key(dondathang_id) references DonDatHang(dondathang_id),
                               foreign key(vattu_id) references VatTu(vattu_id)
);
CREATE table ChiTietPhieuNhap(
                                 chitietphieunhap_id int not null auto_increment primary key,
                                 phieunhap_id int,
                                 vattu_id int,
                                 soluongnhap int,
                                 donggianhap varchar(50),
                                 ghichu varchar(100),
                                 foreign key(phieunhap_id) references PhieuNhap(phieunhap_id),
                                 foreign key(vattu_id) references VatTu(vattu_id)
);
CREATE table ChiTietPhieuXuat(
                                 chitietphieuxuat_id int not null auto_increment primary key,
                                 phieuxuat_id int,
                                 vattu_id int,
                                 soluongxuat int,
                                 dongiaxuat varchar(50),
                                 ghichu varchar(100),
                                 foreign key(phieuxuat_id) references PhieuXuat(phieuxuat_id),
                                 foreign key(vattu_id) references VatTu(vattu_id)
);

# Câu 1. Tạo view có tên vw_CTPNHAP bao gồm các thông tin sau:
# số phiếu nhập hàng, mã vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.

CREATE VIEW vw_CTPNHAP
    as SELECT pn.ma_phienhap,SoPhieuNhap


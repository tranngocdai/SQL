CREATE schema ERD;
use ERD;
CREATE table phieuXuat(
    soPX int not null auto_increment primary key,
    ngayXuat datetime,
    DGXuat varchar(50),
    SLXuat int,
    maVT int,
    foreign key (maVT) references vatTu(maVT)
);
CREATE table phieuNhap(
    soPN int not null auto_increment primary key,
    ngayNhap datetime,
    DGNhap varchar(50),
    SLNhap int,
    maVT int,
    foreign key (maVT) references vatTu(maVT)
);
CREATE table vatTu(
    maVT int not null auto_increment primary key,
    tenVT varchar(50),
    soPX int,
    soPN int,
    soDH int,
    foreign key(soDH) references donDH(soDH),
    foreign key(soPX) references phieuXuat(soPX),
    foreign key(soPN) references phieuNhap(soPN)
);
CREATE table donDH(
    soDH int not null auto_increment primary key,
    ngayDH datetime,
    maNCC int,
    maVt int,
    foreign key(maNCC) references nhaCC (maNCC),
    foreign key(maVt) references vatTu(maVt)
);
CREATE table nhaCC(
    maNCC int not null auto_increment primary key,
    tenNCC varchar(50),
    address varchar(50),
    phone int
);
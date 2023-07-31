create database quanlysv;
use quanlysv;
create table dmkhoa(
makhoa varchar(20) primary key,
tenkhoa varchar(255)
);
create table dmnganh(
manganh int primary key,
tennganh varchar(255),
makhoa varchar(20),
foreign key(makhoa) references dmkhoa(makhoa)
);
create table dmhocphan(
mahp int auto_increment primary key,
tenhp varchar(255),
sodvht int,
manganh int,
hocky int,
foreign key(manganh) references dmnganh(manganh)
);
create table dmlop(
malop varchar(20) primary key,
tenlop varchar(255),
manganh int,
foreign key(manganh) references dmnganh(manganh),
khoahoc int,
hedt varchar(255),
namnhaphoc int
);
create table sinhvien(
masv int auto_increment primary key,
hoten varchar(255),
malop varchar(20),
foreign key(malop) references dmlop(malop),
gioitinh tinyint(1),
ngaysinh date,
diachi varchar(255)
);
create table diemhp(
masv int,
mahp int,
diemhp float,
primary key(masv,mahp),
foreign key(masv) references sinhvien(masv),
foreign key(mahp) references dmhocphan(mahp)
);

-- I: thêm dữ liệu vào các bảng
insert into dmkhoa(makhoa,tenkhoa) values('CNTT','Công nghệ thông tin'),('KT','Kế toán'),('SP','Sư phạm');
insert into dmnganh(manganh,tennganh,makhoa) values (140902,'Sư phạm toán tin','SP'),('480202','Tin học ứng dụng','CNTT');
insert into dmlop(malop,tenlop,manganh,khoahoc,hedt,namnhaphoc) values('CT11','Cao đẳng tin học',480202,11,'TC',2013),('CT12','Cao đẳng tin học',480202,12,'CĐ',2013),('CT13','Cao đẳng tin học',480202,13,'TC',2014);
insert into dmhocphan(tenhp,sodvht,manganh,hocky)
 values('Toán cao cấp A1',4,480202,1),
 ('Tiếng anh 1',3,480202,1),
 ('Vật lý đại cương',4,480202,1),
 ('Tiếng anh 2',7,480202,1),
 ('Tiếng anh 1',3,480202,2),
 ('Xác xuất thống kê',3,480202,2);
 INSERT INTO sinhvien (MaSV, HoTen, MaLop, GioiTinh, NgaySinh, Diachi) VALUES
(1, 'Phan Thanh', 'CT12', 0, '1999-09-12', 'Tuy Phước'),
(2, 'Nguyên Thị Cẩm', 'CT12', 1, '1994-01-12', 'Quy Nhơn'),
(3, 'Võ Thị Hà', 'CT12', 1, '1995-07-02', 'An Nhơn'),
(4, 'Trần Hoài Nam', 'CT12', 0, '1994-04-05', 'Tây Sơn'),
(5, 'Trần Văn Hoàng', 'CT13', 0, '1995-08-04', 'Vĩnh Thạnh'),
(6, 'Đặng Thị Thảo', 'CT13', 1, '1995-06-12', 'Quy Nhơn'),
(7, 'Lê Thị Sen', 'CT13', 1, '1994-08-12', 'Phủ Mỹ'),
(8, 'Nguyễn Văn Huy', 'CT11', 0, '1995-06-04', 'Tuy Phước'),
(9, 'Trần Thị Hoa', 'CT11', 1, '1994-08-09', 'Hoài Nhơn');
INSERT INTO diemhp (MaSV, MaHP, DiemHp) VALUES
(2, 2, 5.9),
(2, 3, 4.5),
(3, 1, 4.3),
(3, 2, 6.7),
(3, 3, 7.3),
(4, 1, 4),
(4, 2, 5.2),
(4, 3, 3.5),
(5, 1, 9.8),
(5, 2, 7.9),
(5, 3, 7.5),
(6, 1, 6.1),
(6, 2, 5.6),
(6, 3, 4),
(7, 1, 6.2);
-- II:	Thực hiện các câu truy vấn 
-- 1.Hiển thị danh sách gồm MaSV, HoTên, MaLop, DiemHP, MaHP của những sinh viên có điểm HP >= 5
select sinhvien.masv,sinhvien.hoten,sinhvien.malop,diemhp.diemhp,dmhocphan.mahp from diemhp join sinhvien on diemhp.masv = sinhvien.masv
join  dmhocphan on diemhp.mahp = dmhocphan.mahp
where diemhp.diemhp>= 5;
-- 2.	Hiển thị danh sách MaSV, HoTen, MaLop, MaHP, DiemHP, MaHP được sắp xếp theo ưu tiên MaLop, HoTen tăng dần. 
select sinhvien.masv,sinhvien.hoten,sinhvien.malop,diemhp.diemhp,diemhp.mahp from diemhp join sinhvien on diemhp.masv = sinhvien.masv
order by sinhvien.malop, sinhvien.hoten;
-- 3.	Hiển thị danh sách gồm MaSV, HoTen, MaLop, DiemHP, HocKy của những sinh viên có DiemHP từ 5  7 ở học kỳ I. 
select sinhvien.masv,sinhvien.hoten,sinhvien.malop,diemhp.diemhp,dmhocphan.hocky from diemhp join sinhvien on diemhp.masv = sinhvien.masv
join  dmhocphan on diemhp.mahp = dmhocphan.mahp
where dmhocphan.hocky = 1 and diemhp.diemhp between 5 and 7;
-- 4.	Hiển thị danh sách sinh viên gồm MaSV, HoTen, MaLop, TenLop, MaKhoa của Khoa có mã CNTT  
select sinhvien.masv,sinhvien.hoten,sinhvien.malop,dmlop.tenlop,dmkhoa.makhoa from dmkhoa join dmnganh on dmkhoa.makhoa = dmnganh.makhoa
join dmlop on dmlop.manganh = dmnganh.manganh
join sinhvien on dmlop.malop = sinhvien.malop
where dmkhoa.makhoa = 'CNTT';
-- 5.	Cho biết MaLop, TenLop, tổng số sinh viên của mỗi lớp 
 select dmlop.malop,dmlop.tenlop,count(sinhvien.masv) from dmlop join sinhvien on sinhvien.malop = dmlop.malop
 group by dmlop.malop;
 -- 6.	Cho biết điểm trung bình chung của mỗi sinh viên ở mỗi học kỳ, biết công thức tính DiemTBC như sau:
-- DiemTBC = ∑▒〖(DiemHP*Sodvhp)/∑(Sodvhp)〗
select hocky, hp.Masv,Sum(diemHP * Sodvht)/Sum(Sodvht) DiemTBC from diemhp hp join dmhocphan dmhp on hp.mahp = dmhp.mahp
where dmhp.hocky = 1
group by hp.masv
order by hp.masv;
-- 7.	Cho biết MaLop, TenLop, số lượng nam nữ theo từng lớp.
select sv.maLop,lop.TenLop,
case
	when sv.gioitinh = 0 then "Nam"
	when sv.gioitinh = 1 then "Nữ"
end 'GioiTinh',
case
	when sv.gioitinh = 0 then count(sv.masv)
	when sv.gioitinh = 1 then count(sv.masv)
end 'SoLuong' from sinhvien sv
join dmlop lop on sv.maLop = lop.maLop
group by sv.maLop,sv.gioitinh;
-- 8.	Cho biết điểm trung bình chung của mỗi sinh viên ở học kỳ 1
--      Biết: DiemTBC = ∑▒〖(DiemHP*Sodvhp)/∑(Sodvhp)〗
-- 10.	Đếm số sinh viên có điểm HP <5 của mỗi học phần
select mahp, count(diemhp)  SL_SV from diemhp 
where diemhp < 5
group by diemhp.mahp;
-- 11.	Tính tổng số đơn vị học trình có điểm HP<5 của mỗi sinh viên 
 select sv.MaSV,HoTen, sum(Sodvht) Tongdvht from sinhvien sv join diemhp hp on sv.MaSV = hp.MaSV
 join dmhocphan dmhp on dmhp.MaHP = hp.MaHP
 where diemHP < 5
 group by sv.MaSV
 order by sv.MaSV;
 -- 12.	Cho biết MaLop, TenLop có tổng số sinh viên >2.
 select sv.MaLop, TenLop,count(MaSV) from dmlop lp join sinhvien sv on lp.MaLop = sv.MaLop
group by sv.MaLop
having count(MaSV) > 2;
-- 13.	Cho biết HoTen sinh viên có ít nhất 2 học phần có điểm 
select sv.MaSV, HoTen, count(diemHP) from sinhvien sv join diemhp hp on sv.MaSV = hp.MaSV
where diemHP < 5
group by sv.MaSV
having count(diemHP) >= 2;
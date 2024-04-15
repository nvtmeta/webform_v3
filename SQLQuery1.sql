CREATE DATABASE db_ECommerceShop
GO
USE db_ECommerceShop
GO 
CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY(1,1),
    UserName NVARCHAR(255) NOT NULL,
    UserEmail NVARCHAR(255) NOT NULL,
    UserPassword NVARCHAR(255) NOT NULL,
    UserRole NVARCHAR(50) NOT NULL,
	FullName NVARCHAR(255) NOT NULL,
	Gender BIT,
	AddressInfo NVARCHAR(MAX),
	PhoneNum VARCHAR (50)

);
--Trường Id: khóa chính của bảng, là số nguyên duy nhất định danh cho mỗi user.
--Trường Name: tên của user.
--Trường Email: địa chỉ email của user.
--Trường Password: mật khẩu của user.
--Trường Role: vai trò của user trong hệ thống (ví dụ: customer, employee, admin).

GO
CREATE TABLE Categories (
    CategoryId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL
);
GO
CREATE TABLE Products (
    ProductId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    Price DECIMAL(18, 2) NOT NULL,
	LastPrice DECIMAL (18, 2) NOT NULL,
    CategoryId INT NOT NULL,
    FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
);
-- Insert some fake categories
INSERT INTO Categories (Name) VALUES ('Electronics');
INSERT INTO Categories (Name) VALUES ('Clothing');
INSERT INTO Categories (Name) VALUES ('Books');
INSERT INTO Categories (Name) VALUES ('Furniture');

-- Insert some fake products
INSERT INTO Products (Name, Description, Price, LastPrice, CategoryId) 
VALUES ('Laptop', 'High-performance laptop with SSD', 999.99, 1099.99, 1);

INSERT INTO Products (Name, Description, Price, LastPrice, CategoryId) 
VALUES ('T-shirt', 'Cotton T-shirt with logo', 19.99, 24.99, 2);

INSERT INTO Products (Name, Description, Price, LastPrice, CategoryId) 
VALUES ('Java Programming Book', 'Comprehensive guide to Java programming', 39.99, 49.99, 3);

INSERT INTO Products (Name, Description, Price, LastPrice, CategoryId) 
VALUES ('Sofa', 'Comfortable sofa for your living room', 499.99, 599.99, 4);


--Trường Id: khóa chính của bảng, là số nguyên duy nhất định danh cho mỗi product.
--Trường Name: tên của product.
--Trường Description: mô tả của product.
--Trường Price: giá của product.
--Trường CategoryId: khóa ngoại đến category mà product thuộc về.
GO
CREATE TABLE ProductImages (
    Id INT PRIMARY KEY,
    ProductId INT NOT NULL,
    Url NVARCHAR(MAX) NOT NULL,
    FOREIGN KEY (ProductId) REFERENCES Products(ProductId)
);
--Trường Id: khóa chính của bảng, là số nguyên duy nhất định danh cho mỗi image.
--Trường ProductId: khóa ngoại đến product mà image thuộc về.
--Trường Url: đường dẫn đến image.
GO
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    UserId INT NOT NULL,
    CreatedAt DATETIME NOT NULL,
    UpdatedAt DATETIME,
    Status INT NOT NULL,
    ShippingCost DECIMAL(18, 2) NOT NULL,
    Tax DECIMAL(18, 2) NOT NULL,
    Discount DECIMAL(18, 2) NOT NULL,
    FOREIGN KEY (UserId) REFERENCES Users(UserId)
);
--Trường Id: khóa chính của bảng, là số nguyên duy nhất định danh cho mỗi order.
--Trường UserId: khóa ngoại đến user tạo order.
--Trường CreatedAt: thời gian tạo order.
--Trường UpdatedAt: thời gian cập nhật order (nếu có).
--Trường Status: trạng thái của order.
--Trường ShippingCost: chi phí vận chuyển của order.
--Trường Tax: thuế giá trị gia tăng của order.
--Trường Discount: tỉ lệ giảm giá của order.

GO

CREATE TABLE OrderItems (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    CONSTRAINT PK_OrderItems PRIMARY KEY (OrderID, ProductID),
    CONSTRAINT FK_OrderID FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_ProductID FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE OrderStatuses (
    OrderStatusID INT PRIMARY KEY,
    OrderStatusName VARCHAR(50) NOT NULL
);

CREATE TABLE OrderHistories (
    OrderHistoryID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    OrderStatusID INT NOT NULL,
    UserID INT NOT NULL,
    ChangeDate DATETIME NOT NULL,
    Note VARCHAR(500) NOT NULL,
    CONSTRAINT FK_OrderID_2 FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT FK_OrderStatusID_2 FOREIGN KEY (OrderStatusID) REFERENCES OrderStatuses(OrderStatusID),
    CONSTRAINT FK_UserID_2 FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
---DATA----
INSERT INTO Users (username, useremail, userpassword, userrole, fullname, gender, addressinfo, phonenum)
VALUES ('lethaivinh', 'lethaivinh@example.com', 'password', 'user', N'Lê Thái Vinh', 1, N'123 Đường Trần Phú, Thành phố Hải Phòng, Tỉnh Hải Phòng', '123-456-7890');

INSERT INTO Users (username, useremail, userpassword, userrole, fullname, gender, addressinfo, phonenum)
VALUES ('tranxuanhung', 'tranxuanhung@example.com', 'password', 'user', N'Trần Xuân Hùng', 1, N'123 Đường Lê Duẩn, Thành phố Hà Nội, Tỉnh Hà Nội', '123-456-7890');

INSERT INTO Users (username, useremail, userpassword, userrole, fullname, gender, addressinfo, phonenum)
VALUES ('lyvanlinh', 'lyvanlinh@example.com', 'password', 'user', N'Lý Văn Linh', 1, N'123 Đường Nguyễn Huệ, Thành phố Hồ Chí Minh, Tỉnh Hồ Chí Minh', '123-456-7890');

INSERT INTO Users (username, useremail, userpassword, userrole, fullname, gender, addressinfo, phonenum)
VALUES ('dinhhuuhuy', 'dinhhuuhuy@example.com', 'password', 'user', N'Đinh Hữu Huy', 1, N'123 Đường Hùng Vương, Thành phố Đà Nẵng, Tỉnh Đà Nẵng', '123-456-7890');

INSERT INTO Users (username, useremail, userpassword, userrole, fullname, gender, addressinfo, phonenum)
VALUES ('tranvannam', 'tranvannam@example.com', 'password', 'user', N'Trần Văn Nam', 1, N'123 Đường Bạch Đằng, Thành phố Hải Dương, Tỉnh Hải Dương', '123-456-7890');

INSERT INTO Users (username, useremail, userpassword, userrole, fullname, gender, addressinfo, phonenum)
VALUES ('lehuuhung', 'lehuuhung@example.com', 'password', 'user', N'Lê Hữu Hùng', 1, N'123 Đường 3 Tháng 2, Thành phố Cần Thơ, Tỉnh Cần Thơ', '123-456-7890');

INSERT INTO Users (username, useremail, userpassword, userrole, fullname, gender, addressinfo, phonenum)
VALUES ('dinhxuantuan', 'dinhxuantuan@example.com', 'password', 'user', N'Đinh Xuân Tuấn', 1, N'123 Đường Trần Hưng Đạo, Thành phố Hải Dương, Tỉnh Hải Dương', '123-456-7890');

GO
INSERT INTO Users (username, useremail, userpassword, userrole, fullname, gender, addressinfo, phonenum)
VALUES 
('nguyenthihuongs', 'nguyenthihuongs@example.com', 'password', 'user', N'Nguyễn Thị Hương', 0, N'123 Đường Trần Phú, Thành phố Hải Phòng, Tỉnh Hải Phòng', '123-456-7890'),
('lethuhanhs', 'lethuhanhs@example.com', 'password', 'user', N'Lê Thu Hạnh', 0, N'123 Đường Lê Duẩn, Thành phố Hà Nội, Tỉnh Hà Nội', '123-456-7890'),
('tranthuyngocs', 'tranthuyngocs@example.com', 'password', 'user', N'Trần Thuỷ Ngọc', 0, N'123 Đường Nguyễn Huệ, Thành phố Hồ Chí Minh, Tỉnh Hồ Chí Minh', '123-456-7890'),
('nguyenthanhhoas', 'nguyenthanhhoas@example.com', 'password', 'user', N'Nguyễn Thanh Hoa', 0, N'123 Đường Hùng Vương, Thành phố Đà Nẵng, Tỉnh Đà Nẵng', '123-456-7890'),
('lethubichs', 'lethubichs@example.com', 'password', 'user', N'Lê Thu Bích', 0, N'123 Đường Bạch Đằng, Thành phố Hải Dương, Tỉnh Hải Dương', '123-456-7890'),
('tranngocvans', 'tranngocvans@example.com', 'password', 'user', N'Trần Ngọc Vân', 0, N'123 Đường 3 Tháng 2, Thành phố Cần Thơ, Tỉnh Cần Thơ', '123-456-7890'),
('nguyenthuThanhs', 'nguyenthuThanhs@example.com', 'password', 'user', N'Nguyễn Thu Thanh', 0, N'123 Đường Trần Hưng Đạo, Thành phố Hải Dương, Tỉnh Hải Dương', '123-456-7890'),
('lehanhthuys', 'lehanhthuys@example.com', 'password', 'user', N'Lê Hạnh Thuỷ', 0, N'123 Đường Phan Chu Trinh, Thành phố Hà Nội, Tỉnh Hà Nội', '123-456-7890'),
('tranbichhuongs', 'tranbichhuongs@example.com', 'password', 'user', N'Trần Bích Hương', 0, N'123 Đường Nguyễn Văn Cừ, Thành phố Hồ Chí Minh, Tỉnh Hồ Chí Minh', '123-456-7890')

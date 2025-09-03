-- Create Category Table
-- Liên kết với bảng User (1 user có nhiều category)

USE BT2;
GO

-- Tạo bảng Category
CREATE TABLE Category (
    id int IDENTITY(1,1) PRIMARY KEY,
    name nvarchar(255) NOT NULL,
    description nvarchar(500),
    image nvarchar(500),
    status bit DEFAULT 1, -- 1: active, 0: inactive
    user_id int NOT NULL,
    created_date datetime DEFAULT GETDATE(),
    updated_date datetime DEFAULT GETDATE(),
    
    -- Foreign key constraint
    CONSTRAINT FK_Category_User FOREIGN KEY (user_id) REFERENCES [User](id)
        ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- Tạo index cho performance
CREATE INDEX IX_Category_UserId ON Category(user_id);
CREATE INDEX IX_Category_Status ON Category(status);
CREATE INDEX IX_Category_Name ON Category(name);
GO

-- Insert sample data
INSERT INTO Category (name, description, image, status, user_id) VALUES
(N'Công nghệ', N'Các bài viết về công nghệ thông tin', 'tech.jpg', 1, 1),
(N'Du lịch', N'Chia sẻ kinh nghiệm du lịch', 'travel.jpg', 1, 1),
(N'Ẩm thực', N'Món ăn ngon và công thức nấu ăn', 'food.jpg', 1, 2),
(N'Thể thao', N'Tin tức và bình luận thể thao', 'sport.jpg', 1, 2);
GO

-- Kiểm tra dữ liệu
SELECT c.*, u.username, u.fullname 
FROM Category c 
INNER JOIN [User] u ON c.user_id = u.id;
GO

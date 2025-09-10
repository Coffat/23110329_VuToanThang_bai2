USE BT2;
GO

IF OBJECT_ID('dbo.Product', 'U') IS NULL
BEGIN
    CREATE TABLE Product (
        id INT IDENTITY(1,1) PRIMARY KEY,
        name NVARCHAR(255) NOT NULL,
        description NVARCHAR(1000),
        price DECIMAL(18,2) NOT NULL DEFAULT 0,
        image NVARCHAR(500),
        status BIT DEFAULT 1,
        user_id INT NOT NULL,
        created_date DATETIME DEFAULT GETDATE(),
        updated_date DATETIME DEFAULT GETDATE(),
        CONSTRAINT FK_Product_User FOREIGN KEY (user_id) REFERENCES [User](id)
            ON DELETE CASCADE ON UPDATE CASCADE
    );
    CREATE INDEX IX_Product_UserId ON Product(user_id);
    CREATE INDEX IX_Product_Status ON Product(status);
    CREATE INDEX IX_Product_Name ON Product(name);
END
GO



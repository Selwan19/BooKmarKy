--- Creating datawarehouse
CREATE DATABASE Bookmarky_DWH
GO

--- Using database
USE Bookmarky_DWH
GO

--- Creating User Dimenstion
CREATE TABLE [User_Dim] (
  [User_ID] int PRIMARY KEY,
  [Username] nvarchar(255),
  [Email] nvarchar(255),
  [Join_Date] date,
  [Role] nvarchar(255)
)
GO

--- Creating Platform Dimenstion
CREATE TABLE [Platform_Dim] (
  [Platform_ID] int PRIMARY KEY,
  [Platform_Name] nvarchar(255),
  [URL_Format] nvarchar(255)
)
GO

--- Creating CategoryDimenstion
CREATE TABLE [Category_Dim] (
  [Category_ID] int PRIMARY KEY,
  [Category_Name] nvarchar(255)
)
GO

--- Creating DateDimenstion
CREATE TABLE [Date_Dim] (
  [Date_ID] int PRIMARY KEY,
  [Full_Date] Timestamp,
  [Year] int,
  [Month] int,
  [Day] int,
  [Hour] int
)
GO

--- Creating Bookmark Type Dimenstion
CREATE TABLE [Bookmark_Type_Dim] (
  [Bookmark_Type_ID] int PRIMARY KEY,
  [Bookmark_Type_Name] nvarchar(255)
)
GO

--- Creating Recommendation Dimenstion
CREATE TABLE [Recommendation_Dim] (
  [Recommendation_ID] int PRIMARY KEY,
  [Recommended_Category] nvarchar(255),
  [Confidence_Score] decimal,
  [Recommendation_Date] date
)
GO

--- Creating Content Metadata Dimenstion
CREATE TABLE [Content_Metadata_Dim] (
  [Content_ID] int PRIMARY KEY IDENTITY(1, 1),
  [Content_Type] nvarchar(255),
  [Content_Source] nvarchar(255),
  [Author_Name] nvarchar(255),
  [Content_Length] int,
  [Publish_Date] date
)
GO

--- Creating Bookmarky Fact Table
CREATE TABLE [Bookmarky_Fact] (
  [Bookmark_ID] int PRIMARY KEY,
  [User_ID] int,
  [Platform_ID] int,
  [Category_ID] int,
  [Date_ID] int,
  [Bookmark_Type_ID] int,
  [Content_ID] int,
  [Recommendation_ID] int,
  [Bookmark_Count] int,
  [Bookmark_Click_Count] int,
  [Recommendation_Count] int,
  [Recommendation_Click_Count] int,
  [Click_Through_Rate] decimal,
  [Recommendation_Success_Rate] decimal
)
GO

ALTER TABLE [Bookmarky_Fact] ADD FOREIGN KEY ([User_ID]) REFERENCES [User_Dim] ([User_ID])
GO

ALTER TABLE [Bookmarky_Fact] ADD FOREIGN KEY ([Platform_ID]) REFERENCES [Platform_Dim] ([Platform_ID])
GO

ALTER TABLE [Bookmarky_Fact] ADD FOREIGN KEY ([Category_ID]) REFERENCES [Category_Dim] ([Category_ID])
GO

ALTER TABLE [Bookmarky_Fact] ADD FOREIGN KEY ([Date_ID]) REFERENCES [Date_Dim] ([Date_ID])
GO

ALTER TABLE [Bookmarky_Fact] ADD FOREIGN KEY ([Bookmark_Type_ID]) REFERENCES [Bookmark_Type_Dim] ([Bookmark_Type_ID])
GO

ALTER TABLE [Bookmarky_Fact] ADD FOREIGN KEY ([Content_ID]) REFERENCES [Content_Metadata_Dim] ([Content_ID])
GO

ALTER TABLE [Bookmarky_Fact] ADD FOREIGN KEY ([Recommendation_ID]) REFERENCES [Recommendation_Dim] ([Recommendation_ID])
GO


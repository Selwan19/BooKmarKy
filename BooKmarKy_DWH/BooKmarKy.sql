CREATE TABLE [User_Dimension] (
  [User_ID] int PRIMARY KEY,
  [Username] nvarchar(255),
  [Email] nvarchar(255),
  [Join_Date] date,
  [Role] nvarchar(255)
)
GO

CREATE TABLE [Platform_Dimension] (
  [Platform_ID] int PRIMARY KEY,
  [Platform_Name] nvarchar(255),
  [URL_Format] nvarchar(255)
)
GO

CREATE TABLE [Category_Dimension] (
  [Category_ID] int PRIMARY KEY,
  [Category_Name] nvarchar(255)
)
GO

CREATE TABLE [Date_Dimension] (
  [Date_ID] int PRIMARY KEY,
  [Full_Date] date,
  [Year] int,
  [Month] int,
  [Day] int,
  [Hour] int
)
GO

CREATE TABLE [Bookmark_Type_Dimension] (
  [Bookmark_Type_ID] int PRIMARY KEY,
  [Bookmark_Type_Name] nvarchar(255)
)
GO

CREATE TABLE [Recommendation_Dimension] (
  [Recommendation_ID] int PRIMARY KEY,
  [Recommended_Category] nvarchar(255),
  [Confidence_Score] decimal,
  [Recommendation_Date] date
)
GO

CREATE TABLE [Content_Metadata_Dimension] (
  [Content_ID] int PRIMARY KEY IDENTITY(1, 1),
  [Content_Type] nvarchar(255),
  [Content_Source] nvarchar(255),
  [Author_Name] nvarchar(255),
  [Content_Length] int,
  [Publish_Date] date
)
GO

CREATE TABLE [Bookmark_Fact] (
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

ALTER TABLE [Bookmark_Fact] ADD FOREIGN KEY ([User_ID]) REFERENCES [User_Dimension] ([User_ID])
GO

ALTER TABLE [Bookmark_Fact] ADD FOREIGN KEY ([Platform_ID]) REFERENCES [Platform_Dimension] ([Platform_ID])
GO

ALTER TABLE [Bookmark_Fact] ADD FOREIGN KEY ([Category_ID]) REFERENCES [Category_Dimension] ([Category_ID])
GO

ALTER TABLE [Bookmark_Fact] ADD FOREIGN KEY ([Date_ID]) REFERENCES [Date_Dimension] ([Date_ID])
GO

ALTER TABLE [Bookmark_Fact] ADD FOREIGN KEY ([Bookmark_Type_ID]) REFERENCES [Bookmark_Type_Dimension] ([Bookmark_Type_ID])
GO

ALTER TABLE [Bookmark_Fact] ADD FOREIGN KEY ([Content_ID]) REFERENCES [Content_Metadata_Dimension] ([Content_ID])
GO

ALTER TABLE [Bookmark_Fact] ADD FOREIGN KEY ([Recommendation_ID]) REFERENCES [Recommendation_Dimension] ([Recommendation_ID])
GO

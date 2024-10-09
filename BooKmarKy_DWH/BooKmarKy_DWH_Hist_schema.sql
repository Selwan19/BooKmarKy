CREATE TABLE [BookmarkFact] (
  [BookmarkID] int PRIMARY KEY,
  [PlatformID] int,
  [CategoryID] int,
  [BookmarkTypeID] int,
  [ContentMetadataID] int,
  [Timestamp] datetime
)
GO

CREATE TABLE [PlatformDimension] (
  [PlatformID] int PRIMARY KEY,
  [PlatformName] varchar(100)
)
GO

CREATE TABLE [CategoryDimension] (
  [CategoryID] int PRIMARY KEY,
  [CategoryName] varchar(100),
  [SubcategoryName] varchar(100)
)
GO

CREATE TABLE [BookmarkTypeDimension] (
  [BookmarkTypeID] int PRIMARY KEY,
  [BookmarkTypeName] varchar(100)
)
GO

CREATE TABLE [ContentMetadataDimension] (
  [ContentMetadataID] int PRIMARY KEY,
  [Title] varchar(255),
  [Description] text,
  [URL] varchar(255)
)
GO

ALTER TABLE [BookmarkFact] ADD FOREIGN KEY ([PlatformID]) REFERENCES [PlatformDimension] ([PlatformID])
GO

ALTER TABLE [BookmarkFact] ADD FOREIGN KEY ([CategoryID]) REFERENCES [CategoryDimension] ([CategoryID])
GO

ALTER TABLE [BookmarkFact] ADD FOREIGN KEY ([BookmarkTypeID]) REFERENCES [BookmarkTypeDimension] ([BookmarkTypeID])
GO

ALTER TABLE [BookmarkFact] ADD FOREIGN KEY ([ContentMetadataID]) REFERENCES [ContentMetadataDimension] ([ContentMetadataID])
GO

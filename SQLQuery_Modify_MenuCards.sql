SELECT TOP (1000) [MenuCardId]
      ,[Title]
  FROM [MenuCards].[mc].[MenuCards]

ALTER Table [mc].[MenuCards]
ADD [Active] bit

ALTER Table [mc].[MenuCards]
ADD [Order] int

insert into mc.MenuCards Values('Breakfast',1,1)
insert into mc.MenuCards Values('Vegetarian',1,2)
insert into mc.MenuCards Values('Steaks',1,3) 

use MenuCards
ALTER Table [mc].[Menus]
ADD [Active] bit,
 [Day] datetime,
[Order] int,
[Type] varchar(50);

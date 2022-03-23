DROP DATABASE IF EXISTS Snakedb;
CREATE DATABASE Snakedb;
USE SnakeDB;


DELIMITER $$

CREATE PROCEDURE CreateTables()
BEGIN

Drop TABLE if exists `TileType` ;
Drop TABLE if exists`item` ;
Drop TABLE if exists`Tile` ;
Drop TABLE if exists`asset` ;
Drop TABLE if exists`players` ;
Drop TABLE if exists`Player_Asset` ;
Drop TABLE if exists`chat` ;
Drop TABLE if exists`map` ;
Drop TABLE if exists`Asset_Tile` ;


CREATE table `asset`
 (
`assetID` int primary key auto_increment,
`value` int,
`description` varchar(250),
`Wall` bit
);

CREATE TABLE `players` 
(
`Email` varchar(50) primary key,
`Password` varchar(12),
`rowID` int,
`columnID` int,
`score` int,
`login_count` int,
`locked_out`bool,
`length` int
);

	-- Links player and asset table
Create table `Player_Asset` 
(
`Player_Asset` int primary key,
`assetID` int,
`Email` varchar(50),
`quantity` int,
foreign key (Email) references `players` (Email),
foreign key (assetID) references `asset` (assetID)
);

create table `chat` 
(
`chatID` int(50) primary key auto_increment,
`message` varchar(250),
`ToID` varchar(50),
`FromID` varchar(50),
foreign key (FromID) references `players`(Email),
foreign key (ToID) references `players`(Email)
);




create table `map` 
(	
`mapID` int primary key auto_increment,
`HomeTileRow` int ,
`HomeTileColumn` int ,
`xMax` int,
`yMax` int
);

CREATE TABLE `Tile` 
(
`rowID`int,
`columnID`int,
`mapID` int,
primary key (rowID,columnID),
foreign key (mapID) references `map` (mapID)
);



CREATE TABLE `Asset_Tile` 
(
`AssetID`int,
`rowID` int,
`columnID` int,
foreign key (AssetID) references `asset` (AssetID),
foreign key (rowID,columnID) references `tile` (rowID,columnID)
);




END$$
DELIMITER ;

call CreateTables;

-- TEST DATA BELOW

	-- Inserts Players
insert into players (Email, password, rowID, columnID, score, login_count, locked_out,  length) values ('cfounds0@baidu.com', '3MJycoumVx1I', 88, 23, 47, 3, null,  7);
insert into players (Email, password, rowID, columnID, score, login_count, locked_out,  length) values ('lbarnet1@dmoz.org', 'AZPwhogv', 56, 98, 76, 2, null, 8);
insert into players (Email, password, rowID, columnID, score, login_count, locked_out,  length) values ('lkerss2@blogtalkradio.com', 'DhEXdui4SRYf', 29, 86, 82, 2, null,  1);

	-- Inserts Maps
insert into map (mapID, HomeTileRow, HomeTileColumn, xMax, yMax) values (1, 23, 43, 38, 62);
insert into map (mapID, HomeTileRow, HomeTileColumn, xMax, yMax) values (2, 23, 25, 71, 88);
insert into map (mapID, HomeTileRow, HomeTileColumn, xMax, yMax) values (3, 28, 2, 21, 64);
insert into map (mapID, HomeTileRow, HomeTileColumn, xMax, yMax) values (4, 32, 10, 40, 75);

	-- Inserts Assets

insert into asset (assetID, value, description, Wall) values (1,  48, 'eu interdum eu tincidunt in',false);
insert into asset (assetID,  value, description, Wall) values (2, 91, 'in eleifend quam a odio',true);
insert into asset (assetID,  value, description, Wall) values (3,  25, 'sit amet consectetuer adipiscing elit',false);
insert into asset (assetID,  value, description, Wall) values (4,  9, 'posuere cubilia curae donec pharetra',false);
insert into asset (assetID,  value, description, Wall) values (5,  87, 'nisi eu orci mauris lacinia',false);
insert into asset (assetID,  value, description, Wall) values (6,  79, 'sed vel enim sit amet',true);
insert into asset (assetID,  value, description, Wall) values (7,  52, 'mollis molestie lorem quisque ut',false);
insert into asset (assetID,  value, description, Wall) values (8,  85, 'mauris viverra diam vitae quam',true);

	-- Insert chat data
    
    insert into chat (chatID, message, ToID, FromID) values (20, 'elementum in hac habitasse platea', 'cfounds0@baidu.com', 'lbarnet1@dmoz.org');
insert into chat (chatID, message, ToID, FromID) values (85, 'metus arcu adipiscing molestie hendrerit', 'cfounds0@baidu.com', 'lbarnet1@dmoz.org');
insert into chat (chatID, message, ToID, FromID) values (29, 'lorem ipsum dolor sit amet', 'lbarnet1@dmoz.org', 'cfounds0@baidu.com');
insert into chat (chatID, message, ToID, FromID) values (8, 'phasellus sit amet erat nulla', 'lkerss2@blogtalkradio.com', 'lkerss2@blogtalkradio.com');

-- DELETE QUERYS BELOW

	-- Deletes a player 
	DELETE FROM players WHERE Email='lbarnet1@dmoz.org';

	-- Delete from map where xmax is lower than 40
    DELETE from map where xMax <40;
    
	-- Deletes from asset where value is less thank 10 
    DELETE FROM asset where value <10;
    
    	-- Deletes from chat where FromID is one typed (Used to delete users sent chats)
    DELETE FROM chat where FromID = 'lbarnet1@dmoz.org';
    
-- UPDATE QUERYS BELOW
    
	-- Updates a players locked out status to true if login count is 3
	UPDATE players
	SET locked_out = true
	WHERE login_count >3;

	-- Updates player with new password if entered email matches

	UPDATE players
    set Password = 'newPassword'
    where Email = 'cfounds0@baidu.com';
    
    -- Changes assets value to 30 if below 30
    update asset
    set value = 30
    where value <30;
    
    -- Updates the first maps yMax to 40
    update map 
    set yMax = 40
    where mapID = 1;
    
    -- Updates a message in chat (can be used to update messages after user has sent them
    update chat 
    set message = 'edited message'
    where chatID = 1;
    
-- SELECT QUERYS BELOW

	-- Selects assets that are not walls

	select * from asset
	where wall = false;

	select * from map;
    
    select * from players;
    

 -- INSERT QUERYS:

insert into map (HomeTileRow, HomeTileColumn, xMax, yMax) values (80, 70, 250, 250);

insert into players (Email, password, rowID, columnID, score, login_count, locked_out,  length) values ('newplayer@email.com', 'password123', 0, 0, 0, 2, null,  1);

insert into asset  (value, description, Wall) values (30, 'eu interdum eu tincidunt in',false);

insert into chat ( message, ToID, FromID) values ('New message', 'lbarnet1@dmoz.org', 'lkerss2@blogtalkradio.com');


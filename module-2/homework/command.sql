DROP DATABASE food_oms;
CREATE DATABASE food_oms;
USE food_oms;

DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS item_categories;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS order_details;

CREATE TABLE items(
	id int auto_increment primary key,
    name varchar(50) not null,
	price int default 0
);


CREATE TABLE categories(
	id int auto_increment primary key,
    name varchar(50) not null unique
);

CREATE TABLE item_categories(
	item_id int not null,
    category_id int not null,
    primary key(item_id, category_id),
    foreign key(item_id) references items(id) on delete cascade,
    foreign key(category_id) references categories(id) on delete cascade
);

INSERT INTO items(name, price) values
('Nasi Goreng Gila', 25000),
('Ice Water', 2000),
('Spaghetti', 40000),
('Green Tea Latte', 18000),
('Orange Juice', 15000),
('Vanilla Ice Cream', 13000),
('Cordon Bleu', 36000),
('French Fries', 15000),
('Scrambled Egg', 5000),
('Sunny Side Up', 5000);

INSERT INTO categories(name) values
('main dish'),('beverage'),('dessert'),('extra');

INSERT INTO item_categories values
(1,1),
(2,2),
(3,1),
(4,2),
(5,2),
(6,3),
(7,1),
(8,4),
(9,4),
(10,4);

CREATE TABLE users(
	id int auto_increment primary key,
    name varchar(50) not null,
	phone_number varchar(30) not null unique
);

CREATE TABLE orders(
	id int auto_increment primary key,
    user_id int references users(id),
    order_date timestamp default current_timestamp,
    type enum('dine in', 'takeaway', 'delivery') not null
);

CREATE TABLE order_details(
	order_id int references orders(id),
    item_id int references items(id),
    qty int not null,
    primary key(order_id, item_id),
    constraint qty_only_positive check(qty >= 0)
);

INSERT INTO users(name, phone_number) values
('Diana Huber', '+620192832324'),
('Trevor Vu', '+62129382382'),
('Riyad Clemons','+62283787264'),
('Tudor Deacon', '+62238928401'),
('Brielle Mackie', '+620293041273');

INSERT INTO orders(user_id, type) values
(1, 'takeaway'),
(2, 'dine in'),
(1, 'delivery'),
(3, 'delivery'),
(5, 'delivery');

INSERT INTO order_details(order_id, item_id, qty) values
(1, 1, 2), (1, 9, 2), (1, 2, 3),
(2, 3, 1), (2, 4, 1),
(3, 7, 1), (3, 8, 1),
(4, 1, 3), (4, 3, 1), (4, 7, 1),
(5, 3, 2), (5, 5, 1), (5, 6, 1);

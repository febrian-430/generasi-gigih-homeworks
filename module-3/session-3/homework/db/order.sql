CREATE TABLE orders(
    reference_no varchar(255) not null,
    customer_name varchar(255) default null,
    date varchar(100) default null,
    primary key (reference_no)
)
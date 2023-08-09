-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema FinalProject
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema FinalProject
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `FinalProject` DEFAULT CHARACTER SET utf8 ;
USE `FinalProject` ;

-- -----------------------------------------------------
-- Table `FinalProject`.`publisher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FinalProject`.`publisher` ;

CREATE TABLE IF NOT EXISTS `FinalProject`.`publisher` (
  `publisher_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `publisher_name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NULL,
  `zip` VARCHAR(45) NULL,
  PRIMARY KEY (`publisher_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FinalProject`.`Book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FinalProject`.`Book` ;

CREATE TABLE IF NOT EXISTS `FinalProject`.`Book` (
  `book_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ISBN` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `price` DECIMAL(4,2) NOT NULL,
  `publisher_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`book_id`),
  CONSTRAINT `fk_Book_publisher1`
    FOREIGN KEY (`publisher_id`)
    REFERENCES `FinalProject`.`publisher` (`publisher_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Book_publisher1_idx` ON `FinalProject`.`Book` (`publisher_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `FinalProject`.`author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FinalProject`.`author` ;

CREATE TABLE IF NOT EXISTS `FinalProject`.`author` (
  `author_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `middle_name` VARCHAR(45) NULL,
  `publisher_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`author_id`),
  CONSTRAINT `fk_author_publisher1`
    FOREIGN KEY (`publisher_id`)
    REFERENCES `FinalProject`.`publisher` (`publisher_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_author_publisher1_idx` ON `FinalProject`.`author` (`publisher_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `FinalProject`.`store`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FinalProject`.`store` ;

CREATE TABLE IF NOT EXISTS `FinalProject`.`store` (
  `store_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `store_address` VARCHAR(45) NOT NULL,
  `store_city` VARCHAR(45) NOT NULL,
  `store_state` VARCHAR(2) NOT NULL,
  `store_zip` INT NOT NULL,
  `store_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`store_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FinalProject`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FinalProject`.`employee` ;

CREATE TABLE IF NOT EXISTS `FinalProject`.`employee` (
  `employee_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip` VARCHAR(45) NOT NULL,
  `store_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`employee_id`),
  CONSTRAINT `fk_employee_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `FinalProject`.`store` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_employee_store1_idx` ON `FinalProject`.`employee` (`store_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `FinalProject`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FinalProject`.`customer` ;

CREATE TABLE IF NOT EXISTS `FinalProject`.`customer` (
  `customer_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_first_name` VARCHAR(45) NOT NULL,
  `customer_last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FinalProject`.`purchase`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FinalProject`.`purchase` ;

CREATE TABLE IF NOT EXISTS `FinalProject`.`purchase` (
  `purchase_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `is_reward_member` VARCHAR(1) NOT NULL,
  `purchase_item` VARCHAR(45) NOT NULL,
  `customer_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`purchase_id`),
  CONSTRAINT `fk_purchase_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `FinalProject`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_purchase_customer_idx` ON `FinalProject`.`purchase` (`customer_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `FinalProject`.`book_author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FinalProject`.`book_author` ;

CREATE TABLE IF NOT EXISTS `FinalProject`.`book_author` (
  `book_id` INT UNSIGNED NULL,
  `author_id` INT UNSIGNED NOT NULL,
  `book_author_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`book_author_id`),
  CONSTRAINT `fk_Book_has_author_Book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `FinalProject`.`Book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Book_has_author_author1`
    FOREIGN KEY (`author_id`)
    REFERENCES `FinalProject`.`author` (`author_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Book_has_author_author1_idx` ON `FinalProject`.`book_author` (`author_id` ASC) VISIBLE;

CREATE INDEX `fk_Book_has_author_Book1_idx` ON `FinalProject`.`book_author` (`book_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `FinalProject`.`misc_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FinalProject`.`misc_item` ;

CREATE TABLE IF NOT EXISTS `FinalProject`.`misc_item` (
  `item_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_type` VARCHAR(45) NOT NULL,
  `item_price` DECIMAL(4,2) NULL,
  PRIMARY KEY (`item_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FinalProject`.`inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FinalProject`.`inventory` ;

CREATE TABLE IF NOT EXISTS `FinalProject`.`inventory` (
  `inventory_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `book_id` INT UNSIGNED NOT NULL,
  `item_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`inventory_id`),
  CONSTRAINT `fk_inventory_Book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `FinalProject`.`Book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_misc_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `FinalProject`.`misc_item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_inventory_Book1_idx` ON `FinalProject`.`inventory` (`book_id` ASC) VISIBLE;

CREATE INDEX `fk_inventory_misc_item1_idx` ON `FinalProject`.`inventory` (`item_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `FinalProject`.`genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FinalProject`.`genre` ;

CREATE TABLE IF NOT EXISTS `FinalProject`.`genre` (
  `genre_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `genre_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`genre_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FinalProject`.`book_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FinalProject`.`book_genre` ;

CREATE TABLE IF NOT EXISTS `FinalProject`.`book_genre` (
  `book_id` INT UNSIGNED NOT NULL,
  `genre_id` INT UNSIGNED NOT NULL,
  `book_genre_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`book_genre_id`),
  CONSTRAINT `fk_Book_has_Genre_Book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `FinalProject`.`Book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Book_has_Genre_Genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `FinalProject`.`genre` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Book_has_Genre_Genre1_idx` ON `FinalProject`.`book_genre` (`genre_id` ASC) VISIBLE;

CREATE INDEX `fk_Book_has_Genre_Book1_idx` ON `FinalProject`.`book_genre` (`book_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `FinalProject`.`payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FinalProject`.`payment` ;

CREATE TABLE IF NOT EXISTS `FinalProject`.`payment` (
  `payment_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `payment_amount` VARCHAR(45) NOT NULL,
  `payment_source` VARCHAR(45) NOT NULL,
  `purchase_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`payment_id`),
  CONSTRAINT `fk_payment_purchase1`
    FOREIGN KEY (`purchase_id`)
    REFERENCES `FinalProject`.`purchase` (`purchase_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_payment_purchase1_idx` ON `FinalProject`.`payment` (`purchase_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `FinalProject`.`payment_source`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FinalProject`.`payment_source` ;

CREATE TABLE IF NOT EXISTS `FinalProject`.`payment_source` (
  `payment_source_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `payment_type` ENUM('cash', 'debit', 'credit', 'check', 'rewards') NOT NULL,
  `payment_amount` DECIMAL(15,2) NOT NULL,
  `payment_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`payment_source_id`),
  CONSTRAINT `fk_payment_source_payment1`
    FOREIGN KEY (`payment_id`)
    REFERENCES `FinalProject`.`payment` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_payment_source_payment1_idx` ON `FinalProject`.`payment_source` (`payment_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `FinalProject`.`purchase_items`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `FinalProject`.`purchase_items` ;

CREATE TABLE IF NOT EXISTS `FinalProject`.`purchase_items` (
  `book_id` INT UNSIGNED NULL,
  `purchase_id` INT UNSIGNED NOT NULL,
  `item_id` INT UNSIGNED NOT NULL,
  `purchase_items_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`purchase_items_id`),
  CONSTRAINT `fk_Book_has_purchase_Book1`
    FOREIGN KEY (`book_id`)
    REFERENCES `FinalProject`.`Book` (`book_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Book_has_purchase_purchase1`
    FOREIGN KEY (`purchase_id`)
    REFERENCES `FinalProject`.`purchase` (`purchase_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Book_has_purchase_misc_item1`
    FOREIGN KEY (`item_id`)
    REFERENCES `FinalProject`.`misc_item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Book_has_purchase_purchase1_idx` ON `FinalProject`.`purchase_items` (`purchase_id` ASC) VISIBLE;

CREATE INDEX `fk_Book_has_purchase_Book1_idx` ON `FinalProject`.`purchase_items` (`book_id` ASC) VISIBLE;

CREATE INDEX `fk_Book_has_purchase_misc_item1_idx` ON `FinalProject`.`purchase_items` (`item_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

USE finalproject;
INSERT INTO genre
(genre_name)
VALUES
('Fantasy'),
('Teen'),
('Sothern Gothic'),
('Sci-Fi'),
('Distopian'),
('Non-Fiction');

INSERT INTO publisher
(publisher_name, address, city, state, zip)
VALUES
('Simon & Schuster Books for young readers', '1230 Avenue of the Americas', 'New York', 'NY', 10020),
('Entangled: Teen', '2614 S Timberline Rd, St. 109', 'Fort Collins', 'CO', 80525),
('Pottermore Publishing', 'W1A 4GE', 'London', NULL, NULL),
('Knopf Books for young readers', '1745 Broadway', 'New York', 'NY', 10019),
('Thomas Nelson', '501 Nelson Pl', 'Nashville', 'TN', 37214),
('Harper Perennial', '195 Broadway', 'New York', 'NY', 10007),
('Sourcebooks Fire', '18 Cherry St', 'Milford', 'CT', 06460),
('Penguin Books', 'CO7 7DW Colchester', 'Frating', NULL, NULL);

INSERT INTO book
(ISBN, title, price, publisher_id)
VALUES 
(16995562, "'It's Not Summer without you'", 9.36, 1),
(1416995595, "'We'll Always Have Summer'", 9.31, 1),
(1665922079, 'The Summer I turned Pretty', 9.25, 1),
(1529355559, 'Crave', 13.88, 2), 
(0439708184, "'Harry Potter and the Sorcer's Stone'", 9.99, 3), 
(0375842209, 'The Book Thief', 10.99, 4), 
(0439064872, 'Harry Potter and the Chamber of Secrets', 6.98, 3),
(0439136369, 'Harry Potter and the Prisoner of Azkaban', 8.00, 3),
(1408855682, 'Harry Potter and the Goblet of Fire', 15.94, 3),
(1338299182, 'Harry Potter and the Order of the Phoenix', 9.30, 3),
(1338299190, 'Harry Potter and the Half Blood Prince', 9.33, 3),
(1408855712, 'Harry Potter and the Deathly Hallows', 14.70, 3),
(0785238573, 'We Were kings', 8.99, 5), 
(0060935464, 'To Kill a Mockingbird', 7.19, 6),
(1728210291, 'The Summer of Broken Rules', 9.89, 7),
(0399501487, 'Lord of the Flies', 9.69, 8);

INSERT INTO misc_item
(item_type, item_price)
VALUES
('Snickers Candy Bar', 1.30),
('100-Grand Candy Bar', 1.25),
('Sour Patch Kids Watermelon Candy', 2.00),
('Bookmark', 0.99), 
('Book Themed Stuffed Plushies', 20.00),
('Book', NULL);

INSERT INTO store
(store_address, store_city, store_state, store_zip, store_type)
VALUES
('33 East 17th Street', 'New York', 'NY', 10003, 'Main'),
('4601 26th Avenue NE', 'Seattle', 'WA', 98105, 'Branch'),
('1005 W. Burnside St.', 'Portland', 'OR', 97205, 'Branch');

INSERT INTO employee
(first_name, last_name, address, city, state, zip, store_id)
VALUES
('Chet', 'Hurts', '2234 N West Street', 'New York', 'NY', 10003, 1),
('Jalen', 'Hanks', '296 South Street', 'New York', 'NY', 10003, 1),
('Suzy', 'Davids', '2100 N West Steet', 'New York', 'NY', 10003, 1), 
('Risalyn', 'Swensen', '234 South APT 22', 'Seattle', 'WA', 98105, 2),
('Jose', 'Suarez', '260 South APT 2', 'Seattle', 'WA', 98105, 2),
('Jeffrey', 'Bezos', '377 Rich Ave', 'Portland', 'OR', 97205, 3);

INSERT INTO customer
(customer_first_name, customer_last_name)
VALUES
('Dave', 'David'),
('Susan', 'Stevens'),
('Bubba', 'Moon'),
('Corinne', 'Klinger'),
('MacKay', 'Abbeglen'),
('Steffen', 'Larsen'),
('Cody', 'Abbeglen'),
('Koby', 'Paker'),
('Kandace', 'Parker'),
('Roman', 'Swensen');

INSERT INTO author
(first_name, last_name, middle_name, publisher_id)
VALUES
('Jenny', 'Han', NULL, 1),
('Tracy', 'Wolf', NULL, 2),
('J.K', 'Rowling', NULL, 3),
('Markos', 'Zusak', NULL, 4),
('Court', 'Stevens', NULL, 5),
('Harper', 'Lee', NULL, 6),
('K.L.', 'Walther', NULL, 7), 
('William', 'Golding', NULL, 8);

INSERT INTO purchase
(is_reward_member, purchase_item, customer_id)
VALUES
('Y', 'Book', 1),
('Y', 'Candy', 1),
('N', 'Book Mark', 2),
('N', 'Candy', 3),
('N', 'Plush', 4),
('N', 'Candy', 5),
('N', 'Book', 6),
('N', 'Book', 7),
('N', 'Book', 8),
('N', 'Book', 9),
('Y', 'Book Mark', 10);

INSERT INTO payment
(payment_amount, payment_source, purchase_id)
VALUES
(9.99, 'Cash', 1),
(1.30, 'Debit', 1),
(0.99, 'Check', 2),
(2.00, 'Cash', 3),
(20.00, 'Credit', 4),
(1.25, 'Debit', 5),
(9.36, 'Cash', 6),
(9.31, 'Cash', 7),
(9.25, 'Cash', 8),
(13.88, 'Cash', 9),
(0.99, 'Debit', 10);

INSERT INTO payment_source
(payment_type, payment_amount, payment_id)
VALUES
(1, 1, 1),
(2, 2, 1),
(4, 3, 2),
(1, 4, 3),
(3, 5, 4),
(2, 6, 5),
(1, 7, 6),
(1, 8, 7),
(1, 9, 8),
(1, 10, 9),
(2, 3, 10);

INSERT INTO purchase_items
(book_id, purchase_id, item_id)
VALUES
(5, 1, 6),
(NULL, 1, 1),
(NULL, 2, 4),
(NULL, 3, 3),
(NULL, 4, 5),
(NULL, 5, 2),
(12, 6, 6),
(1, 7, 6),
(2, 8, 6),
(4, 9, 6),
(NULL, 10, 4);

INSERT INTO book_genre
(book_id, genre_id)
VALUES
(1, 2),
(2, 2),
(3, 2),
(4, 2),
(5, 1),
(6, 2),
(7, 1),
(8, 1),
(9, 1),
(10, 1), 
(11, 1),
(12, 1),
(13, 3),
(14, 3),
(15, 2),
(16, 3);

INSERT INTO book_author
(book_id, author_id)
VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 3),
(6, 4),
(7, 3),
(8, 3),
(9, 3),
(10, 3), 
(11, 3),
(12, 3),
(13, 5),
(14, 6),
(15, 7),
(16, 8);

INSERT INTO inventory
(book_id, item_id)
VALUES
(1, 6),
(2, 6),
(3, 6),
(4, 6),
(5, 6),
(6, 6),
(7, 6),
(8, 6),
(9, 6),
(10, 6), 
(11, 6),
(12, 6),
(13, 6),
(14, 6),
(15, 6),
(16, 6);

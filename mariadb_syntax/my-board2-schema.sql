SET foreign_key_checks = 0;

DROP TABLE IF EXISTS author;

CREATE TABLE author (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    password varchar(255),
    email varchar(255) NOT NULL UNIQUE,
    created_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS post;

CREATE TABLE post (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    contents varchar(3000),
    created_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS author_post;

CREATE TABLE author_post (
    id INT PRIMARY KEY AUTO_INCREMENT,
    author_id INT NOT NULL,
    post_id INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES author(id),
    FOREIGN KEY (post_id) REFERENCES post(id)
);

DROP TABLE IF EXISTS author_address;

CREATE TABLE author_address (
    id INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(255) NOT NULL,
    street VARCHAR(255) NOT NULL,
    author_id INT NOT NULL UNIQUE,
    FOREIGN KEY (author_id) REFERENCES author(id) ON DELETE CASCADE
);

SET foreign_key_checks = 1;



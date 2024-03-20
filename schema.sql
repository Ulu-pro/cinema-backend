CREATE TABLE `ContentGroup`
(
    `content_group_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE `Category`
(
    `category_id` INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name`        TEXT NOT NULL
);

CREATE TABLE `Genre`
(
    `genre_id` INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name`     TEXT NOT NULL
);

CREATE TABLE `StatusCode`
(
    `status_code_id` INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `description`    TEXT NOT NULL
);

CREATE TABLE `User`
(
    `user_id`         INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `username`        TEXT NOT NULL,
    `email`           TEXT NOT NULL,
    `password_hash`   TEXT NOT NULL,
    `date_registered` DATE NOT NULL
);

CREATE TABLE `Content`
(
    `content_id`       INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `content_group_id` INT  NOT NULL,
    `category_id`      INT  NOT NULL,
    `genre_id`         INT  NOT NULL,
    `title`            TEXT NOT NULL,
    `description`      TEXT NOT NULL,
    `duration`         INT  NOT NULL,
    `release_date`     DATE NOT NULL
);

CREATE TABLE `Season`
(
    `season_id`  INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `content_id` INT  NOT NULL,
    `title`      TEXT NOT NULL
);

CREATE TABLE `Episode`
(
    `episode_id`   INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `season_id`    INT  NOT NULL,
    `title`        TEXT NOT NULL,
    `duration`     INT  NOT NULL,
    `release_date` DATE NOT NULL
);

CREATE TABLE `Comment`
(
    `comment_id`        INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `parent_comment_id` INT  NULL,
    `user_id`           INT  NOT NULL,
    `content_id`        INT  NOT NULL,
    `text`              TEXT NOT NULL,
    `date_commented`    DATE NOT NULL
);

CREATE TABLE `CommentReaction`
(
    `comment_reaction_id` INT        NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id`             INT        NOT NULL,
    `comment_id`          INT        NOT NULL,
    `is_like`             TINYINT(1) NOT NULL
);

CREATE TABLE `Status`
(
    `status_id`      INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id`        INT  NOT NULL,
    `content_id`     INT  NOT NULL,
    `status_code_id` INT  NOT NULL,
    `date_updated`   DATE NOT NULL
);

CREATE TABLE `Rating`
(
    `rating_id`  INT  NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id`    INT  NOT NULL,
    `content_id` INT  NOT NULL,
    `value`      INT  NOT NULL,
    `date_rated` DATE NOT NULL
);

ALTER TABLE `Comment`
    ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`);
ALTER TABLE `Comment`
    ADD FOREIGN KEY (`content_id`) REFERENCES `Content` (`content_id`);
ALTER TABLE `Comment`
    ADD FOREIGN KEY (`parent_comment_id`) REFERENCES `Comment` (`comment_id`);

ALTER TABLE `Season`
    ADD FOREIGN KEY (`content_id`) REFERENCES `Content` (`content_id`);

ALTER TABLE `Content`
    ADD FOREIGN KEY (`content_group_id`) REFERENCES `ContentGroup` (`content_group_id`);
ALTER TABLE `Content`
    ADD FOREIGN KEY (`category_id`) REFERENCES `Category` (`category_id`);
ALTER TABLE `Content`
    ADD FOREIGN KEY (`genre_id`) REFERENCES `Genre` (`genre_id`);

ALTER TABLE `CommentReaction`
    ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`);
ALTER TABLE `CommentReaction`
    ADD FOREIGN KEY (`comment_id`) REFERENCES `Comment` (`comment_id`);

ALTER TABLE `Status`
    ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`);
ALTER TABLE `Status`
    ADD FOREIGN KEY (`content_id`) REFERENCES `Content` (`content_id`);
ALTER TABLE `Status`
    ADD FOREIGN KEY (`status_code_id`) REFERENCES `StatusCode` (`status_code_id`);

ALTER TABLE `Episode`
    ADD FOREIGN KEY (`season_id`) REFERENCES `Season` (`season_id`);

ALTER TABLE `Rating`
    ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`);
ALTER TABLE `Rating`
    ADD FOREIGN KEY (`content_id`) REFERENCES `Content` (`content_id`);

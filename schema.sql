CREATE TABLE `Category`
(
    `category_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name`        TEXT         NOT NULL
);

CREATE TABLE `ContentGroup`
(
    `content_group_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE `StatusCode`
(
    `status_code_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `description`    TEXT         NOT NULL
);

CREATE TABLE `Genre`
(
    `genre_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name`     TEXT         NOT NULL
);

CREATE TABLE `User`
(
    `user_id`         INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `username`        TEXT         NOT NULL,
    `email`           TEXT         NOT NULL,
    `password_hash`   TEXT         NOT NULL,
    `date_registered` DATE         NOT NULL
);

CREATE TABLE `Content`
(
    `content_id`       INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `content_group_id` INT UNSIGNED NOT NULL,
    `category_id`      INT UNSIGNED NOT NULL,
    `title`            TEXT         NOT NULL,
    `description`      TEXT         NOT NULL,
    `duration`         INT UNSIGNED NOT NULL,
    `release_date`     DATE         NOT NULL,
    FOREIGN KEY (`category_id`) REFERENCES `Category` (`category_id`),
    FOREIGN KEY (`content_group_id`) REFERENCES `ContentGroup` (`content_group_id`)
);

CREATE TABLE `Season`
(
    `season_id`  INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `content_id` INT UNSIGNED NOT NULL,
    `title`      TEXT         NOT NULL,
    FOREIGN KEY (`content_id`) REFERENCES `Content` (`content_id`)
);

CREATE TABLE `Episode`
(
    `episode_id`   INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `season_id`    INT UNSIGNED NOT NULL,
    `title`        TEXT         NOT NULL,
    `duration`     INT UNSIGNED NOT NULL,
    `release_date` DATE         NOT NULL,
    FOREIGN KEY (`season_id`) REFERENCES `Season` (`season_id`)
);

CREATE TABLE `Comment`
(
    `comment_id`        INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `parent_comment_id` INT UNSIGNED NULL,
    `user_id`           INT UNSIGNED NOT NULL,
    `content_id`        INT UNSIGNED NOT NULL,
    `text`              TEXT         NOT NULL,
    `date_commented`    DATE         NOT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`),
    FOREIGN KEY (`content_id`) REFERENCES `Content` (`content_id`)
);

CREATE TABLE `CommentReaction`
(
    `comment_reaction_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id`             INT UNSIGNED NOT NULL,
    `comment_id`          INT UNSIGNED NOT NULL,
    `is_positive`         TINYINT(1)   NOT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`),
    FOREIGN KEY (`comment_id`) REFERENCES `Comment` (`comment_id`)
);

CREATE TABLE `Rating`
(
    `rating_id`  INT UNSIGNED     NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id`    INT UNSIGNED     NOT NULL,
    `content_id` INT UNSIGNED     NOT NULL,
    `value`      TINYINT UNSIGNED NOT NULL,
    `date_rated` DATE             NOT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`),
    FOREIGN KEY (`content_id`) REFERENCES `Content` (`content_id`)
);

CREATE TABLE `ContentGenre`
(
    `content_genre_id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `content_id`       INT UNSIGNED NOT NULL,
    `genre_id`         INT UNSIGNED NOT NULL,
    FOREIGN KEY (`content_id`) REFERENCES `Content` (`content_id`),
    FOREIGN KEY (`genre_id`) REFERENCES `Genre` (`genre_id`)
);

CREATE TABLE `Status`
(
    `status_id`      INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id`        INT UNSIGNED NOT NULL,
    `content_id`     INT UNSIGNED NOT NULL,
    `status_code_id` INT UNSIGNED NOT NULL,
    `date_updated`   DATE         NOT NULL,
    FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`),
    FOREIGN KEY (`content_id`) REFERENCES `Content` (`content_id`),
    FOREIGN KEY (`status_code_id`) REFERENCES `StatusCode` (`status_code_id`)
);

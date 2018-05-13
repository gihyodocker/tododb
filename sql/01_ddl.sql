CREATE TABLE todo (
  `id`      INT(10) UNSIGNED AUTO_INCREMENT NOT NULL COMMENT 'ID',
  `title`   VARCHAR(188) NOT NULL                    COMMENT 'タイトル',
  `content` TEXT                                     COMMENT '内容',
  `status`  ENUM('TODO', 'PROGRESS', 'DONE')         COMMENT 'ステータス',
  `created` DATETIME NOT NULL                        COMMENT '作成時間',
  `updated` DATETIME NOT NULL                        COMMENT '更新時間',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

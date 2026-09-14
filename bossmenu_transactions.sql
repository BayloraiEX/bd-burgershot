CREATE TABLE IF NOT EXISTS `burgershot_transactions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(10) NOT NULL,
  `amount` INT NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

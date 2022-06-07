CREATE TABLE `jerzys_tuning_payment` (
  `id` int(11) NOT NULL,
  `plate` varchar(225) NOT NULL,
  `payed` tinyint(1) NOT NULL,
  `vehicle_mods` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

ALTER TABLE `jerzys_tuning_payment`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `jerzys_tuning_payment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;
COMMIT;


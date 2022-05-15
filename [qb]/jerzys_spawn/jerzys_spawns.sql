CREATE TABLE `jerzys_spawns` (
  `id` bigint(20) NOT NULL,
  `cord_name` text NOT NULL,
  `cord_description` text DEFAULT NULL,
  `top_value` text NOT NULL,
  `left_value` text NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  `x_cord` text NOT NULL,
  `y_cord` text NOT NULL,
  `z_cord` text NOT NULL,
  `gang` text DEFAULT NULL,
  `job` text DEFAULT NULL,
  `showall` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


ALTER TABLE `jerzys_spawns`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `jerzys_spawns`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;
COMMIT;

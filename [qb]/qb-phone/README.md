*Go To qb-core > config.lua*
Add 'paycheck' To Line **9, 10**



-- QBConfig.Money.MoneyTypes = { ['cash'] = 500, ['bank'] = 5000, ['crypto'] = 0, ['paycheck'] = 0}
-- QBConfig.Money.DontAllowMinus = { 'cash', 'crypto', 'paycheck', 'bank'}
https://cdn.discordapp.com/attachments/943928793809158164/949637251300749322/unknown.png
https://cdn.discordapp.com/attachments/943928793809158164/949637372180590612/unknown.png


===================================================================================================================


*Go To qb-core > server > player.lua*
Search Functions 'AddMoney & RemoveMoney'

Add reason To Line **270, 300**
https://cdn.discordapp.com/attachments/943928793809158164/949642246691651594/unknown.png


===================================================================================================================


*Add Table For DataBase*

CREATE TABLE IF NOT EXISTS `phone_debt` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `amount` int(11) NOT NULL DEFAULT 0,
  `sender` varchar(50) DEFAULT NULL,
  `sendercitizenid` varchar(50) DEFAULT NULL,
  `reason` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb3;

CREATE TABLE IF NOT EXISTS `phone_note` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `citizenid` varchar(50) DEFAULT NULL,
  `title` text DEFAULT NULL,
  `text` text DEFAULT NULL,
  `lastupdate` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `citizenid` (`citizenid`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb3;
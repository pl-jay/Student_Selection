/* candidates table */
CREATE TABLE `candidates` (
  `cand_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `nic` varchar(40) DEFAULT NULL,
  `address1` varchar(45) DEFAULT NULL,
  `address2` varchar(45) DEFAULT NULL,
  `address3` varchar(45) DEFAULT NULL,
  `alstream` varchar(40) DEFAULT NULL,
  `zscore` varchar(45) DEFAULT NULL,
  `option1` varchar(45) DEFAULT NULL,
  `option2` varchar(45) DEFAULT NULL,
  `option3` varchar(45) DEFAULT NULL,
  `isSelected` bit(1) DEFAULT b'0',
  `isConfirmed` bit(1) DEFAULT b'0',
  `ge` varchar(4) DEFAULT NULL,
  `eng` varchar(4) DEFAULT NULL,
  `media` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`cand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/* choices table */

CREATE TABLE `choices` (
  `choice_id` int(11) NOT NULL AUTO_INCREMENT,
  `program` varchar(45) DEFAULT NULL,
  `limit` int(11) DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  PRIMARY KEY (`choice_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/* selected_list */

CREATE TABLE `selected_list` (
  `id` int(11) DEFAULT NULL,
  `nic` varchar(30) DEFAULT NULL,
  `alstream` varchar(40) DEFAULT NULL,
  `zscore` float DEFAULT NULL,
  `selected_degree_program` varchar(30) DEFAULT NULL,
  `selected_option` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/* unselected list */

CREATE TABLE `unselected_list` (
  `id` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `nic` varchar(30) DEFAULT NULL,
  `alstream` varchar(40) DEFAULT NULL,
  `zscore` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

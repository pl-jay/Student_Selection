/* AL2Prog */

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `AL2Prog`(alstream VARCHAR(30), program VARCHAR(5), c_id INT) RETURNS bit(1)
    NO SQL
BEGIN

if program = "SOF" || program = "NET" || program = "MMW" then         
	if 	alstream = "Commerce" || alstream = "Engineering Technology" || 
		alstream = "MATHS" || alstream = "Bio System Technology" || alstream = "Bio" || alstream = "Art" then
		return 1;
	else
		return 0;
	end if;
elseif program = "MEC" || program = "BST" || program = "MAN" then
	if alstream = "Engineering Technology" then
		return 1;
	else
		return 0;
	end if;
elseif program = "IM" then         
	if alstream = "Commerce" || alstream = "Engineering Technology" || alstream = "MATHS" then
		return 1;
	else
		return 0;
	end if;
elseif program = "FPT" then
	if alstream = "Bio System Technology" || alstream = "Bio" then 
		return 1;
	else
		return 0;
	end if;
elseif program = "ELT" then   
	if subjectResult(c_id, "ELT") then
		return 1;	#if alstream = "ANY with GE-C" || alstream = "ANY with E-S" then
	else
		return 0;
	end if;
elseif program = "CTRM" then         
	if alstream = "Engineering Technology" then
		return 1;
	else
		return 0;
	end if;
elseif program = "MEDIA" then         
	if subjectResult(c_id, "MEDIA") then
		return 1;
	else
		return 0;
	end if;
else
    return 0;
	
end if;

RETURN 1;
END$$
DELIMITER ;


/* AlStream for student */
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `AlStreamForStudent`(c_id INT) RETURNS varchar(30) CHARSET utf8mb4
    READS SQL DATA
BEGIN
RETURN (SELECT alstream FROM candidates WHERE cand_id = c_id);
END$$
DELIMITER ;

/* create final list*/

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `createFinalList`(c_id INT,s_program VARCHAR(10) , s_option INT,set_unset BIT) RETURNS bit(1)
    DETERMINISTIC
BEGIN
DECLARE return_val BIT;
DECLARE zscore_res FLOAT;
DECLARE nic_res VARCHAR(40);
DECLARE als VARCHAR(40);
DECLARE name_res VARCHAR(50);


SET nic_res    = (SELECT nic from candidates WHERE cand_id = c_id);
SET zscore_res = (SELECT zscore from candidates WHERE cand_id = c_id);
SET als		   = (SELECT alstream from candidates WHERE cand_id = c_id);
SET name_res   = (SELECT name from candidates WHERE cand_id = c_id);



IF(set_unset = 1) THEN
	INSERT INTO selected_list (`id`,`nic`,`alstream`,`zscore`,`selected_degree_program`,`selected_option`) 
		   VALUES (c_id, nic_res, als,zscore_res,s_program,s_option);
	SET return_val = 1;
ELSE
	DELETE FROM selected_list WHERE id = c_id;
    
    INSERT INTO unselected_list (`id`,`name`,`nic`,`alstream`,`zscore`) 
		   VALUES (c_id, name_res,nic_res, als,zscore_res);
           
	SET return_val = 0;
END IF;

RETURN return_val;
END$$
DELIMITER ;


/* options by student */

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `OptionsByStudent`(c_id INT, option_no INT) RETURNS varchar(5) CHARSET utf8mb4
    READS SQL DATA
BEGIN

DECLARE Result VARCHAR(5);

IF option_no = 1 THEN
	SET Result = (SELECT option1 FROM candidates WHERE cand_id = c_id);
ELSEIF option_no = 2 THEN
	SET Result = (SELECT option2 FROM candidates WHERE cand_id = c_id);
ELSEIF option_no = 3 THEN
	SET Result = (SELECT option3 FROM candidates WHERE cand_id = c_id);

END IF;

RETURN Result;
END$$
DELIMITER ;


/* student limit by program */

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `StudentLimitByProgram`(prog VARCHAR(5)) RETURNS int(11)
    READS SQL DATA
BEGIN

DECLARE STU_LIMIT INT;

SET STU_LIMIT = 0;

SET STU_LIMIT = (SELECT `limit` FROM choices WHERE program = concat(prog) );

RETURN STU_LIMIT;
END$$
DELIMITER ;


/* subject result */

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `subjectResult`(c_id INT, subject_name VARCHAR(10)) RETURNS bit(1)
    DETERMINISTIC
BEGIN

DECLARE result_ge CHAR;
DECLARE result_eng CHAR;
DECLARE result_media CHAR;
DECLARE res_bit BIT;


IF subject_name = "MEDIA" THEN
	SET result_media = (SELECT UPPER(media) FROM candidates WHERE cand_id = c_id);
	IF result_media != "F" THEN
		SET res_bit = 1;
	ELSE
		SET res_bit = 0;
    END IF;
ELSE IF subject_name = "ELT" THEN
	SET result_ge 	= (SELECT UPPER(ge)  FROM candidates WHERE cand_id = c_id);
    SET result_eng 	= (SELECT UPPER(eng) FROM candidates WHERE cand_id = c_id);
    
    IF result_eng != "F" || result_ge != "S" && result_ge != "F" THEN
		SET res_bit = 1;
	ELSE
		SET res_bit = 0;
    END IF;
    END IF;

END IF;

RETURN res_bit;
END$$
DELIMITER ;

 
/* update candidate */

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `updateCandidate`(c_id INT) RETURNS int(11)
    DETERMINISTIC
BEGIN
DECLARE updated BIT;
DECLARE newVal INT;
DECLARE oldVal INT;


SET oldVal = (SELECT isSelected from candidates WHERE cand_id = c_id);

UPDATE candidates SET isSelected = 1 WHERE cand_id = c_id AND isSelected = 0 AND isConfirmed = 0;

SET newVal = (SELECT isSelected from candidates WHERE cand_id = c_id);

IF(oldVal != newVal) THEN
	SET updated = 1;
ELSE
	SET updated = 0;
END IF;

RETURN updated;
END$$
DELIMITER ;


/* update limit */

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `updateLimit`(prog varchar(10), increase BIT) RETURNS bit(1)
    DETERMINISTIC
BEGIN
DECLARE updated BIT;
DECLARE newVal INT;
DECLARE oldVal INT;

SET oldVal = (SELECT `limit` FROM choices WHERE program = prog);

IF(increase = 0) THEN
	UPDATE choices SET `limit` = `limit` - 1 WHERE program = prog;
ELSE
	UPDATE choices SET `limit` = `limit` + 1 WHERE program = prog;
END IF;

SET newVal = (SELECT `limit` FROM choices WHERE program = prog);

IF(oldVal != newVal) THEN
	SET updated = 1;
ELSE
	SET updated = 0;
END IF;
RETURN updated;
END$$
DELIMITER ;

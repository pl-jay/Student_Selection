/* create Sorted list view  */
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `createSortedListView`()
BEGIN

CREATE VIEW sorted_byZscore AS
SELECT cand_id,cand_name,nic,alstream,zscore,option1,option2,option3 
FROM candidates ORDER BY zscore DESC;

select * from sorted_byzscore;

END$$
DELIMITER ;


/* Registration Procedure */

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `registration_procedure`(c_nic VARCHAR(40), up BIT)
BEGIN

DECLARE oldVal BIT;
DECLARE newVal BIT;
DECLARE limitUP BIT;
DECLARE result BIT;
DECLARE prog VARCHAR(10);

SET prog = (SELECT selected_degree_program FROM selected_list WHERE nic = c_nic);

#SET oldVal	= (SELECT isSelected FROM candidates WHERE cand_id = c_id);

IF up = 1 THEN 
	UPDATE candidates SET isConfirmed = 1 WHERE nic = c_nic;
ELSE 
	UPDATE candidates SET isSelected = 0, isConfirmed = 0 WHERE nic  = c_nic;
    
    SET limitUp = updateLimit(prog, 1);
    
END IF;
/*SET newVal	= (SELECT isSelected FROM candidates WHERE cand_id = c_id);

IF(oldVal != newVal AND limitUp) THEN
	SET result = 1;
ELSE
	SET result = 0;
END IF;
SELECT result;
*/
END$$
DELIMITER ;


/* Selection Procedure */

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Selection_Procedure`()
BEGIN

# DECLARATIONS
DECLARE cand_id INT;
DECLARE subject_list_length INT;
DECLARE cand_list_length INT;

DECLARE limitByProg INT;
DECLARE alstream VARCHAR(30);
DECLARE prog_option VARCHAR(5);

DECLARE method_bool BIT;


SET cand_list_length 	= (SELECT COUNT(*) FROM candidates);
SET subject_list_length = (SELECT COUNT(*) FROM choices);


# Assign values to Variables
SET cand_id = 1;
SET limitByProg = 0;

# second LOOP #
cand_table_loop: LOOP
IF cand_id > 5 then
	LEAVE cand_table_loop;
END IF;

#select incr1;
	
SET prog_option = OptionsByStudent(cand_id,1);
SET limitByProg = StudentLimitByProgram(prog_option);
SET alstream 	= AlStreamForStudent(cand_id);

IF(AL2Prog(alstream,prog_option, cand_id) && limitByProg > 0) THEN
	# UPDATE QUERY
    IF(updateCandidate(cand_id)) THEN
		IF(updateLimit(prog_option, 0)) THEN 
			#SELECT "SELECTED TO Option 1";
            SET  method_bool = createFinalList(cand_id,prog_option,1, 1);
            #insert into number_one (id, `alstream`, `zscore`,`selected_program`, `selected_option`) values (incr1, alstream, );
		END IF;
    END IF;
ELSE
	SET prog_option = OptionsByStudent(cand_id,2);
    SET limitByProg = StudentLimitByProgram(prog_option);
    #SELECT  "1st ELSE";
    IF(AL2Prog(alstream,prog_option, cand_id) && limitByProg > 0) THEN
		# UPDATE QUERY
        IF(updateCandidate(cand_id)) THEN
			IF(updateLimit(prog_option, 0)) THEN 
				#SELECT "SELECTED TO Option 2";
                SET  method_bool = createFinalList(cand_id,prog_option,2, 1);
                #insert into number_one (id, `name`, `option`, `program`) values (incr1, alstream, 2, prog_option);
			END IF;
		END IF;
    ELSE
		SET prog_option = OptionsByStudent(cand_id,3);
		SET limitByProg = StudentLimitByProgram(prog_option);
		#SELECT  "2nd ELSE";
		IF(AL2Prog(alstream,prog_option, cand_id) && limitByProg > 0) THEN
			# UPDATE QUERY
            IF(updateCandidate(cand_id)) THEN
				IF(updateLimit(prog_option, 0)) THEN 
					#SELECT "SELECTED TO Option 3";
                    SET  method_bool = createFinalList(cand_id,prog_option,3, 1);
                    #insert into number_one (id, `name`, `option`, `program`) values (incr1, alstream, 3, prog_option);
				END IF;
			END IF;
		ELSE
			SET  method_bool = createFinalList(cand_id,"",0, 0);
        END IF;
	END IF;

END IF;				


SET cand_id = cand_id + 1;
ITERATE cand_table_loop;
END LOOP;
#Loop Body

#WHILE limitByProg = 0
#DO SELECT "ASDASD";
#set limitByProg = limitByProg-1;
#END WHILE;
END$$
DELIMITER ;

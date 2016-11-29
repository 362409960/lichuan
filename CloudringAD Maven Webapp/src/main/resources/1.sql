DELIMITER $$

USE `cloudringesbwebdb`$$

DROP PROCEDURE IF EXISTS `P_INSERT_AVGDATA`$$

CREATE DEFINER=`root`@`%` PROCEDURE `P_INSERT_AVGDATA`(IN statTime VARCHAR(50) ,IN weekendTime VARCHAR(50),IN monthendTime VARCHAR(50))
BEGIN
	
	DECLARE done INT DEFAULT 0;
	DECLARE v_boxId VARCHAR(50);
	DECLARE v_data_type VARCHAR(50);
	DECLARE v_avf DOUBLE(10,2);
	DECLARE v_id VARCHAR(32);              -- 主键
	
	DECLARE v_boxId_s VARCHAR(50);
	DECLARE v_data_type_s VARCHAR(50);
	DECLARE v_avf_s DOUBLE(10,2);
	DECLARE v_id_s VARCHAR(32);              -- 主键
 
        -- 周定义游标
	DECLARE cur_terminal_week CURSOR FOR SELECT
			box_id,
			data_type,
			ROUND(AVG(DATA),2)	 AS avf
		FROM
			t_data_chart
	WHERE DATE_FORMAT(data_time,'%Y-%m-%d')<=DATE_FORMAT(statTime,'%Y-%m-%d') AND DATE_FORMAT(data_time,'%Y-%m-%d')>=DATE_FORMAT(weekendTime,'%Y-%m-%d')
	GROUP BY box_id,data_type;
	
	DECLARE cur_terminal_month CURSOR FOR SELECT box_id,data_type, ROUND(AVG(DATA),2) AS avf FROM t_data_chart 
	WHERE DATE_FORMAT(data_time,'%Y-%m-%d')<=DATE_FORMAT(statTime,'%Y-%m-%d') AND DATE_FORMAT(data_time,'%Y-%m-%d')>=DATE_FORMAT(monthendTime,'%Y-%m-%d')
	GROUP BY box_id,data_type;	
	
        -- 设置游标的终止条件(表示若没有数据返回,程序继续,并将变量IS_FOUND设为0)
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
 
        DELETE FROM t_avg_data  WHERE TO_DAYS(create_time) = TO_DAYS(NOW());
         -- 打开游标
         OPEN cur_terminal_week;
           FETCH cur_terminal_week INTO v_boxId,v_data_type, v_avf;       
         WHILE (done <> 1) DO
         IF (done<>1) THEN
             SELECT REPLACE(UUID(),"-","") INTO v_id;             
             INSERT INTO t_avg_data(id,avg_type,avg_val,data_type,create_time,box_id) VALUES(v_id,'week',v_avf,v_data_type,SYSDATE(),v_boxId);
               FETCH cur_terminal_week INTO v_boxId,v_data_type, v_avf;     
               END IF;  
         END WHILE;       
         CLOSE cur_terminal_week;
    
      -- 注意这里，一定要重置done的值为 0
	SET done = 0;
        
         -- 打开游标
         OPEN cur_terminal_month;
         FETCH cur_terminal_month INTO v_boxId_s,v_data_type_s, v_avf_s;
         WHILE (done <> 1) DO
          IF (done<>1) THEN
             SELECT REPLACE(UUID(),"-","") INTO v_id_s;             
             INSERT INTO t_avg_data(id,avg_type,avg_val,data_type,create_time,box_id) VALUES(v_id_s,'month',v_avf_s,v_data_type_s,SYSDATE(),v_boxId_s);
             FETCH cur_terminal_month INTO v_boxId_s,v_data_type_s, v_avf_s;
             END IF;
         END WHILE;       
         CLOSE cur_terminal_month;
        
    END$$

DELIMITER ;
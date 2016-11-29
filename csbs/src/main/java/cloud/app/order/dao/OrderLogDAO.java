package cloud.app.order.dao;

import java.util.List;

import cloud.app.order.model.OrderLog;

public interface OrderLogDAO {
    int deleteByPrimaryKey(String id);

    int insert(OrderLog record);

    int insertSelective(OrderLog record);

    OrderLog selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(OrderLog record);

    int updateByPrimaryKeyWithBLOBs(OrderLog record);

    int updateByPrimaryKey(OrderLog record);

	List<OrderLog> searchOrderLogs(OrderLog orderLog);
}
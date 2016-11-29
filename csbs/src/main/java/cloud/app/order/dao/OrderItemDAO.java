package cloud.app.order.dao;

import java.util.List;

import cloud.app.order.model.OrderItem;

public interface OrderItemDAO {
    int deleteByPrimaryKey(String id);

    int insert(OrderItem record);

    int insertSelective(OrderItem record);

    OrderItem selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(OrderItem record);

    int updateByPrimaryKey(OrderItem record);

	List<OrderItem> searchOrderItems(OrderItem orderItem);
}
package cloud.app.order.dao;

import java.util.List;

import cloud.app.order.model.Orders;
import cloud.app.order.vo.OrdersVO;

public interface OrdersDAO {
    int deleteByPrimaryKey(String id);

    int insert(Orders record);

    int insertSelective(Orders record);

    OrdersVO selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Orders record);

    int updateByPrimaryKeyWithBLOBs(Orders record);

    int updateByPrimaryKey(Orders record);
    
    List<OrdersVO> searchOrderList(OrdersVO record); 
    
    int searchOrderListCount(OrdersVO record);
    
    int updateSelective(OrdersVO record);
	
}
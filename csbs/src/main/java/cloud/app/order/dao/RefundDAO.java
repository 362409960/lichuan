package cloud.app.order.dao;

import cloud.app.order.model.Refund;

public interface RefundDAO {
    int deleteByPrimaryKey(String id);

    int insert(Refund record);

    int insertSelective(Refund record);

    Refund selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Refund record);

    int updateByPrimaryKeyWithBLOBs(Refund record);

    int updateByPrimaryKey(Refund record);
}
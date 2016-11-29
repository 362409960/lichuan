package cloud.app.order.dao;

import cloud.app.order.model.UserAddress;

public interface UserAddressDAO {
	int deleteByPrimaryKey(String id);

    int insert(UserAddress record);

    int insertSelective(UserAddress record);

    UserAddress selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(UserAddress record);

    int updateByPrimaryKey(UserAddress record);
}
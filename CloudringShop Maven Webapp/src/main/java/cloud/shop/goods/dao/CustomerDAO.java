package cloud.shop.goods.dao;

import java.util.Map;

import cloud.shop.goods.entity.Customer;

public interface CustomerDAO {

	Customer getUser(Customer user) throws Exception;

	void updateUser(Customer user) throws Exception;

	void updateUserPassword(Customer user) throws Exception;

	void insertCustomer(Customer user) throws Exception;

	int checkUsername(String name) throws Exception;

	int checkFieldStatus(Customer user) throws Exception;

	void updateUserPasswordByName(Customer user) throws Exception;

	Customer getUserIphone(String username) throws Exception;

	int checkPhone(String name) throws Exception;
	
	
	void esbWebUserRegist(Map<String, String> map)throws Exception;

}

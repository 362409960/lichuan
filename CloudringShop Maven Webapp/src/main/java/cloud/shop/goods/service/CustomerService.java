package cloud.shop.goods.service;

import java.util.Map;

import cloud.shop.goods.entity.Customer;

public interface CustomerService {

	public Customer getUser(Customer user) throws Exception;

	public void updateUser(Customer user) throws Exception;

	public void updateUserPassword(Customer user) throws Exception;

	public void insertCustomer(Customer user) throws Exception;

	public int checkUsername(String name) throws Exception;

	public int checkFieldStatus(Customer user) throws Exception;

	public void updateUserPasswordByName(Customer user) throws Exception;

	public Customer getUserIphone(String username) throws Exception;;

	public int checkPhone(String name) throws Exception;
	
	
	public void esbWebUserRegist(Map<String, String> map)throws Exception;
}

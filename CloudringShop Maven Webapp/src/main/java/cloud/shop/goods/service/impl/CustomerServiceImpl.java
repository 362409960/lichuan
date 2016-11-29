package cloud.shop.goods.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.shop.goods.dao.CustomerDAO;
import cloud.shop.goods.entity.Customer;
import cloud.shop.goods.service.CustomerService;
@Service
public class CustomerServiceImpl implements CustomerService {
	@Autowired
	private CustomerDAO customerDAO;

	@Override
	public Customer getUser(Customer user) throws Exception {
		
		return this.customerDAO.getUser(user);
	}

	@Override
	public void updateUser(Customer user) throws Exception {
		this.customerDAO.updateUser(user);
	}

	@Override
	public void updateUserPassword(Customer user) throws Exception {
		this.customerDAO.updateUserPassword(user);
		
	}

	@Override
	public void insertCustomer(Customer user) throws Exception {
		this.customerDAO.insertCustomer(user);		
		/*Map<String,String> map1=new HashMap<String, String>();
		map1.put("id", user.getId());
		map1.put("name", user.getName());
		map1.put("password", user.getPassword());
		map1.put("mobile", user.getMobile());
		map1.put("status", "0");
		esbWebUserRegist(map1);*/
	}

	@Override
	public int checkUsername(String name) throws Exception {
		// TODO Auto-generated method stub
		return this.customerDAO.checkUsername(name);
	}

	@Override
	public int checkFieldStatus(Customer user) throws Exception {
		// TODO Auto-generated method stub
		return this.customerDAO.checkFieldStatus(user);
	}

	

	@Override
	public void updateUserPasswordByName(Customer user) throws Exception {
		this.customerDAO.updateUserPasswordByName(user);
		
	}

	@Override
	public Customer getUserIphone(String username) throws Exception {
		// TODO Auto-generated method stub
		return this.customerDAO.getUserIphone(username);
	}

	@Override
	public int checkPhone(String name) throws Exception {
		// TODO Auto-generated method stub
		return this.customerDAO.checkPhone(name);
	}

	

	@Override
	public void esbWebUserRegist(Map<String, String> map) throws Exception {
		this.customerDAO.esbWebUserRegist(map);
		
	}

	

}

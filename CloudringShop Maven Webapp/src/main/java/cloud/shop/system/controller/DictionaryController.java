package cloud.shop.system.controller;



import java.io.PrintWriter;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;



import cloud.shop.common.Constants;
import cloud.shop.system.po.Dictionary;
import cloud.shop.system.service.DictionaryService;
import cloud.shop.system.vo.SysUserVO;

import com.fasterxml.jackson.databind.ObjectMapper;

/**
 * 验证码Controller
 * 
 *
 */
@Controller
@RequestMapping("/admin/dictionary")
public class DictionaryController {
	@Autowired
	private DictionaryService dictionaryService;
	
	public DictionaryService getDictionaryService() {
		return dictionaryService;
	}

	public void setDictionaryService(DictionaryService dictionaryService) {
		this.dictionaryService = dictionaryService;
	}
	
	@RequestMapping(value = "/list")
	public String showForm(ModelMap model) {
		return "page/sys/catalog/dictionary/list";
	}
	
	/**
	 * 分页返回用户列表
	 */
	@RequestMapping(value = "/listDictionary")
	public void listDictionary(HttpServletRequest request,HttpServletResponse response,@RequestParam(required = false, defaultValue = "1") Integer page,@RequestParam(required = false, defaultValue = "10") Integer rows,Dictionary dictionary){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	PrintWriter out = response.getWriter();//获取输出口
        	//JSONObject jsonObjectMap = new JSONObject();
        	//dictionary.setCatalog_id(dictionary.getCatalog_id().substring(0,dictionary.getCatalog_id().length()-1));
        	dictionary.setPageIndex((page-1)*rows);
        	dictionary.setPageSize(rows);
        	List<Dictionary> list = dictionaryService.getDictionaryList(dictionary);
        	int total = dictionaryService.dictionaryCount(dictionary);
        	dictionary.setTotal(total);
        	dictionary.setRows(list);
			//获取分页返回的数据,格式化数据并返回JSON
        	ObjectMapper mapper = new ObjectMapper();
        	out.write(mapper.writeValueAsString(dictionary));
    		out.flush();
    		out.close();
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	/**
	 * 新增
	 * @param request
	 * @param response
	 * @param dictionary
	 */
	@RequestMapping(value = "/insertDictionary")
	public void insertDictionary(HttpServletRequest request,HttpServletResponse response,Dictionary dictionary){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	SysUserVO user = (SysUserVO)request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);//将用户信息放入session
        	dictionary.setPkid(UUID.randomUUID().toString().replace("-", ""));//字典编号
        	dictionary.setCreate_user(user.getUserCode());
        	dictionary.setState("0");
        	dictionaryService.insertDictionary(dictionary);
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	/**
	 * 修改
	 * @param request
	 * @param response
	 * @param dictionary
	 */
	@RequestMapping(value = "/updateDictionary")
	public void updateDictionary(HttpServletRequest request,HttpServletResponse response,Dictionary dictionary){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	dictionary.setPkid(request.getParameter("id"));
        	dictionary.setCatalog_id(request.getParameter("catalogId"));
        	SysUserVO user = (SysUserVO)request.getSession().getAttribute(Constants.SESSION_LOGIN_USER);//将用户信息放入session
        	dictionary.setUpdate_user(user.getUserCode());
        	dictionaryService.updateDictionary(dictionary);
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
	
	/**
	 * 删除
	 * @param request
	 * @param response
	 * @param dictionary
	 */
	@RequestMapping(value = "/deleteDictionary")
	public void deleteDictionary(HttpServletRequest request,HttpServletResponse response,Dictionary dictionary){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
        	dictionaryService.deleteDictionary(dictionary.getPkid());
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception ex){
            ex.printStackTrace();
        }
	}
}
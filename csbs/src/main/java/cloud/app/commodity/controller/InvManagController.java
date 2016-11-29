package cloud.app.commodity.controller;


import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;




import cloud.app.commodity.model.InvManag;
import cloud.app.commodity.model.InvManagVO;
import cloud.app.commodity.model.Product;
import cloud.app.commodity.service.InvManagService;
import cloud.app.commodity.service.ProductService;
import cloud.app.commodity.service.StockInvService;
import cloud.app.common.StringUtil;



@Controller
@RequestMapping("/admin/invManag")
public class InvManagController {
	Logger log = Logger.getLogger(this.getClass());
	@Autowired
	private InvManagService invManagService;
	@Autowired
	private ProductService productService; 
	@Autowired
	private StockInvService stockInvService;
	
	@RequestMapping(value = "/toList")
	public String toList(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		InvManag invManag=new InvManag();
		invManag.setPageIndex(0);
		invManag.setPageSize(20);
		List<InvManag> list=invManagService.getList(invManag);
		Integer total=invManagService.count(invManag);
		Integer count=((total%invManag.getPageSize())==0)?total/invManag.getPageSize():(total/invManag.getPageSize()+1);//最大页数
		Integer p_begin=0;
		if(invManag.getPageIndex()>1){
			p_begin=invManag.getPageIndex()+1-2;
		}else{
			p_begin=1;
		}
		Integer p_end=0;
		if(count<5){
			p_end=5;
		}else{
			p_end=p_begin+4;
		}
		invManag.setTotal(total);
		invManag.setRows(list);
		invManag.setPageMax(count);
		model.addAttribute("invManag", invManag);
		model.addAttribute("total", total);
		model.addAttribute("p_begin", p_begin);
		model.addAttribute("p_end", p_end);
		return "page/commodity/stock/list";
	}
	@RequestMapping(value = "/toSearch")
	public String toSearch(ModelMap model,HttpServletRequest request,HttpServletResponse response,InvManag invManag) throws Exception
	{
		invManag.setPageIndex((Integer.parseInt(request.getParameter("pageNumber"))-1));
		invManag.setPageSize(Integer.parseInt(request.getParameter("pageSize")));
		InvManag pt=new InvManag();
		String searchProperty=request.getParameter("searchProperty");
		if(!searchProperty.isEmpty()&&!"".equals(searchProperty)){
			String searchValue=request.getParameter("searchValue");
			if("product_no".equals(searchProperty)){
				pt.setProduct_no(searchValue);
			}else if("update_user".equals(searchProperty)){
				pt.setUpdate_user(searchValue);
			}
		}
		//asc desc
		String orderProperty=request.getParameter("orderProperty");
		if(!orderProperty.isEmpty()&&!"".equals(orderProperty)){
			String orderDirection=request.getParameter("orderDirection");
			pt.setStringAsc(orderProperty+" "+orderDirection);
		}
		pt.setPageIndex(invManag.getPageIndex()*invManag.getPageSize());
		pt.setPageSize(invManag.getPageSize());
		List<InvManag> list=invManagService.getList(pt);
		Integer total=invManagService.count(pt);
		Integer count=((total%invManag.getPageSize())==0)?total/invManag.getPageSize():(total/invManag.getPageSize()+1);//最大页数
		Integer p_begin=0;
		if(invManag.getPageIndex()+1>2){
			p_begin=invManag.getPageIndex()+1-2;
		}else{
			p_begin=1;
		}
		Integer p_end=0;
		if(count<5){
			p_end=5;
		}else{
			p_end=p_begin+4;
		}
		invManag.setTotal(total);
		invManag.setRows(list);
		invManag.setPageMax(count);
		model.addAttribute("invManag", invManag);
		model.addAttribute("total", total);
		model.addAttribute("p_begin", p_begin);
		model.addAttribute("p_end", p_end);
		return "page/commodity/stock/list";
	}
	
	/**
	 * 入库
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/toInQuany")
	public String toInQuany(HttpServletRequest request,HttpServletResponse response){
		return "page/commodity/stock/warehousing";
	}
	
	/**
	 * 入库
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/save_in")
	public String save_in(HttpServletRequest request,HttpServletResponse response,InvManag invManag,ModelMap model) throws Exception{
		String productId=request.getParameter("productId");		
		InvManag inv=invManagService.getProductById(productId);
		invManag.setId(UUID.randomUUID().toString().replace("-", ""));
		invManag.setCreate_time(new Date());
		invManag.setCreate_user(request.getSession().getAttribute("username").toString());
		invManag.setUpdate_time(new Date());
		invManag.setUpdate_user(request.getSession().getAttribute("username").toString());	
		invManag.setType("1");		
		  invManag.setOutQuantity(0);
		if(StringUtil.isNullOrEmpty(inv)){
			invManag.setStock(invManag.getInQuantity());
			stockInvService.save(invManag);
		}else{
			invManag.setStock(inv.getStock()+invManag.getInQuantity());
			stockInvService.update(invManag);
		}      
	
		return toList(model, request, response);
	}
	
	/**
	 * 出库
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/toOutQuany")
	public String toOutQuany(HttpServletRequest request,HttpServletResponse response){
		return "page/commodity/stock/library";
	}
	
	/**
	 * 出库
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/save_out")
	public String save_out(HttpServletRequest request,HttpServletResponse response,InvManag invManag,ModelMap model) throws Exception{
		String productId=request.getParameter("productId");
		InvManag inv=invManagService.getProductById(productId);
		inv.setId(UUID.randomUUID().toString().replace("-", ""));
		inv.setCreate_time(new Date());
		inv.setCreate_user(request.getSession().getAttribute("username").toString());
		inv.setUpdate_time(new Date());
		inv.setUpdate_user(request.getSession().getAttribute("username").toString());	
		inv.setOutQuantity(invManag.getOutQuantity());
		inv.setStock(inv.getStock()-invManag.getOutQuantity());
		inv.setInQuantity(0);
		inv.setType("0");
		stockInvService.update(inv);
		return toList(model, request, response);
	}
	/**
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	/**
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/search")
	public void search(HttpServletRequest request,HttpServletResponse response) throws Exception{
        response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码    
        try{  
        	PrintWriter out = response.getWriter();// 获取输出口
        	String name=request.getParameter("name");
        	String type=request.getParameter("type");
        	List<InvManagVO> item=new ArrayList<InvManagVO>();
        	if(null!=name && !name.isEmpty()){
        		List<Product> productList=productService.getObjByName(name);
        		if(!StringUtil.isNullOrEmpty(productList)){
        			for(Product product:productList){
        				InvManag invManag=invManagService.getProductById(product.getId());
        				InvManagVO invManag1=new InvManagVO();
        				if("1".equals(type)){
        					if(StringUtil.isNullOrEmpty(invManag)){            				
                				invManag1.setProductId(product.getId());
                				invManag1.setProduct_no(product.getProduct_no());
                				invManag1.setProduct_name(product.getProduct_name());
                				invManag1.setLock_stock(0);
                				invManag1.setStock(0);
                				item.add(invManag1);
                			}else{
                				invManag1.setProductId(invManag.getProductId());
                				invManag1.setProduct_no(invManag.getProduct_no());
                				invManag1.setProduct_name(invManag.getProduct_name());
                				invManag1.setLock_stock(invManag.getLock_stock());
                				invManag1.setStock(invManag.getStock());                				
                				item.add(invManag1);
                			}
        				}
        				else{
        					if(!StringUtil.isNullOrEmpty(invManag)){  
        						invManag1.setProductId(invManag.getProductId());
                				invManag1.setProduct_no(invManag.getProduct_no());
                				invManag1.setProduct_name(invManag.getProduct_name());
                				invManag1.setLock_stock(invManag.getLock_stock());
                				invManag1.setStock(invManag.getStock());                				
                				item.add(invManag1);
        					}
        				}
        			}
        			
        		}
        	}
        	 JSONArray jsonTemp = net.sf.json.JSONArray.fromObject(item);           
			out.write(jsonTemp.toString());
			out.flush();
			out.close();
        }catch(Exception ex){
        	ex.printStackTrace();
            log.debug(ex);
        }
	}
	

}

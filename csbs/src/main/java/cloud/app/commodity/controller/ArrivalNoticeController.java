package cloud.app.commodity.controller;



import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import cloud.app.commodity.model.ArrivalNotice;
import cloud.app.commodity.service.ArrivalNoticeService;

@Controller
@RequestMapping("/admin/arrivalNotice")
public class ArrivalNoticeController {
	Logger log = Logger.getLogger(this.getClass());
	@Autowired
	private ArrivalNoticeService arrivalNoticeService;
	
	@RequestMapping(value = "/toList")
	public String toList(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		ArrivalNotice arrival=new ArrivalNotice();
		arrival.setPageIndex(0);
		arrival.setPageSize(20);
		List<ArrivalNotice> list=arrivalNoticeService.getList(arrival);
		for(ArrivalNotice notice:list){
			if("1".equals(notice.getIsMarketable())){
				notice.setIsMarketable("已上架");
			}else if("0".equals(notice.getIsMarketable())){
				notice.setIsMarketable("未上架");
			}
			if("1".equals(notice.getIsOutOfStock())){
				notice.setIsOutOfStock("有货");
			}else if("0".equals(notice.getIsOutOfStock())){
				notice.setIsOutOfStock("缺货");
			}
		}
		Integer total=arrivalNoticeService.count(arrival);
		Integer count=((total%arrival.getPageSize())==0)?total/arrival.getPageSize():(total/arrival.getPageSize()+1);//最大页数
		Integer p_begin=0;
		if(arrival.getPageIndex()>1){
			p_begin=arrival.getPageIndex()+1-2;
		}else{
			p_begin=1;
		}
		Integer p_end=0;
		if(count<5){
			p_end=5;
		}else{
			p_end=p_begin+4;
		}
		arrival.setTotal(total);
		arrival.setRows(list);
		arrival.setPageMax(count);
		model.addAttribute("arrival", arrival);
		model.addAttribute("total", total);
		model.addAttribute("p_begin", p_begin);
		model.addAttribute("p_end", p_end);
		
		return "page/commodity/arrival_notice/list";
	}
	
	@RequestMapping(value = "/toSearch")
	public String toSearch(ModelMap model,HttpServletRequest request,HttpServletResponse response,ArrivalNotice arrival) throws Exception
	{
		arrival.setPageIndex((Integer.parseInt(request.getParameter("pageNumber"))-1));
		arrival.setPageSize(Integer.parseInt(request.getParameter("pageSize")));
		ArrivalNotice pt=new ArrivalNotice();
		String searchProperty=request.getParameter("searchProperty");
		if(!searchProperty.isEmpty()&&!"".equals(searchProperty)){
			String searchValue=request.getParameter("searchValue");
			if("email".equals(searchProperty)){
				pt.setEmail(searchValue);
			}
		}
		//asc desc
		String orderProperty=request.getParameter("orderProperty");
		if(!orderProperty.isEmpty()&&!"".equals(orderProperty)){
			String orderDirection=request.getParameter("orderDirection");
			pt.setStringAsc(orderProperty+" "+orderDirection);
		}
		pt.setPageIndex(arrival.getPageIndex()*arrival.getPageSize());
		pt.setPageSize(arrival.getPageSize());
		List<ArrivalNotice> list=arrivalNoticeService.getList(pt);
		for(ArrivalNotice notice:list){
			if("1".equals(notice.getIsMarketable())){
				notice.setIsMarketable("已上架");
			}else if("0".equals(notice.getIsMarketable())){
				notice.setIsMarketable("未上架");
			}
			if("1".equals(notice.getIsOutOfStock())){
				notice.setIsOutOfStock("有货");
			}else if("0".equals(notice.getIsOutOfStock())){
				notice.setIsOutOfStock("缺货");
			}
		}
		Integer total=arrivalNoticeService.count(pt);
		Integer count=((total%arrival.getPageSize())==0)?total/arrival.getPageSize():(total/arrival.getPageSize()+1);//最大页数
		Integer p_begin=0;
		if(arrival.getPageIndex()+1>2){
			p_begin=arrival.getPageIndex()+1-2;
		}else{
			p_begin=1;
		}
		Integer p_end=0;
		if(count<5){
			p_end=5;
		}else{
			p_end=p_begin+4;
		}
		arrival.setTotal(total);
		arrival.setRows(list);
		arrival.setPageMax(count);
		model.addAttribute("arrival", arrival);
		model.addAttribute("total", total);
		model.addAttribute("p_begin", p_begin);
		model.addAttribute("p_end", p_end);
		
		return "page/commodity/arrival_notice/list";
	}
	
	
	
	/**
	 * 删除
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/deleteById")
	public void deleteById(HttpServletRequest request,HttpServletResponse response){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
             String[] ids=request.getParameterValues("ids"); 
             arrivalNoticeService.deleteByIdS(ids);
        	isValid = true;
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception e){
        	log.debug(e);
        }
	}
	
	/**
	 * 发送邮件
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/sendMail")
	public void sendMail(HttpServletRequest request,HttpServletResponse response){
		response.setContentType("text/html;charset=utf-8"); //指定输出内容类型和编码
        try{
        	boolean isValid = false;
             String[] ids=request.getParameterValues("ids"); 
             isValid=arrivalNoticeService.sendMailANdUpdate(ids);        	
        	response.getWriter().print(JSONArray.fromObject(isValid));
        }catch(Exception e){
        	log.debug(e);
        }
	}

}

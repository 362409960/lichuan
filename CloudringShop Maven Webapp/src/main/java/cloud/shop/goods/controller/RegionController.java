package cloud.shop.goods.controller;

import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import cloud.shop.goods.entity.Region;
import cloud.shop.goods.service.RegionService;



@Controller
@RequestMapping("/region")
public class RegionController {
	
	@Autowired
	private RegionService regionService;
	
	
	@RequestMapping(value = "/getAreaData")
	public void getAreaData(HttpServletRequest request,HttpServletResponse response,Region region) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			PrintWriter out = response.getWriter();// 获取输出口		  
		    List<Region> reList=regionService.getRegionList(region);
			String json = JSONArray.fromObject(reList).toString();//转化为JSON		
			out.write(json);
			out.flush();
			out.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	

	@RequestMapping(value = "/getAreaClidrenData")
	public void getAreaClidrenData(HttpServletRequest request,HttpServletResponse response,Region region) {
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		try {
			PrintWriter out = response.getWriter();// 获取输出口
		    String parentId=request.getParameter("parentId");
		    List<Region> reList=new LinkedList<Region>();;
			if(null !=parentId &&!"".equals(parentId))
			{ 
			   reList=regionService.getRegionIdList(parentId);
			}
			else
			{
				Region r=new Region();
				r.setName("请选择");
				reList.add(r);
			}
			String json = JSONArray.fromObject(reList).toString();//转化为JSON		
			out.write(json);
			out.flush();
			out.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

}

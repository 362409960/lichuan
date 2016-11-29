package cloud.shop.goods.controller;


import java.util.LinkedHashMap;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import cloud.shop.common.ObjectIsNull;
import cloud.shop.goods.entity.Commercial;
import cloud.shop.goods.service.CommercialService;
import cloud.shop.merchandise.entity.MerchandiseCategories;
import cloud.shop.merchandise.entity.MerchandiseProduct;
import cloud.shop.merchandise.service.MerchandiseCategoriesService;
import cloud.shop.merchandise.service.MerchandiseProductService;


@Controller
@RequestMapping("/home")
public class ShowHomeController {
	
	@Autowired
	private MerchandiseProductService merchandiseProductService;
	@Autowired
	private MerchandiseCategoriesService merchandiseCategoriesService;
	@Autowired
	private CommercialService commercialService;

	/**
	 * 首页
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/showShopIndex")
	public String showShopIndex(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		//广告1
		List<Commercial> comList  =commercialService.geteCommercialList();	
		//顶级产品分类
		List<MerchandiseCategories> categoriesList=merchandiseCategoriesService.getCategorieConditionList();
		
		Map<String,String> menu=new LinkedHashMap<String,String>();
		Map<Map, Object> topMap=new LinkedHashMap<Map, Object>();	
		if(null != categoriesList && !categoriesList.isEmpty())
		{
			for(MerchandiseCategories mc:categoriesList)
			{
				Map<String, Object> threeMap=new LinkedHashMap<String, Object>();
				Map<Object, Object> listMap=new LinkedHashMap<Object, Object>();
				//求产品分类第二级的前三列的数据。【根据新的需求，把所有的都显示】
				List<MerchandiseCategories> mcThreeList=merchandiseCategoriesService.selectThreePId(mc.getId());
				String mcategName="";
				if(null != mcThreeList && ! mcThreeList.isEmpty())
				{
					for(MerchandiseCategories mec:mcThreeList)
					{
						//threeMap.put(mec.getId(), mec.getName());
						mcategName=mcategName+mec.getName()+" ";
					}
				}
				threeMap.put(mc.getId(), mcategName);
				//求商品
				String ids=getProductLowList(mc.getId());
				String[]str=ids.split(",");
				//根据IDS【所有二级ID和其下级的所有ID】
				List<MerchandiseProduct> mpList=merchandiseProductService.getProductConditionFiveList(str);
				listMap.put(mc.getId(), mpList);
				topMap.put(threeMap, listMap);
				menu.put(mc.getId(), mc.getName());
			}
		}
		//产品品牌[目前没有做]
		//明星产品
		List<MerchandiseProduct> stratList=merchandiseProductService.getStartProdouctList();
		//硬件
		List<MerchandiseProduct> hardList=merchandiseProductService.getHardwareProdouctList();
		//推荐
		List<MerchandiseProduct> reList=merchandiseProductService.getRecommendProdouctList();
		
		
		model.addAttribute("comList", comList);	
		model.addAttribute("menu", menu);
		model.addAttribute("topMap", topMap);
		
		model.addAttribute("stratList", stratList);
		model.addAttribute("hardList", hardList);
		model.addAttribute("reList", reList);
		model.addAttribute("isAll", "true");
		return "page/shop/home/index";
	}
	//循环求出产品分类下级的ID。
	public String getProductLowList(String id) throws Exception
	{
		String ids=id;
		List<MerchandiseCategories> melist=merchandiseCategoriesService.selectPId(id);
		if(null != melist && !melist.isEmpty())
		{
			for(MerchandiseCategories me :melist)
			{	
				List<MerchandiseCategories> list=merchandiseCategoriesService.selectPId(me.getId());
				if(null !=list && !list.isEmpty())
				{
					ids=ids+","+me.getId()+","+getProductLowList(me.getId());
				}
				else
				{
					ids=ids+","+me.getId();		
				}
				
			}
			
		}
		return ids;
	}
	
	//循环求出产品分类上级的ID。
		public String getProducToptList(String id) throws Exception
		{
			String ids=id;
			MerchandiseCategories melist=merchandiseCategoriesService.selectCheckId(id);
			if(!ObjectIsNull.isNullOrEmpty(melist))
			{	
				MerchandiseCategories list=merchandiseCategoriesService.selectCheckId(melist.getPid());
				if(!ObjectIsNull.isNullOrEmpty(list))
				{
					ids=ids+","+melist.getPid()+","+getProducToptList(melist.getPid());
				}
				else
				{
					ids=ids+","+melist.getPid();		
				}
					
				
				
			}
			return ids;
		}
	
	/**
	 * 所有商品分类
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/showShopProductcategory")
	public String showShopProductcategory(ModelMap model) throws Exception
	{

		List<MerchandiseCategories> categoriesList=merchandiseCategoriesService.getCategorieConditionList();
		//顶级map设计
		Map<Map, Object> topMap=new LinkedHashMap<Map, Object>();	
		Map<String,String> menu=new LinkedHashMap<String,String>();
		if(null != categoriesList && !categoriesList.isEmpty())
		{
			for(MerchandiseCategories mc:categoriesList)
			{
				menu.put(mc.getId(), mc.getName());
				Map<String,String> top=new LinkedHashMap<String,String>();
				top.put(mc.getId(), mc.getName());
				List<MerchandiseCategories> mcList=merchandiseCategoriesService.selectPId(mc.getId());
				topMap.put(top, mcList);
				
			}
		}
		model.addAttribute("menu", menu);
		model.addAttribute("topMap", topMap);
		return "page/shop/home/list/product_category";
	}
	
	/**
	 * 跳转
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/showShopHomeSecurity")
	public String showShopHomeSecurity(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		List<MerchandiseCategories> categoriesList=merchandiseCategoriesService.getCategorieConditionList();
		
		Map<String,String> menu=new LinkedHashMap<String,String>();
		Map<Map, Object> topMap=new LinkedHashMap<Map, Object>();	
		if(null != categoriesList && !categoriesList.isEmpty())
		{
			for(MerchandiseCategories mc:categoriesList)
			{
				Map<String, Object> threeMap=new LinkedHashMap<String, Object>();
				Map<Object, Object> listMap=new LinkedHashMap<Object, Object>();
				//求产品分类第二级的前三列的数据。【根据新的需求，把所有的都显示】
				List<MerchandiseCategories> mcThreeList=merchandiseCategoriesService.selectThreePId(mc.getId());
				String mcategName="";
				if(null != mcThreeList && ! mcThreeList.isEmpty())
				{
					for(MerchandiseCategories mec:mcThreeList)
					{
						//threeMap.put(mec.getId(), mec.getName());
						mcategName=mcategName+mec.getName()+" ";
					}
				}
				threeMap.put(mc.getId(), mcategName);
				//求商品
				String ids=getProductLowList(mc.getId());
				String[]str=ids.split(",");
				//根据IDS【所有二级ID和其下级的所有ID】
				List<MerchandiseProduct> mpList=merchandiseProductService.getProductConditionFiveList(str);
				listMap.put(mc.getId(), mpList);
				topMap.put(threeMap, listMap);
				menu.put(mc.getId(), mc.getName());
			}
		}
		
		//跳转后得到跳转类型和跳转名【ID】,跳转类型分为1=分类，2=产品，3=品牌,跳转名为分类id，产品ID，品牌ID
		//根据分类名得到他本级和下级的商品，和上级分类名
		String skipName=request.getParameter("skipName");	
		Map<String,Object> mapSort1=new LinkedHashMap<String,Object>();
		Map<String,Object> mapSort2=new LinkedHashMap<String,Object>();		
		if(null != skipName && !"".equals(skipName))
		{
			String ids=getProducToptList(skipName);
			String[]strIds=ids.split(",");
			List<MerchandiseCategories> mer=merchandiseCategoriesService.getSelectIdForIN(strIds);
			mapSort1.put("ids", mer);
			List<MerchandiseCategories> sortList=merchandiseCategoriesService.selectPId(skipName);
			mapSort2.put("sort", sortList);
		}
		
		//产品展示分页数据
		String ids=getProductLowList(skipName);
		String[]str=ids.split(",");
		MerchandiseProduct mep=new MerchandiseProduct();
		String pageNumber=request.getParameter("pageNumber");
		String pageSize=request.getParameter("pageSize");
		Map<String,Object> params=new LinkedHashMap<String,Object>();
		if( null != pageNumber && !"".equals(pageNumber)  )
		{
			mep.setPageIndex(Integer.parseInt(pageNumber)-1);
		}
		else
		{
			mep.setPageIndex(0);
		}
		if(null !=pageSize && !"".equals(pageSize) )
		{
			mep.setPageSize(Integer.parseInt(pageSize));
		}
		else
		{
			mep.setPageSize(20);
		}
		params.put("arr", str);	
		params.put("pageIndex", mep.getPageIndex()*mep.getPageSize());
		params.put("pageSize", mep.getPageSize());
		List<MerchandiseProduct> mepList=merchandiseProductService.getPageGoodsList(params);
		int total=merchandiseProductService.getPageGoodsCount(str);
		mep.setTotal(total);//总数
		mep.setRows(mepList);
		mep.setMaxPage(total%mep.getPageSize()==0?total/mep.getPageSize():(total/mep.getPageSize()+1));//最大页数
		model.addAttribute("menu", menu);
		model.addAttribute("topMap", topMap);
		model.addAttribute("mapSort1", mapSort1);
		model.addAttribute("mapSort2", mapSort2);
		model.addAttribute("skipName", skipName);
		//产品数据
		model.addAttribute("mep", mep);
		model.put("tal", total);
	
		return "page/shop/home/list/all_list";
	}
	
	/**
	 * 条件查询
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/showShopInquiry")
	public String showShopInquiry(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		response.setContentType("text/html;charset=utf-8"); // 指定输出内容类型和编码
		List<MerchandiseCategories> categoriesList=merchandiseCategoriesService.getCategorieConditionList();
		
		Map<String,String> menu=new LinkedHashMap<String,String>();
		Map<Map, Object> topMap=new LinkedHashMap<Map, Object>();	
		if(null != categoriesList && !categoriesList.isEmpty())
		{
			for(MerchandiseCategories mc:categoriesList)
			{
				Map<String, Object> threeMap=new LinkedHashMap<String, Object>();
				Map<Object, Object> listMap=new LinkedHashMap<Object, Object>();
				//求产品分类第二级的前三列的数据。【根据新的需求，把所有的都显示】
				List<MerchandiseCategories> mcThreeList=merchandiseCategoriesService.selectThreePId(mc.getId());
				String mcategName="";
				if(null != mcThreeList && ! mcThreeList.isEmpty())
				{
					for(MerchandiseCategories mec:mcThreeList)
					{
						mcategName=mcategName+mec.getName()+" ";
					}
				}
				threeMap.put(mc.getId(), mcategName);
				//求商品
				String ids=getProductLowList(mc.getId());
				String[]str=ids.split(",");
				//根据IDS【所有二级ID和其下级的所有ID】
				List<MerchandiseProduct> mpList=merchandiseProductService.getProductConditionFiveList(str);
				listMap.put(mc.getId(), mpList);
				topMap.put(threeMap, listMap);
				menu.put(mc.getId(), mc.getName());
			}
		}
	
		////keyword
		MerchandiseProduct mep=new MerchandiseProduct();
		String pageNumber=request.getParameter("pageNumber");
		String pageSize=request.getParameter("pageSize");
		String keyword=request.getParameter("keyword") != null?new String(request.getParameter("keyword").getBytes("ISO-8859-1"),"utf-8"):null;
		
		if( null != pageNumber && !"".equals(pageNumber)  )
		{
			mep.setPageIndex(Integer.parseInt(pageNumber)-1);
		}
		else
		{
			mep.setPageIndex(0);
		}
		if(null !=pageSize && !"".equals(pageSize) )
		{
			mep.setPageSize(Integer.parseInt(pageSize));
		}
		else
		{
			mep.setPageSize(20);
		}
		MerchandiseProduct mp =new MerchandiseProduct();
		mp.setName(keyword);
		mp.setPageIndex(mep.getPageIndex()*mep.getPageSize());
		mp.setPageSize( mep.getPageSize());
		List<MerchandiseProduct> mepList=merchandiseProductService.getPageGoodNamesList(mp);
		model.addAttribute("keyword", keyword);
		model.addAttribute("menu", menu);
		model.addAttribute("topMap", topMap);
		if(mepList.isEmpty())
		{
			List<MerchandiseProduct> reList=merchandiseProductService.getRecommendProdouctList();
			model.addAttribute("reList", reList);
			return "page/shop/home/list/search_no";
		}
		else
		{
			int total=merchandiseProductService.getPageGoodsNameCount(keyword);
			mep.setTotal(total);//总数
			mep.setRows(mepList);
			mep.setMaxPage(total%mep.getPageSize()==0?total/mep.getPageSize():(total/mep.getPageSize()+1));//最大页数
			List<MerchandiseProduct> listM=merchandiseProductService.getCategoryIds(keyword);
			String ids="";
			for(MerchandiseProduct m:listM)
			{
				ids=ids+","+m.getProductcategory_id();
			}
			String[]str=ids.split(",");
			List<MerchandiseCategories> listCa=merchandiseCategoriesService.getGoodsIdFindCAIN(str);
			model.addAttribute("listCa", listCa);
			model.addAttribute("mep", mep);
			model.put("tal", total);
			return "page/shop/home/list/search_list";
		}
		
	}
	
	/**
	 * 产品详细介绍
	 * @param model
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value="/showShopProductDetails")
	public String showShopProductDetails(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
        List<MerchandiseCategories> categoriesList=merchandiseCategoriesService.getCategorieConditionList();
		
		Map<String,String> menu=new LinkedHashMap<String,String>();
		Map<Map, Object> topMap=new LinkedHashMap<Map, Object>();	
		if(null != categoriesList && !categoriesList.isEmpty())
		{
			for(MerchandiseCategories mc:categoriesList)
			{
				Map<String, Object> threeMap=new LinkedHashMap<String, Object>();
				Map<Object, Object> listMap=new LinkedHashMap<Object, Object>();
				//求产品分类第二级的前三列的数据。【根据新的需求，把所有的都显示】
				List<MerchandiseCategories> mcThreeList=merchandiseCategoriesService.selectThreePId(mc.getId());
				String mcategName="";
				if(null != mcThreeList && ! mcThreeList.isEmpty())
				{
					for(MerchandiseCategories mec:mcThreeList)
					{
						//threeMap.put(mec.getId(), mec.getName());
						mcategName=mcategName+mec.getName()+" ";
					}
				}
				threeMap.put(mc.getId(), mcategName);
				//求商品
				String ids=getProductLowList(mc.getId());
				String[]str=ids.split(",");
				//根据IDS【所有二级ID和其下级的所有ID】
				List<MerchandiseProduct> mpList=merchandiseProductService.getProductConditionFiveList(str);
				listMap.put(mc.getId(), mpList);
				topMap.put(threeMap, listMap);
				menu.put(mc.getId(), mc.getName());
			}
		}
		String skipName=request.getParameter("skipName");
		MerchandiseProduct goodsP=merchandiseProductService.selectCheckId(skipName);
		//
		String str=getProducToptList(goodsP.getProductcategory_id());
		String [] ids=str.split(",");
		List<MerchandiseCategories> listMer=merchandiseCategoriesService.getSelectIdForIN(ids);
		
		model.addAttribute("menu", menu);
		model.addAttribute("topMap", topMap);
		model.addAttribute("goodsP", goodsP);
		model.addAttribute("listMer", listMer);
		return "page/shop/home/list/product_show";
	}
	
	/**
	 * 转向登录界面
	 * @param model
	 * @return
	 */

	@RequestMapping(value="/tologin")
	public String tologin(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception
	{
		List<MerchandiseCategories> categoriesList=merchandiseCategoriesService.getCategorieConditionList();
		Map<String,String> menu=new LinkedHashMap<String,String>();
		if(null != categoriesList && !categoriesList.isEmpty())
		{
			for(MerchandiseCategories mc:categoriesList)
			{
				menu.put(mc.getId(), mc.getName());
				
			}
		}
	
		model.addAttribute("menu", menu);
		
		return "page/shop/home/reception_login";
	}
}

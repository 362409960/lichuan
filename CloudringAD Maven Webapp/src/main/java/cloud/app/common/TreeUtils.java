package cloud.app.common;

import java.util.List;

import org.apache.log4j.Logger;

import cloud.app.system.vo.TreeVO;

public class TreeUtils {
	static Logger logger = Logger.getLogger(TreeUtils.class);
	

	@SuppressWarnings("rawtypes")
	public static String createJson4PacketTree(List<TreeVO> list) {
		StringBuffer sb = new StringBuffer();
		 sb.append("[");
		 
		 sb.append("{ id:'0', pId:'', name:\"所有分组\", open:true,nocheck:true},");
		for(int i=0; i<list.size(); i++){
			TreeVO vo = list.get(i);
			sb.append("{").append("id:").append("\""+vo.getId()+"\"").append(",").append("pId:").append("\""+vo.getPid()+"\"").append(",").append("name:").append("\""+vo.getName()+"\"");
			if("0".equals(vo.getPid())){
				sb.append(",open:true");
			}
			sb.append("}");
			if(list.size()-1 != i){
				sb.append(",");
			}
		}
		sb.append("]");
		
		return sb.toString();
	}
	
	
	@SuppressWarnings("rawtypes")
	public static String createJson4SurveillanceTree(List<TreeVO> list) {
		StringBuffer sb = new StringBuffer();
		 sb.append("[");
		 
		 sb.append("{ id:'A', pId:'', name:\"A\", open:true,nocheck:true},{ id:'B', pId:'', name:\"B\", open:true,nocheck:true}," +
		 		"{ id:'C', pId:'', name:\"C\", open:true,nocheck:true},{ id:'D', pId:'', name:\"D\", open:true,nocheck:true}," +
		 		"{ id:'E', pId:'', name:\"E\", open:true,nocheck:true},");
		for(int i=0; i<list.size(); i++){
			TreeVO vo = list.get(i);
			sb.append("{").append("id:").append("\""+vo.getId()+"\"").append(",").append("pId:").append("\""+vo.getPid()+"\"").append(",").append("name:").append("\""+vo.getName()+"\"");
			if("0".equals(vo.getPid())){
				sb.append(",open:true");
			}
			sb.append("}");
			if(list.size()-1 != i){
				sb.append(",");
			}
		}
		sb.append("]");
		
		return sb.toString();
	}
	
	
	@SuppressWarnings("rawtypes")
	public static String createJson4Tree1(List<TreeVO> list) {
		StringBuffer sb = new StringBuffer();
		 sb.append("[");
		 
		
		for(int i=0; i<list.size(); i++){
			TreeVO vo = list.get(i);
			
			//第一级节点
			if("0".equals(vo.getPid())){
				//{ id:1, pId:0, name:"父节点 1", open:true},
				sb.append("{").append("id:").append("\""+vo.getId()+"\"").append("pId:").append("\""+vo.getPid()+"\"").append("name:").append("\""+vo.getName()+"\"").append("open:").append("true").append(",");
				childTree(vo.getId(), list, sb);
			}
		}
		if(",".equals(sb.toString().indexOf(sb.toString().length()))){
			sb.replace(sb.toString().length()-1, sb.toString().length(), "");
		}
		sb.append("]");
		
		return sb.toString();
	}
	
	public static void childTree(String pid, List<TreeVO> list, StringBuffer sb){
		for(int i=0; i<list.size(); i++){
			TreeVO vo = list.get(i);
			if(pid.equals(vo.getPid())){
				sb.append("{").append("id:").append("\""+vo.getId()+"\"").append("pId:").append("\""+vo.getPid()+"\"").append("name:").append("\""+vo.getName()+"\"").append("open:").append("true").append(",");
			
				childTree(vo.getId(), list, sb);
			}
		}
	}
}

package cloud.shop.common;


import java.util.HashSet;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;



@SuppressWarnings("rawtypes")
public class TreeUtil {
 
public static String createSonJson4Tree(List<Map> list, String treeName, String pkid, String status_pkid)
  {
    StringBuffer sb = new StringBuffer();
    String tree_name = null;
    String tree_id = null;
    String tree_parent_id = null;
    Integer has_child = null;

    if ((list == null) || (list.size() == 0))
    {
      return "[{}]";
    }

    for (int i = 0; i < list.size(); i++)
    {
      Map map = (Map)list.get(i);
      tree_name = (String)map.get("tree_name");
      tree_id = (String)map.get("tree_id");
      tree_parent_id = (String)map.get("tree_parent_id");
      if (map.get("has_child") != null) {
        has_child = Integer.valueOf(Integer.parseInt(map.get("has_child").toString()));
      }

      if (i == 0)
      {
        sb.append("[");
      }

      sb.append("{");
      sb.append("  data : ");

      if (has_child.intValue() >= 1)
      {
        sb.append(" {title:\"" + tree_name + "\",attributes:{rel:\"folder\",onclick:\"nodeClick('" + tree_id + "','" + tree_parent_id + "','" + tree_name + "')\",href:\"#\"}}, ");
        sb.append(" attributes : {id: \"" + tree_id + "\"},");
        sb.append(" children:[],");
        sb.append(" state:\"closed\"");
      }
      else
      {
        sb.append(" {title:\"" + tree_name + "\",attributes:{rel:\"file\",onclick:\"nodeClick('" + tree_id + "','" + tree_parent_id + "','" + tree_name + "')\",href:\"#\"}}, ");
        sb.append(" attributes : {id: \"" + tree_id + "\"}");
      }

      sb.append("}");
      if (i != list.size() - 1)
      {
        sb.append(",");
      }

      if (i != list.size() - 1)
        continue;
      sb.append("]");
    }

    return sb.toString();
  }

  public static String getAllChild(List<Map> list, String parentId, String node_click_event)
  {
    String res = "";
    boolean find = false;

    for (int i = 0; i < list.size(); i++)
    {
      Map map = (Map)list.get(i);

      String tree_id = (String)map.get("tree_id");

      String tree_parent_id = "";
      if (map.get("tree_parent_id") != null) {
        tree_parent_id = map.get("tree_parent_id").toString();
      }

      String tree_name = (String)map.get("tree_name");
      System.out.println("tree_name: " + tree_name);

      int has_child = 0;
      if (map.get("has_child") != null) {
        has_child = Integer.parseInt(map.get("has_child").toString());
      }

      if (tree_parent_id.equals(parentId)) {
        if (find) {
          res = res + ",";
        }
        find = true;
        res = res + "{";
        res = res + "   data : {title:\"" + tree_name + "\",attributes:{onclick:\"" + node_click_event + "('" + tree_id + "','" + tree_parent_id + "','" + tree_name + "')\",href:\"#\"}}";
        res = res + "  ,attributes : { \"id\" : \"" + tree_id + "\" }";
        if (has_child > 0) {
          res = res + ",children:[";
          res = res + getAllChild(list, tree_id, node_click_event);
          res = res + "]";

          res = res + ",state:\"open\"";
        }
        res = res + "}";
      }

    }

    return res;
  }

  public static String createSonJson4Child(List<Map> list, String parentId, String node_click_event, String status_pkid)
  {
    String res = "";
    if ((node_click_event == null) || (node_click_event.equals(""))) {
      node_click_event = "nodeClick";
    }
    boolean find = false;
    for (int count = 0; count < list.size(); count++) {
      Map map = (Map)list.get(count);

      String tree_id = (String)map.get("tree_id");

      String tree_parent_id = "";
      if (map.get("tree_parent_id") != null) {
        tree_parent_id = map.get("tree_parent_id").toString();
      }

      String tree_name = (String)map.get("tree_name");
      System.out.println("tree_name: " + tree_name);

      int has_child = 0;
      if (map.get("has_child") != null) {
        has_child = Integer.parseInt(map.get("has_child").toString());
      }

      if (tree_parent_id.equals(parentId)) {
        if (find) {
          res = res + ",";
        }
        find = true;
        res = res + "{";
        res = res + "   data : {title:\"" + tree_name + "\",attributes:{onclick:\"" + node_click_event + "('" + tree_id + "','" + tree_parent_id + "','" + tree_name + "')\",href:\"#\"}}";
        res = res + "  ,attributes : { \"id\" : \"" + tree_id + "\" }";
        if (has_child > 0) {
          res = res + ",children:[";
          res = res + getAllChild(list, tree_id, node_click_event);
          res = res + "]";

          if ((!status_pkid.equals(tree_id)) && ("0".equals(tree_parent_id)))
          {
            res = res + ",state:\"closed\"";
          }
          else {
            res = res + ",state:\"open\"";
          }
        }

        res = res + "}";
      }
    }

    return res;
  }

  public static String createJson4Tree(List<Map> list, String treeName)
  {
    StringBuffer res = new StringBuffer();
    res.append("[");
    res.append("  {");
    res.append("     data :\"" + treeName + "\",");
    res.append("     attributes : { \"id\" : \"0\" },");
    res.append("       children:[");
    res.append(createJson4Child(list, "0", "nodeClick"));
    res.append("       ]");
    res.append(",state:\"open\"");
    res.append("  }");
    res.append("]");

    Log logger = LogFactory.getLog(TreeUtil.class);
    logger.info(res.toString());
    return res.toString().replace("\n", "");
  }

  public static String createJson4Tree(List<Map> list, String treeName, String parent_id, String node_click_event)
  {
    StringBuffer res = new StringBuffer();
    res.append("[");
    res.append("  {");
    res.append("     data :\"" + treeName + "\",");
    res.append("     attributes : { \"id\" : \"" + parent_id + "\" },");
    res.append("       children:[");
    res.append(createJson4Child(list, parent_id, node_click_event));
    res.append("       ]");
    res.append(",state:\"open\"");
    res.append("  }");
    res.append("]");

    Log logger = LogFactory.getLog(TreeUtil.class);
    logger.info(res.toString());

    return res.toString();
  }

  public static String createJson4Tree(List<Map> list)
  {
    StringBuffer res = new StringBuffer();
    String node_click_event = "nodeClick";
    String curId = "-1";
    res.append("[");
    HashSet childs = new HashSet();
    for (int i = 0; i < list.size(); i++) {
      Map map = (Map)list.get(i);

      String tree_id = (String)map.get("tree_id");
      if (childs.contains(tree_id))
      {
        continue;
      }
      String parent_id = (String)map.get("tree_parent_id");
      if (!curId.equals(parent_id)) {
        curId = tree_id;

        if (i != 0) {
          res.append(",");
        }
        String tree_name = (String)map.get("tree_name");
        res.append("  {");
        res.append("     data :{title:\"").append(map.get("tree_name")).append("\",");
        res.append("     attributes : {  onclick:\"nodeClick('")
          .append(tree_id).append("','").append(tree_name).append("','").append(parent_id).append("')\"")
          .append(",href:\"#\"}}");
        res.append("     ,attributes:{\"id\" : \"").append(tree_id).append("\"}");

        int has_child = 0;
        if (map.get("has_child") != null) {
          has_child = Integer.parseInt(map.get("has_child").toString());
        }
        if (has_child > 0) {
          res.append("       ,children:[");
          res.append(createJson4Child(list, tree_id, node_click_event, childs));
          res.append("       ]");
          res.append(",state:\"closed\"");
        }
        res.append("  }");
      }
    }

    res.append("]");

    return res.toString();
  }

  public static String createJson4Child(List<Map> list, String parent_id, String node_click_event)
  {
    String res = "";
    if ((node_click_event == null) || (node_click_event.equals(""))) {
      node_click_event = "nodeClick";
    }
    boolean find = false;
    for (int i = 0; i < list.size(); i++) {
      Map map = (Map)list.get(i);

      String tree_id = (String)map.get("tree_id".toUpperCase());

      String tree_parent_id = "";
      if (map.get("tree_parent_id".toUpperCase()) != null) {
        tree_parent_id = map.get("tree_parent_id".toUpperCase()).toString();
      }

      String tree_name = (String)map.get("tree_name".toUpperCase());

      int has_child = 0;
      if (map.get("has_child".toUpperCase()) != null) {
        has_child = Integer.parseInt(map.get("has_child".toUpperCase()).toString());
      }

      if (tree_parent_id.equals(parent_id)) {
        if (find) {
          res = res + ",";
        }
        find = true;
        res = res + "{";
        res = res + "   data : {title:\"" + tree_name + "\",attributes:{onclick:\"" + node_click_event + "('" + tree_id + "','" + tree_parent_id + "','" + tree_name + "')\",href:\"#\"}}";
        res = res + "  ,attributes : { \"id\" : \"" + tree_id + "\" }";
        if (has_child > 0) {
          res = res + ",children:[";
          res = res + createJson4Child(list, tree_id, node_click_event);
          res = res + "]";
          res = res + ",state:\"closed\"";
        }
        res = res + "}";
      }
    }

    return res;
  }

  @SuppressWarnings("unchecked")
public static String createJson4Child(List<Map> list, String parent_id, String node_click_event, HashSet childs)
  {
    String res = "";
    if ((node_click_event == null) || (node_click_event.equals(""))) {
      node_click_event = "nodeClick";
    }
    boolean find = false;
    for (int i = 0; i < list.size(); i++) {
      Map map = (Map)list.get(i);

      String tree_id = (String)map.get("tree_id");

      String tree_parent_id = "";
      if (map.get("tree_parent_id") != null) {
        tree_parent_id = map.get("tree_parent_id").toString();
      }

      String tree_name = (String)map.get("tree_name");

      int has_child = 0;
      if (map.get("has_child") != null) {
        has_child = Integer.parseInt(map.get("has_child").toString());
      }

      if (tree_parent_id.equals(parent_id)) {
        if (find) {
          res = res + ",";
        }
        find = true;
        res = res + "{";
        res = res + "   data : {title:\"" + tree_name + "\",attributes:{onclick:\"" + node_click_event + "('" + tree_id + "','" + tree_parent_id + "','" + tree_name + "')\",href:\"#\"}}";
        res = res + "  ,attributes : { \"id\" : \"" + tree_id + "\" }";
        if (has_child > 0) {
          res = res + ",children:[";
          res = res + createJson4Child(list, tree_id, node_click_event, childs);
          res = res + "]";
          res = res + ",state:\"closed\"";
        }
        res = res + "}";

        childs.add(tree_id);
      }
    }

    return res;
  }
}
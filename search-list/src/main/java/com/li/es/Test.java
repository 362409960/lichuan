package com.li.es;



import java.io.IOException;
import java.net.InetAddress;
import java.util.ArrayList;
import java.util.List;

import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.client.Client;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.InetSocketTransportAddress;
import org.elasticsearch.common.xcontent.XContentBuilder;
import org.elasticsearch.common.xcontent.XContentFactory;

public class Test {

    public static void main(String[] args) {

        //创建客户端
        try {
        	 Settings settings = Settings.settingsBuilder().put("cluster.name","elastictest").build();
 			Client client = TransportClient.builder().settings(settings).build()
 					.addTransportAddress(new InetSocketTransportAddress(InetAddress.getByName("192.168.1.125"), 9200));


            System.out.println("连接成功");
            
            List<String> list = getData();
            for(String str : list){
                IndexResponse response = client.prepareIndex("blog","article").setSource(str).get();
                if(response.isCreated()){
                    System.out.println("创建成功！");
                }
            }

            client.close();

        } catch (Exception e) {
            e.printStackTrace();
        }




    }


    public static List<String> getData(){
        List<String> list = new ArrayList<String>();

        String blog1 = model2Json(new Blog(1,"第1个title","2016-10-14 10:31","第1个content"));
        String blog2 = model2Json(new Blog(2,"第2个title","2016-10-14 10:32","第2一个content"));
        String blog3 = model2Json(new Blog(3,"第3个title","2016-10-14 10:33","第3个content"));
        String blog4 = model2Json(new Blog(4,"第4个title","2016-10-14 10:34","第4个content"));
        String blog5 = model2Json(new Blog(5,"第5个title","2016-10-14 10:35","第5个content"));
        String blog6 = model2Json(new Blog(6,"第6个title","2016-10-14 10:36","6个content"));
        String blog7 = model2Json(new Blog(7,"第7个title","2016-10-14 10:37","第7个content"));
        String blog8 = model2Json(new Blog(8,"第8个title","2016-10-14 10:36","8个content"));

        list.add(blog1);
        list.add(blog2);
        list.add(blog3);
        list.add(blog4);
        list.add(blog5);
        list.add(blog6);
        list.add(blog7);
        list.add(blog8);

        return list;
    }

     public static String model2Json(Blog blog) {
            String jsonData = null;
            try {
                XContentBuilder jsonBuild = XContentFactory.jsonBuilder();
                jsonBuild.startObject()
                            .field("id", blog.getId())
                            .field("title", blog.getTitle())
                            .field("date", blog.getDate())
                            .field("context",blog.getContext())
                        .endObject();

                jsonData = jsonBuild.string();
                System.out.println(jsonData);

            } catch (IOException e) {
                e.printStackTrace();
            }

            return jsonData;
        }
}
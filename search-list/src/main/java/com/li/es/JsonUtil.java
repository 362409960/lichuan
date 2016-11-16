package com.li.es;

import java.io.IOException;

import org.elasticsearch.common.xcontent.XContentBuilder;
import org.elasticsearch.common.xcontent.XContentFactory;

public class JsonUtil {
	
	public static String obj2JsonData(Medicine medicine){
        String jsonData = null;
        try {
            //使用XContentBuilder创建json数据
            XContentBuilder jsonBuild = XContentFactory.jsonBuilder();
            jsonBuild.startObject()
            .field("id",medicine.getId())
            .field("name", medicine.getUsername())
            .field("funciton",medicine.getFunction())
            .endObject();
            jsonData = jsonBuild.string();           
        } catch (IOException e) {
            e.printStackTrace();
        }
        return jsonData;
    }

}

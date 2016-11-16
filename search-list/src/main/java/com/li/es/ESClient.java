package com.li.es;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.Client;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.InetSocketTransportAddress;
import org.elasticsearch.common.xcontent.XContentBuilder;
import org.elasticsearch.common.xcontent.XContentFactory;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.index.query.QueryStringQueryBuilder;

import net.sf.json.util.JSONBuilder;

public class ESClient {

	public static void main(String[] args) throws UnknownHostException {

		try {
			/* 创建客户端 */
			// client startup
			
		     Settings settings = Settings.settingsBuilder().put("cluster.name","elastictest").put("client.transport.sniff", true).build();
			Client client = TransportClient.builder().settings(settings).build()
					.addTransportAddress(new InetSocketTransportAddress(InetAddress.getByName("192.168.1.125"), 9200));

			XContentBuilder builder = XContentFactory.jsonBuilder().startObject().field("user", "kimchy")
					.field("postDate", new Date()).field("message", "trying out Elasticsearch").endObject();

			String jsonData = builder.string();

			IndexResponse response = client.prepareIndex("comment_index", "article").setId("34").setSource(jsonData).get();
			if (response.isCreated()) {
				System.out.println("创建成功!");
			}

			client.close();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

		/*
		 * ElasticSearchHandler handler = new ElasticSearchHandler();
		 * handler.init(); handler.createIndex("ww", "www", "1", getData());
		 * QueryBuilder queryBuilder = QueryBuilders.boolQuery().must(new
		 * QueryStringQueryBuilder("感冒").field("username")); List<Map<String,
		 * Object>> list = handler.queryForObject("ww", "www", queryBuilder,
		 * null, null, 0, 0); for(Map<String, Object> map :list){
		 * System.out.println(map); }
		 */
	}

	public static List<String> getData() {
		List<String> list = new ArrayList<String>();
		String data1 = JsonUtil.obj2JsonData(new Medicine(1, "银花 感冒 颗粒", "功能主治：银花感冒颗粒 ，头痛,清热，解表，利咽。"));
		String data2 = JsonUtil.obj2JsonData(new Medicine(2, "感冒  止咳糖浆", "功能主治：感冒止咳糖浆,解表清热，止咳化痰。"));
		String data3 = JsonUtil.obj2JsonData(new Medicine(3, "感冒灵颗粒", "功能主治：解热镇痛。头痛 ,清热。"));
		String data4 = JsonUtil.obj2JsonData(new Medicine(4, "感冒  灵胶囊", "功能主治：银花感冒颗粒 ，头痛,清热，解表，利咽。"));
		String data5 = JsonUtil.obj2JsonData(new Medicine(5, "仁和 感冒 颗粒", "功能主治：疏风清热，宣肺止咳,解表清热，止咳化痰。"));
		list.add(data1);
		list.add(data2);
		list.add(data3);
		list.add(data4);
		list.add(data5);
		return list;
	}

}

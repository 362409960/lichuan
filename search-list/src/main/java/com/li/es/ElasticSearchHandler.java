package com.li.es;

import java.net.InetAddress;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.elasticsearch.action.admin.indices.exists.indices.IndicesExistsRequest;
import org.elasticsearch.action.search.SearchRequestBuilder;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.action.search.SearchType;
import org.elasticsearch.client.Client;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.InetSocketTransportAddress;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.indices.IndexTemplateMissingException;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.sort.SortOrder;



public class ElasticSearchHandler {

	private static TransportClient client ;

	@SuppressWarnings("unused")
	private synchronized Client getClient() {
		return client;
	}

	public void init() {
		if (null == client) {
			try {
				//Settings settings = Settings.settingsBuilder().put("cluster.name", "lichuan").build();
				//client = TransportClient.builder().settings(settings).build();
				client.addTransportAddress(
						new InetSocketTransportAddress(InetAddress.getByName("192.168.1.125"), 9300));
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public void closeESClient() {
		if (null != client) {
			client.close();
			System.out.println("连接关闭！");
		}
	}

	public void createIndex(String indexName, String typeName, String id, List<String> jsondata) {
		try {
			for (int i = 0; i < jsondata.size(); i++) {
				String jsonObject = jsondata.get(i);
				client.prepareIndex(indexName.toLowerCase(), typeName.toLowerCase())
						// 必须为对象单独指定ID
						.setId(String.valueOf(i)).setSource(jsonObject).execute().actionGet();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public List<Map<String, Object>> queryForObject(String indexName, 
    		String typeName, QueryBuilder queryBuilder, String sortField, SortOrder order, int from, int size){
    	try {
    		SearchRequestBuilder reqBuilder = client.prepareSearch(indexName.toLowerCase())
    				.setTypes(typeName.toLowerCase())
    				.setSearchType(SearchType.DEFAULT)
					.setExplain(true);
    		
    		//设置查询条件
    		reqBuilder.setQuery(queryBuilder)
					.setExplain(true);
    		//根据字段排序
			if (StringUtils.isNotEmpty(sortField) && order != null) {
				reqBuilder.addSort(sortField, order);
			}
			
			//最大显示10000
			if(size == 0)
				size = 10000;
			
			//
			if (from >= 0 && size > 0) {
				reqBuilder.setFrom(from).setSize(size);
			}
			
			SearchResponse searchResponse = reqBuilder.execute().actionGet();
    		
			List<Map<String, Object>> results = new ArrayList<Map<String, Object>>();
			

			
			int length = searchResponse.getHits().hits().length;
			System.out.println("查询到记录数------------>" + length);
		    for(int i = 0; i < length; i++){
		    	SearchHit hit = searchResponse.getHits().getAt(i);
		    	results.add(hit.getSource());
		    }
			return results;
		} catch (Exception e) {
			e.printStackTrace();
		}
    	return null;
    }
	
	 
		public void deleteIndex(String indexName, String indexType, String id){
			try {
				client.prepareDelete(indexName.toLowerCase(), indexType.toLowerCase(), id).execute().actionGet();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	   
		public void deleteIndex(String indexName){
			try {
				IndicesExistsRequest ier = new IndicesExistsRequest();
				ier.indices(new String[]{indexName.toLowerCase()});
				
				boolean exists = client.admin().indices().exists(ier).actionGet().isExists();
				if(exists){
					client.admin().indices().prepareDelete(indexName.toLowerCase()).execute().actionGet();
				}
			}catch(IndexTemplateMissingException ime){
				ime.printStackTrace();
			}
		}

}

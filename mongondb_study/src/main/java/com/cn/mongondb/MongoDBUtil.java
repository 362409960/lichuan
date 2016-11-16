package com.cn.mongondb;

import java.util.ArrayList;
import java.util.List;

import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.MongoCredential;
import com.mongodb.ServerAddress;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

public class MongoDBUtil {

	private static final String host = "127.0.0.1";

	private static final String dbName = "my_mongodb";

	private final static String username = "root";

	private final static String pwd = "123";

	private final static int port = 27017;

	private static MongoClient client;

	private static MongoDatabase db;

	/**
	 * 没有密码
	 * 
	 * @param host
	 * @param port
	 * @return
	 */
	public static MongoClient getClient() {
		client = new MongoClient(host, port);
		return client;
	}

	/**
	 * 有密码
	 * 
	 * @param host
	 * @param port
	 * @return
	 */
	public static MongoClient getMongoClient() {
		ServerAddress serverAddress = new ServerAddress(host, port);
		List<ServerAddress> addrs = new ArrayList<ServerAddress>();
		addrs.add(serverAddress);
		// 三个参数分别为 用户名 数据库名称 密码
		MongoCredential credential = MongoCredential.createScramSha1Credential(username, dbName, pwd.toCharArray());
		List<MongoCredential> credentials = new ArrayList<MongoCredential>();
		credentials.add(credential);
		client = new MongoClient(host, port);

		return client;
	}

	public static void main(String[] args) {
		try {
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 插入mongondb
	 */
	public static void saveMongonDB() {
		db = client.getDatabase(dbName);
		MongoCollection<Document> collection = db.getCollection("test");
		Document document = new Document("title", "MongoDB").append("description", "database").append("likes", 100)
				.append("by", "Fly");
		List<Document> documents = new ArrayList<Document>();
		documents.add(document);
		collection.insertMany(documents);
	}

	/**
	 * 查找
	 */
	public static void findMongonDB() {
		db = client.getDatabase(dbName);
		MongoCollection<Document> collection = db.getCollection("test");
		FindIterable<Document> findIterable = collection.find();
		MongoCursor<Document> mongoCursor = findIterable.iterator();
		while (mongoCursor.hasNext()) {
			System.out.println(mongoCursor.next());
		}
	}

	/**
	 * 更新
	 */
	public static void updateMongonDB() {
		db = client.getDatabase(dbName);
		MongoCollection<Document> collection = db.getCollection("test");
		collection.updateMany(Filters.eq("likes", 100), new Document("$set", new Document("likes", 200)));
		// 检索查看结果
		FindIterable<Document> findIterable = collection.find();
		MongoCursor<Document> mongoCursor = findIterable.iterator();
		while (mongoCursor.hasNext()) {
			System.out.println(mongoCursor.next());
		}
	}
	/**
	 * 删除
	 */
	public static void deleMongonDB() {
		db = client.getDatabase(dbName);
		MongoCollection<Document> collection = db.getCollection("test");
		// 删除符合条件的第一个文档
		collection.deleteOne(Filters.eq("likes", 200));
		// 删除所有符合条件的文档
		collection.deleteMany(Filters.eq("likes", 200));
		// 检索查看结果
		FindIterable<Document> findIterable = collection.find();
		MongoCursor<Document> mongoCursor = findIterable.iterator();
		while (mongoCursor.hasNext()) {
			System.out.println(mongoCursor.next());
		}
	}

	public static void destroy() {
		if (null != client) {
			client.close();
			db = null;
			client = null;
		}
	}

}

package cloud.app.dao;

import cloud.app.entity.NewsStream;

public interface NewsStreamDAO extends BaseDAO<NewsStream> {
	int deleteByPrimaryKey(String id);

	int insert(NewsStream record);

	int insertSelective(NewsStream record);

	NewsStream selectByPrimaryKey(String id);

	int updateByPrimaryKeySelective(NewsStream record);

	int updateByPrimaryKey(NewsStream record);

}
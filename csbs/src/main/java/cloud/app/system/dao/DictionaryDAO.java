package cloud.app.system.dao;

import java.util.List;

import cloud.app.system.po.Dictionary;

public interface DictionaryDAO {

	Dictionary view(String pkId)throws Exception;

	public abstract List<Dictionary> getDictionaryList(Dictionary dictionary);

	public abstract int dictionaryCount(Dictionary dictionary);

	public abstract void insertDictionary(Dictionary paramDictionary)throws Exception;

	public abstract void updateDictionary(Dictionary dictionary)throws Exception;

	public abstract void deleteDictionary(String paramString) throws Exception;
}

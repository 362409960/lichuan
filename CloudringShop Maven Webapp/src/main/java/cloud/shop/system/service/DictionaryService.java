package cloud.shop.system.service;



import java.util.List;

import cloud.shop.system.po.Dictionary;


public interface DictionaryService {

	public abstract Dictionary view(String paramString) throws Exception;

	public abstract List<Dictionary> getDictionaryList(Dictionary dictionary);

	public abstract int dictionaryCount(Dictionary dictionary);

	public abstract void insertDictionary(Dictionary paramDictionary)throws Exception;

	public abstract void updateDictionary(Dictionary dictionary)throws Exception;

	public abstract void deleteDictionary(String paramString) throws Exception;
 
}

package cloud.app.system.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cloud.app.system.dao.DictionaryDAO;
import cloud.app.system.po.Dictionary;
import cloud.app.system.service.DictionaryService;

@Service
public class DictionaryServiceImpl implements DictionaryService {
	
	@Autowired
	private DictionaryDAO dictionaryDAO;

	public List<Dictionary> checkId(String paramString) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	public Dictionary view(String pkId) throws Exception {
		
		return dictionaryDAO.view(pkId);
	}

	@Override
	public List<Dictionary> getDictionaryList(Dictionary dictionary) {
		// TODO Auto-generated method stub
		return dictionaryDAO.getDictionaryList(dictionary);
	}

	@Override
	public int dictionaryCount(Dictionary dictionary) {
		// TODO Auto-generated method stub
		return dictionaryDAO.dictionaryCount(dictionary);
	}

	@Override
	public void insertDictionary(Dictionary paramDictionary) throws Exception {
		// TODO Auto-generated method stub
		dictionaryDAO.insertDictionary(paramDictionary);
	}

	@Override
	public void updateDictionary(Dictionary dictionary) throws Exception {
		// TODO Auto-generated method stub
		dictionaryDAO.updateDictionary(dictionary);
	}

	@Override
	public void deleteDictionary(String paramString) throws Exception {
		// TODO Auto-generated method stub
		dictionaryDAO.deleteDictionary(paramString);
	}

}

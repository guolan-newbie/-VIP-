package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.ThanksGivingDTO;
import entity.ThanksGiving;
import mapper.ThanksGivingMapper;

@Service
public class ThanksGivingDAO {
	@Autowired
	ThanksGivingMapper thanksGivingMapper;

	public void add(ThanksGiving thanksgiving) {
		thanksGivingMapper.addInfo(thanksgiving);
	}

	public List<ThanksGiving> getAll() {
		return thanksGivingMapper.getAllInfo();
	}

	public List<ThanksGiving> getAllByPage(ThanksGivingDTO thanksGivingDTO) {
		return thanksGivingMapper.getAllByPage(thanksGivingDTO);
	}

	public List<ThanksGiving> getInfoByMemberId(int id) {
		return thanksGivingMapper.getInfoByMemberId(id);
	}
}

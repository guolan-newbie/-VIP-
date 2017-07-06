package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.InterestDTO;
import entity.Interest;
import entity.InterestDetail;
import entity.Period;
import mapper.InterestMapper;

@Service
public class InterestDAO {
	@Autowired
	InterestMapper interestMapper;

	public void add(Interest interest) {
		interestMapper.add(interest);
	}

	// 获得每一期的利息
	public Float getInterest(Period period) {
		return interestMapper.getInterest(period);
	}

	// 得到当前会员利息总和
	public float getAllInterest(int mid) {
		if (interestMapper.getAllInterest(mid) == null) {
			return 0;
		} else {
			return interestMapper.getAllInterest(mid);
		}
	}

	// 得到当前会员利息总和
	public List<InterestDetail> getInterestDetail(InterestDTO interestDTO) {
		return interestMapper.getInterestDetailByPage(interestDTO);
	}

	public void delByAid(int aid) {
		interestMapper.delByAid(aid);
	}

	public List<InterestDetail> getInterestDetailByMid(int mid) {
		return interestMapper.getInterestDetailByMid(mid);
	}
}

package mapper;

import java.util.List;

import dto.InterestDTO;
import entity.Interest;
import entity.InterestDetail;
import entity.Period;

public interface InterestMapper {
	public void add(Interest interest);
	//获得每一期的利息
	public Float getInterest(Period period);
	public Float getAllInterest(int mid);
	public List<InterestDetail> getInterestDetailByPage(InterestDTO interestDTO);
	public void delByAid(int aid);
	public List<InterestDetail> getInterestDetailByMid(int mid);
}

package mapper;

import java.util.List;

import dto.ThanksGivingDTO;
import entity.ThanksGiving;

public interface ThanksGivingMapper {
	public void addInfo(ThanksGiving thanksgiving);
	public List<ThanksGiving> getAllInfo();
	public List<ThanksGiving> getAllByPage(ThanksGivingDTO thanksGivingDTO);
	public List<ThanksGiving> getInfoByMemberId(int id);
}

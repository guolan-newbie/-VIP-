package mapper;

import java.util.List;
import java.util.Map;

import dto.OndutyDTO;
import entity.OnDuty;

public interface OndutyMapper {
	public void apply(OnDuty onDuty);
	public List<Map<String, Object>> getByPage(OndutyDTO ondutyDTO);
	public String[] getuname(String mname);
	public int getmid(String uname);
	public void update(OnDuty onduty);
	public void del(int id);
	public List<Map<String, Object>> getOndutyByMidByPage(OndutyDTO ondutyDTO);
	public void setFlag(OnDuty onduty);
	public List<Map<String, Object>> getAllByPage(OndutyDTO ondutyDTO);
	public List<OnDuty> getAllMidByFlag();
	public List<OnDuty> getOndutyByMidAndFlag(int mid);
	public OnDuty getOndutyByid(int id);
}


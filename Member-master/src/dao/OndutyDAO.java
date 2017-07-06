package dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.OndutyDTO;
import entity.OnDuty;
import mapper.OndutyMapper;

@Service
public class OndutyDAO {
	@Autowired
	OndutyMapper ondutyMapper;

	public void add(OnDuty onDuty) {
		ondutyMapper.apply(onDuty);
	}

	public List<Map<String, Object>> get(OndutyDTO ondutyDTO) {
		return ondutyMapper.getByPage(ondutyDTO);
	}

	public String[] getuname(String mname) {
		return ondutyMapper.getuname(mname);
	}

	public int getmid(String uname) {
		return ondutyMapper.getmid(uname);
	}

	public void update(OnDuty onduty) {
		ondutyMapper.update(onduty);
	}

	public void del(int id) {
		ondutyMapper.del(id);
	}

	public List<Map<String, Object>> getOndutyByMid(OndutyDTO ondutyDTO) {
		return ondutyMapper.getOndutyByMidByPage(ondutyDTO);
	}

	public void setFlag(OnDuty onduty) {
		ondutyMapper.setFlag(onduty);
	}

	public List<Map<String, Object>> getAllByPage(OndutyDTO ondutyDTO) {
		return ondutyMapper.getAllByPage(ondutyDTO);
	}

	public List<OnDuty> getAllMidByFlag() {
		return ondutyMapper.getAllMidByFlag();
	}

	public List<OnDuty> getOndutyByMidAndFlag(int mid) {
		return ondutyMapper.getOndutyByMidAndFlag(mid);
	}

	public OnDuty getOndutyByid(int id) {
		return ondutyMapper.getOndutyByid(id);
	}
}

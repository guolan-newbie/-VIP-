package dao;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.OnDutyLogDTO;
import entity.OnDuty;
import entity.OnDutyLog;
import mapper.OnDutyLogMapper;

@Service
public class OnDutyLogDAO {
	@Autowired
	OnDutyLogMapper onDtuyLogMapper;

	public void add(OnDutyLog onDutyLog) {
		onDtuyLogMapper.add(onDutyLog);
	}

	public ArrayList<OnDuty> getApply(int mid) {
		return onDtuyLogMapper.getApply(mid);
	}

	public ArrayList<OnDutyLog> getLogs() {
		return onDtuyLogMapper.getLogs();
	}

	public ArrayList<OnDutyLog> getLogsByPage(OnDutyLogDTO onDutyLogDTO) {
		return onDtuyLogMapper.getLogsByPage(onDutyLogDTO);
	}

	public String getSRById(int id) {
		return onDtuyLogMapper.getSRById(id);
	}

	public void checkLogById(OnDutyLog onDutyLog) {
		onDtuyLogMapper.checkLogById(onDutyLog);
	}

	public ArrayList<OnDutyLog> getLogsForModifyByPage(OnDutyLogDTO onDutyLogDTO) {
		return onDtuyLogMapper.getLogsForModifyByPage(onDutyLogDTO);
	}

	public OnDutyLog getLogById(int id) {
		return onDtuyLogMapper.getLogById(id);
	}

	public void modify(OnDutyLog onDutyLog) {
		onDtuyLogMapper.modify(onDutyLog);
	}

	public ArrayList<OnDutyLog> getLogsByOid(OnDutyLog onDutyLog) {
		return onDtuyLogMapper.getLogsByOid(onDutyLog);
	}

	public ArrayList<OnDutyLog> getLogsByOidAndMid(OnDutyLog onDutyLog) {
		return onDtuyLogMapper.getLogsByOid(onDutyLog);
	}
}

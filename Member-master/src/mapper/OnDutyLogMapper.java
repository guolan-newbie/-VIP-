package mapper;

import java.util.ArrayList;

import dto.OnDutyLogDTO;
import entity.OnDuty;
import entity.OnDutyLog;

public interface OnDutyLogMapper {
	public void add(OnDutyLog onDutyLog);
	public ArrayList<OnDuty> getApply(int mid);
	public ArrayList<OnDutyLog> getLogs();
	public ArrayList<OnDutyLog> getLogsByPage(OnDutyLogDTO onDutyLogDTO);
	public String getSRById(int id);
	public void checkLogById(OnDutyLog onDutyLog);
	public ArrayList<OnDutyLog> getLogsForModifyByPage(OnDutyLogDTO onDutyLogDTO);
	public OnDutyLog getLogById(int id);
	public void modify(OnDutyLog onDutyLog);
	public ArrayList<OnDutyLog> getLogsByOid(OnDutyLog onDutyLog);
	public ArrayList<OnDutyLog> getLogsByOidAndMid(OnDutyLog onDutyLog);
}


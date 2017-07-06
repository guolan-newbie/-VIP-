package mapper;

import java.util.List;
import java.util.Map;

import dto.AccountLogDTO;
import entity.AccountLog;
import entity.Member;

public interface AccountLogMapper {
	public void add(AccountLog accountLog);
	public AccountLog getAccountLogById(int id);
	public List<AccountLog> getAccountLogByMIdByPage(AccountLogDTO accountLogDTO);
	public List<AccountLog> getAccountLogForCheck(int mid);
	public void updateFlag(AccountLog accountLog);
	public int getDateAmount(String date);
	public void deleteAcountLogById(int id);
	public List<Map<String,String>> getDateDetail(String date);
	public double getAmountByMid(Map<String, Object> map);
	public double getSumAmountByMid(Map<String, Object> map);
	public List<Map<String,Object>> getMemByAmount(String date);
	public List<Map<String,Object>> getMemByMonth(String date);
	public List<Map<String,Object>> getMidByAmount(Map<String, Object> map);
	public String getLastAmountDateByMid(int mid);
	public int checkFlag(AccountLog accountLog);
	public List<AccountLog> getAccountLogByFlag();
	public AccountLog getAccountLogLastById(int mid);
	public List<AccountLog> getAccountLogAllByMidAndFlag(Member member);
	public void updateAccountLog(AccountLog accountLog);
	public List<AccountLog> getAccountLogByMid(int mid);
	public void deleteAcountLogByMid(int mid);
	public AccountLog getAccountLogByMidAndFlagLast(int mid);
	public List<AccountLog> getAccountLogLast(int type);

}

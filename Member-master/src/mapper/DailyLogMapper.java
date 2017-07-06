package mapper;

import java.util.List;

import entity.DailyLog;

public interface DailyLogMapper {
	public void addDailyLog(DailyLog dailyLog);

	public List<DailyLog> getDailyLog(DailyLog dailyLog);
	
	public DailyLog getDailyLogById(int id);
	
	public boolean checkDailyLog(DailyLog dailyLog);
	
	public void modifyDailyLog(DailyLog dailyLog);
	
	public void deleteDailyLog(int id);
	
	public List<DailyLog> getDailyLogTimeByName(DailyLog dailyLog);
}

package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import entity.DailyLog;
import mapper.DailyLogMapper;
import tools.Result;

@Service
public class DailyLogDAO {
	@Autowired
	private DailyLogMapper dailyLogMapper;

	public void addDailyLog(DailyLog dailyLog) {
		dailyLogMapper.addDailyLog(dailyLog);
	}

	public Result getDailyLog(DailyLog dailyLog, int page, int rows) {
		PageHelper.startPage(page, rows);
		List<DailyLog> list = dailyLogMapper.getDailyLog(dailyLog);
		PageInfo<DailyLog> pageInfo = new PageInfo<>(list);
		return Result.ok(list, pageInfo.getPageNum(), pageInfo.getPages());
	}

	public DailyLog getDailyLogById(int id) {
		return  dailyLogMapper.getDailyLogById(id);
		
	}

	public boolean checkDailyLog(DailyLog dailyLog) {
		return dailyLogMapper.checkDailyLog(dailyLog);

	}
	public void modifyDailyLog(DailyLog dailyLog)
	{
		dailyLogMapper.modifyDailyLog(dailyLog);
	}
	
	public void deleteDailyLog(int id)
	{
		dailyLogMapper.deleteDailyLog(id);
	}
	
	public List<DailyLog> getDailyLogTimeByName(DailyLog dailyLog)
	{
		return dailyLogMapper.getDailyLogTimeByName(dailyLog);
	}
}

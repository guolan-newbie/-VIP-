package mapper;

import java.util.List;
import java.util.Map;

import dto.PeriodDTO;
import entity.Member;
import entity.Period;

public interface PeriodMapper {
	public void add(Period period);
	public int exists(int id);
	public List<Period> getAllByPage(PeriodDTO periodDTO);
	public List<Period> getAll(int id);
	public void update(Period period);
	public double getPeriodByMid(int id);
	public double getRestAmount(int mid);
	public double getSum(int mid);
	public double getFirst(int mid);
	public double getLast(int mid);
	public double getMonthly(int mid);
	public double getRestAmountByMid(Map<String,Object> map);
	public void deleteByMid(int id);
	public List<Period> getSettlement(int mid);
	public List<Period> getAllByMid(int mid);
	public double getUnpaidByMid(int mid);
	public int getAllMonthByMid(int mid);
	public int getDelayMonthyByMid(int mid);
}

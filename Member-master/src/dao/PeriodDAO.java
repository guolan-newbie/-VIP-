package dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.PeriodDTO;
import entity.AccountLog;
import entity.Member;
import entity.Period;
import mapper.AccountLogMapper;
import mapper.InterestMapper;
import mapper.MemberMapper;
import mapper.PeriodMapper;

@Service
public class PeriodDAO {
	@Autowired
	PeriodMapper periodMapper;
	@Autowired
	AccountLogMapper accountLogMapper;
	@Autowired
	InterestMapper interestMapper;
	@Autowired
	MemberMapper memberMapper;

	public void add(Period period) {
		periodMapper.add(period);
	}

	public int exists(int id) {
		return periodMapper.exists(id);
	}

	// 分页获取
	public List<Period> getAllByPage(PeriodDTO periodDTO) {
		return periodMapper.getAllByPage(periodDTO);
	}

	public List<Period> getAll(int id) {
		return periodMapper.getAll(id);
	}

	// 获得每一期的利息
	public void update(Period period) {
		periodMapper.update(period);
	}

	// 获得会员分期剩余金额大于0的分期信息
	public double getPeriodByMid(int id) {
		return periodMapper.getPeriodByMid(id);
	}

	public double getRestAmount(int mid) {
		return periodMapper.getRestAmount(mid);
	}

	public double getSum(int mid) {
		return periodMapper.getSum(mid);
	}

	public double getFirst(int mid) {
		return periodMapper.getFirst(mid);
	}

	public double getLast(int mid) {
		return periodMapper.getLast(mid);
	}

	public double getMonthly(int mid) {
		return periodMapper.getMonthly(mid);
	}

	public double getRestAmountByMid(Map<String, Object> map) {
		return periodMapper.getRestAmountByMid(map);
	}

	public void deleteByMid(int id) {
		periodMapper.deleteByMid(id);
	}

	public List<Period> getSettlement(int mid) {
		return periodMapper.getSettlement(mid);
	}

	public List<Period> getAllByMid(int mid) {
		return periodMapper.getAllByMid(mid);
	}

	public double getUnpaidByMid(int mid) {
		return periodMapper.getUnpaidByMid(mid);
	}

	public int getAllMonthByMid(int mid) {
		return periodMapper.getAllMonthByMid(mid);
	}

	public int getDelayMonthyByMid(int mid) {
		return periodMapper.getDelayMonthyByMid(mid);
	}

	public int initInstalment(int mid) {
		periodMapper.deleteByMid(mid);
		List<AccountLog> list = accountLogMapper.getAccountLogByMid(mid);
		int i = 0;
		for (AccountLog accountLog : list) {
			accountLog.setFlag(false);
			accountLog.setFileflag(0);
			accountLog.setType(null);
			accountLog.setPhoto(null);
			accountLogMapper.updateAccountLog(accountLog);
			interestMapper.delByAid(accountLog.getId());
			i++;
		}
		Member member = memberMapper.getMemById(mid);
		member.setAlog(i);
		memberMapper.update(member);
		return i;
	}
}

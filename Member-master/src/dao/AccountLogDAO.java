package dao;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import dto.AccountLogDTO;
import entity.AccountLog;
import entity.Admin;
import entity.Member;
import mapper.AccountLogMapper;
import mapper.MemberMapper;
import tools.Result;

@Service
public class AccountLogDAO {
	@Autowired
	AccountLogMapper accountLogMapper;
	
	@Autowired
	MemberMapper memberMapper;

	public void add(AccountLog accountLog) {
		Member member = accountLog.getMember();
		int memberAlog = member.getAlog();
		member.setAlog(memberAlog + 1);
		memberMapper.update(member);
		accountLog.setMember(member);
		if(memberAlog <= 0) {
			accountLogMapper.add(accountLog);
		} else {
			System.out.println("============"+member.getId()+"====");
			AccountLog accountlogOld = accountLogMapper.getAccountLogByMidAndFlagLast(member.getId());
			
			System.out.println("以前的缴费记录数-------========="+accountlogOld);
			System.out.println("第一个日期：======="+accountlogOld.getDate());
			System.out.println("第二个日期：======="+accountLog.getDate());
			if (DateUtils.isSameDay(accountlogOld.getDate(), accountLog.getDate())) {
				accountlogOld.setAmount(accountlogOld.getAmount() + accountLog.getAmount());
				accountlogOld.setDate(accountLog.getDate());
				accountlogOld.setFileflag(accountLog.getFileflag());
				accountlogOld.setPhoto(accountLog.getPhoto());
				accountlogOld.setType(accountLog.getType());
				accountlogOld.setUpflag(accountlogOld.getUpflag() + 1);
				accountLogMapper.updateAccountLog(accountlogOld);
			} else {
				accountLogMapper.add(accountLog);
			}
		}
	}

	public AccountLog getAccountLogById(int id) {
		return accountLogMapper.getAccountLogById(id);
	}

	public List<AccountLog> getAccountLogByMId(AccountLogDTO accountLogDTO) {
		return accountLogMapper.getAccountLogByMIdByPage(accountLogDTO);
	}

	public List<AccountLog> getAccountLogForCheck(int mid) {
		return accountLogMapper.getAccountLogForCheck(mid);
	}

	public void updateFlag(AccountLog accountLog) {
		accountLogMapper.updateFlag(accountLog);
	}

	public int getDateAmount(String date) {
		return accountLogMapper.getDateAmount(date);
	}

	public void deleteAcountLogById(int id) {
		accountLogMapper.deleteAcountLogById(id);
	}

	public List<Map<String, String>> getDateDetail(String date) {
		return accountLogMapper.getDateDetail(date);
	}

	public double getAmountByMid(Map<String, Object> map) {
		return accountLogMapper.getAmountByMid(map);
	}

	public double getSumAmountByMid(Map<String, Object> map) {
		return accountLogMapper.getSumAmountByMid(map);
	}

	public List<Map<String, Object>> getMemByAmount(String date) {
		return accountLogMapper.getMemByAmount(date);
	}

	public List<Map<String, Object>> getMemByMonth(String date) {
		return accountLogMapper.getMemByMonth(date);
	}

	public List<Map<String, Object>> getMidByAmount(Map<String, Object> map) {
		return accountLogMapper.getMidByAmount(map);
	}

	public String getLastAmountDateByMid(int mid) {
		return accountLogMapper.getLastAmountDateByMid(mid);
	}

	public int checkFlag(AccountLog accountLog) {
		return accountLogMapper.checkFlag(accountLog);
	}

	public List<AccountLog> getAccountLogByFlag() {
		return accountLogMapper.getAccountLogByFlag();
	}

	public AccountLog getAccountLogLastById(int mid) {
		return accountLogMapper.getAccountLogLastById(mid);
	}

	public List<AccountLog> getAccountLogAllByMidAndFlag(Member member) {
		return accountLogMapper.getAccountLogAllByMidAndFlag(member);
	}

	public void updateAccountLog(AccountLog accountLog) {
		accountLogMapper.updateAccountLog(accountLog);
	}

	public List<AccountLog> getAccountLogByMid(int mid) {
		return accountLogMapper.getAccountLogByMid(mid);
	}

	public void deleteAcountLogByMid(int mid) {
		accountLogMapper.deleteAcountLogByMid(mid);
	}
	public Result getAccountLogLast(int type, int page, int rows) {
		PageHelper.startPage(page, rows);
		List<AccountLog> list = accountLogMapper.getAccountLogLast(type);
		System.out.println(list.get(0));
		PageInfo<AccountLog> pageInfo = new PageInfo<>(list);
		return Result.ok(list, pageInfo.getPageNum(), pageInfo.getPages());
	}
	
}

package dao;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import dto.CostDTO;
import dto.SchoolDTO;
import entity.Clue;
import entity.Member;
import entity.Period;
import entity.Picture;
import entity.Province;
import entity.ResultType;
import entity.Summary;
import entity.User;
import mapper.MemberMapper;
import mapper.PeriodMapper;
import tools.FeePayFileExcel;
import tools.Result;

@Service
public class MemberDAO {
	@Autowired
	private MemberMapper memberMapper;
	@Autowired
	private PeriodMapper periodMapper;

	public List<Member> getByUid(int uid) {
		return memberMapper.getByUid(uid);
	}

	public void updateRest(Member member) {
		memberMapper.updateRest(member);
	}

	public void update(Member member) {
		memberMapper.update(member);
	}

	public List<Member> getAll() {
		return memberMapper.getAll();
	}

	public List<Summary> getSumAll(Summary summary) {
		return memberMapper.getSumAll(summary);
	}

	public Member getMemById(int id) {
		return memberMapper.getMemById(id);
	}

	public ResultType getSex() {
		return memberMapper.getSex();
	}

	public ResultType getStudent() {
		return memberMapper.getStudent();
	}

	public ResultType getAge() {
		return memberMapper.getAge();
	}

	public int getCount() {
		return memberMapper.getCount();
	}

	public List<Province> getProvinces() {
		return memberMapper.getProvinces();
	}

	public List<Province> getProvince() {
		return memberMapper.getProvince();
	}

	public List<Province> getBornProvince() {
		return memberMapper.getBornProvince();
	}

	public Member getMemByName(String name) {
		return memberMapper.getMemByName(name);
	}

	public Member getMemByMobile(String mobile) {
		return memberMapper.getMemByMobile(mobile);
	}

	public ArrayList<User> samePro(int provid) {
		return (ArrayList<User>) memberMapper.samePro(provid);
	}

	public List<User> getMemDetails(int id) {
		return memberMapper.getMemDetails(id);
	}

	public Province getProvByProvId(int provid) {
		return memberMapper.getProvByProvId(provid);
	}

	public ArrayList<User> sameScho(String school) {
		return (ArrayList<User>) memberMapper.sameScho(school);
	}

	public ArrayList<User> sameAge(String idNo) {
		return (ArrayList<User>) memberMapper.sameAge(idNo);
	}

	public Picture getCover(int uid) {
		return memberMapper.getCover(uid);
	}

	public void add(Member member) {
		memberMapper.add(member);
	}

	// 获取会员编号
	public String getMemNum(int mid) {
		return memberMapper.getUnameByMid(mid);
	}

	public void print(String[] headers, String path, String title) throws IOException {
		FeePayFileExcel ef = new FeePayFileExcel();
		ef.exportExcel(title, headers, memberMapper.getMemberCost(0), path);
	}

	public List<String> getAllSchoolByPage(SchoolDTO schoolDTO) {
		return memberMapper.getAllSchoolByPage(schoolDTO);
	}

	public int getSchoolMemberCount(String school) {
		return memberMapper.getSchoolMemberCount(school);
	}

	public void setcustomPay(ArrayList<Period> list, Member member) {
		for (Period period : list) {
			periodMapper.add(period);
		}
		memberMapper.update(member);
	}
	
	public Result getMemberCost(int type, int page, int rows) {
		PageHelper.startPage(page, rows);
		List<CostDTO> list = memberMapper.getMemberCost(type);
		PageInfo<CostDTO> pageInfo = new PageInfo<>(list);
		return Result.ok(list, pageInfo.getPageNum(), pageInfo.getPages());
	}
}

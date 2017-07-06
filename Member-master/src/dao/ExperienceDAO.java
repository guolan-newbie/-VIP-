package dao;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import dto.ExperienceDTO;
import entity.Clue;
import entity.Experience;
import entity.Member;
import mapper.ExperienceMapper;
import tools.ClueFileExcel;
import tools.ExperienceFileExcel;
import tools.PinYinUtil;
import tools.Result;

@Service
public class ExperienceDAO {
	@Autowired
	ExperienceMapper experienceMapper;

	public void add(Experience experience) {
		experienceMapper.add(experience);
	}

	public int checkExists(String num) {
		return experienceMapper.checkExists(num);
	}

	public void delete(int id) {
		experienceMapper.delete(id);
	}

	// 所有体验者
	public List<Experience> getExperienceByPage(ExperienceDTO experienceDTO) {
		return experienceMapper.getExperienceByPage(experienceDTO);
	}

	public Experience getExperienceById(int id) {
		return experienceMapper.getExperienceById(id);
	}

	public Result getExperienceByPinyin(String pinyin) {
		List<Experience> experiences = experienceMapper.getExperienceByPinyin();
		List<Experience> list = new ArrayList<>();
		int size = experiences.size();
		int length = pinyin.length();
		boolean flag = true;
		for (int i = 0; i < size; i++) {
			Experience experience = experiences.get(i);
			String pinYinInitials = PinYinUtil.getPinYinInitials(experience.getName());
			if (length <= pinYinInitials.length()) {
				for (int j = 0; j < length; j++) {
					if (pinYinInitials.charAt(j) != pinyin.charAt(j)) {
						flag = false;
					}
				}
				if (flag) {
					list.add(experience);
				}
				flag = true;
			}
		}
		return Result.ok(list);
	}

	public Result getExperienceList(Integer status, String qq, Integer aId, Integer page, Integer rows) {
		PageHelper.startPage(page, rows);
		List<Experience> list = experienceMapper.getExperienceList(status, aId, qq);
		PageInfo<Experience> pageInfo = new PageInfo<>(list);
		return Result.ok(list, pageInfo.getPageNum(), pageInfo.getPages());
	}

	// 获取每月加入会员信息的方法  作者:陈家豪 日期:2017-5-4
	public Result getMemberByMonth(Integer page, Integer rows, Integer years, Integer month) {
		PageHelper.startPage(page, rows);
		List<Member> list = experienceMapper.getMemberByMonth(years, month);
		PageInfo<Member> pageInfo = new PageInfo<>(list);
		return Result.ok(list, pageInfo.getPageNum(), pageInfo.getPages());
	}

	// 加入、预科、退出 作者:陈家豪
	public List<Experience> getExperienceInByPage(ExperienceDTO experienceDTO) {
		return experienceMapper.getExperienceInByPage(experienceDTO);
	}

	// 正在体验的体验者 作者:陈家豪
	public List<Experience> getExperienceIngByPage(ExperienceDTO experienceDTO) {
		return experienceMapper.getExperienceIngByPage(experienceDTO);
	}

	public Result getExperienceInfoById(int id) {
		Experience experience = experienceMapper.getExperienceById(id);
		experience.setPassword(null);
		experience.setSalt(null);
		return Result.ok(experience);
	}

	public List<Experience> getExperiences() {
		return experienceMapper.getExperienceList(0, 0, "");
	}

	public Experience getLastOne() {
		return experienceMapper.getLastOne();
	}

	public int getMidById(int id) {
		return experienceMapper.getMidById(id);
	}

	public String getNum() {
		return experienceMapper.getNum();
	}

	public int getUidById(int id) {
		if (experienceMapper.countExperienceUid(id) == 0) {
			return 0;
		}
		return experienceMapper.getUidById(id);
	}

	public String getSaltByNum(String num) {
		return experienceMapper.getSaltByNum(num);
	}

	public Experience isValid(Experience experience) {
		return experienceMapper.isValid(experience);
	}

	public void update(Experience experience) {
		experienceMapper.update(experience);
	}

	public void print(List<Experience> list, String[] headers, String path, String title) throws IOException {
		ExperienceFileExcel ef = new ExperienceFileExcel();
		ef.exportExcel(title, headers, list, path);
	}

}

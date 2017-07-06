package dao;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import entity.Admin;
import entity.Clue;
import entity.Communication;
import entity.Experience;
import mapper.AdminMapper;
import mapper.ClueMapper;
import mapper.CommunicationMapper;
import mapper.ExperienceMapper;
import tools.ClueFileExcel;
import tools.MD5SaltUtils;
import tools.Result;
import tools.experienceNum;

@Service
public class ClueDAO {
	@Autowired
	ClueMapper clueMapper;
	@Autowired
	CommunicationMapper communicationMapper;
	@Autowired
	ExperienceMapper experienceMapper;
	@Autowired
	AdminMapper adminMapper;

	public void add(Clue clue) {
		clueMapper.add(clue);
	}

	public boolean checkQq(String qq) {
		return !clueMapper.checkqq(qq);
	}

	public void delete(int id) {
		clueMapper.delete(id);
		communicationMapper.deleteClueCommunication(id);
	}
	
	public void deleteCommunicationById(int id) {
		communicationMapper.deleteById(id);
	}

	public List<Communication> getCommunication(int cid) {
		return communicationMapper.getCommunicationByCid(cid);
	}

	public List<Admin> getAssistants() {
		return adminMapper.getWorkAdmin();
	}
	
	public List<Clue> getClue() {
		return clueMapper.getClues(0, 0, null);
	}

	public Clue getClueById(int id) {
		return clueMapper.getClueById(id);
	}
	
	public Result getClues(Integer type, Integer aid, String qq, int page, int rows) {
		PageHelper.startPage(page, rows);
		List<Clue> list = clueMapper.getClues(type, aid, qq);
		PageInfo<Clue> pageInfo = new PageInfo<>(list);
		return Result.ok(list, pageInfo.getPageNum(), pageInfo.getPages());
	}

	public String getNum() {
		return clueMapper.getNum();
	}

	public void joinExperience(Clue clue) {
		// 创建体验者对象
		Experience experience = new Experience();
		String salt = MD5SaltUtils.randomCreateSalt();
		String num = experienceNum.getNum(experienceMapper.getNum());
		experience.setNum(num);
		experience.setPassword(MD5SaltUtils.encode("12345678", salt));
		experience.setSalt(salt);
		experience.setSchool(clue.getSchool());
		experience.setName(clue.getRealName());
		experience.setSex(clue.getSex());
		experience.setPhone(clue.getPhone());
		experience.setStudent(clue.isType());
		experience.setAid(clue.getAdmin().getId());
		experience.setGraduateDate(clue.getGraduateDate());
		experience.setClueid(clue.getId());
		experience.setQq(clue.getQq());
		experience.setBegintime(new Date());
		experience.setSeat_provid(1);
		experience.setProvince("1");
	
		// 修改clue对象
		clue.setFlag(1);
		clue.setEtime(new Date());
		clue.setExnum(num);
	
		// 修改、创建数据
		experienceMapper.add(experience);
		clueMapper.update(clue);
	}

	public void print(List<Clue> list, String[] headers, String path, String title) throws IOException {
		ClueFileExcel ef = new ClueFileExcel();
		ef.exportExcel(title, headers, list, path);
	}

	public void update(Clue clue) {
		clueMapper.update(clue);
	}
	
}

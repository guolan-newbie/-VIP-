package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import dto.ExperienceDTO;
import entity.Experience;
import entity.Member;

public interface ExperienceMapper {
	public void add(Experience experience);

	public int checkExists(String num);

	public void delete(int id);

	// 显示所有体验者
	public List<Experience> getExperienceByPage(ExperienceDTO experienceDTO);

	// 显示已经加入、预科、退出的体验者
	public List<Experience> getExperienceInByPage(ExperienceDTO experienceDTO);

	// 显示正在体验的体验者
	public List<Experience> getExperienceIngByPage(ExperienceDTO experienceDTO);

	public Experience getExperienceById(int id);

	public List<Experience> getExperienceByPinyin();

	public List<Experience> getExperienceList(@Param("status") int status, @Param("aId") int aId,
			@Param("qq") String qq);

	// 获取每月加入VIP会员信息
	public List<Member> getMemberByMonth(@Param("years") int years,@Param("month") int month);

	public Experience getLastOne();

	public String getNum();

	public int getMidById(int id);

	public int getUidById(int id);

	public String getSaltByNum(String num);

	public Experience isValid(Experience experience);

	public void update(Experience experience);

	public int countExperienceUid(int id);
}

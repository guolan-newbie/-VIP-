package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import dto.CostDTO;
import dto.SchoolDTO;
import entity.Member;
import entity.Picture;
import entity.Province;
import entity.ResultType;
import entity.Summary;
import entity.User;

public interface MemberMapper {
	public List<Member> getByUid(int uid);

	public void update(Member member);

	public List<Member> getAll();

	public List<Summary> getSumAll(Summary summary);

	public Member getMemById(int id);

	public ResultType getSex();

	public ResultType getStudent();

	public ResultType getAge();

	public int getCount();

	public List<Province> getProvinces();

	public List<Province> getProvince();

	public List<Province> getBornProvince();

	public Member getMemByName(String name);

	public void updateRest(Member member);

	public Member getMemByMobile(String mobile);

	public List<User> samePro(int provid);

	public List<User> getMemDetails(int id);

	public Province getProvByProvId(int provid);

	public List<User> sameScho(String school);

	public List<User> sameAge(String idNo);

	public Picture getCover(int uid);

	public void add(Member member);

	public String getUnameByMid(int mid);

	public List<String> getAllSchoolByPage(SchoolDTO schoolDTO);

	public int getSchoolMemberCount(String school);

	public List<CostDTO> getMemberCost(@Param("type") int type);
}

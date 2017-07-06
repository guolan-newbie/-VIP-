package mapper;

import java.util.List;

import dto.CourseandproDTO;
import entity.CourseInfo;
import entity.Courseandpro;
import entity.MemAndExp;
import entity.StudentAndProcess;

public interface CourseandproMapper {
	public int update(Courseandpro courseandpro);
	public void add(Courseandpro courseandpro);
	public Courseandpro exists(Courseandpro courseandpro);
	public double getmyCid(int uid);
	public Courseandpro getcourseandproByCid(int cid);
	public List<MemAndExp> getCourseandproByPage(CourseandproDTO courseandproDTO);
	public int getCourseandproNum(Courseandpro courseandpro);
	public List<Courseandpro> getCategoryCourseandproByPage(CourseandproDTO courseandproDTO);
	public List<StudentAndProcess> getStudentCategory(StudentAndProcess studentAndProcess);
	public List<StudentAndProcess> getStudentLearnedCategory(StudentAndProcess studentAndProcess);
	public void deleteByCaid(Courseandpro courseandpro);
}

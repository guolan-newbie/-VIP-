package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.CourseandproDTO;
import entity.Courseandpro;
import entity.MemAndExp;
import entity.StudentAndProcess;
import mapper.CourseandproMapper;

@Service
public class CourseandproDAO {
	@Autowired
	CourseandproMapper courseandpromapper;

	public int update(Courseandpro courseandpro) {
		return courseandpromapper.update(courseandpro);
	}

	public void add(Courseandpro courseandpro) {
		courseandpromapper.add(courseandpro);
	}

	public Courseandpro exists(Courseandpro courseandpro) {
		return courseandpromapper.exists(courseandpro);
	}

	public Courseandpro getcourseandproByCid(int cid) {
		return courseandpromapper.getcourseandproByCid(cid);
	}

	public double getmyCid(int uid) {
		return courseandpromapper.getmyCid(uid);
	}

	public List<MemAndExp> getCourseandproByPage(CourseandproDTO courseandproDTO) {
		return courseandpromapper.getCourseandproByPage(courseandproDTO);
	}

	public int getCourseandproNum(Courseandpro courseandpro) {
		return courseandpromapper.getCourseandproNum(courseandpro);
	}

	public List<Courseandpro> getCategoryCourseandproByPage(CourseandproDTO courseandproDTO) {
		return courseandpromapper.getCategoryCourseandproByPage(courseandproDTO);
	}

	public List<StudentAndProcess> getStudentCategory(StudentAndProcess studentAndProcess) {
		return courseandpromapper.getStudentCategory(studentAndProcess);
	}

	public List<StudentAndProcess> getStudentLearnedCategory(StudentAndProcess studentAndProcess) {
		return courseandpromapper.getStudentLearnedCategory(studentAndProcess);
	}

	public void deleteByCaid(Courseandpro courseandpro) {
		courseandpromapper.deleteByCaid(courseandpro);
	}
}

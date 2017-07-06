package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.CourseDTO;
import dto.CourseandproDTO;
import entity.Category;
import entity.Course;
import entity.CourseAndCategory;
import entity.CourseInfo;
import entity.Courseandpro;
import entity.MemAndExp;
import entity.Member;
import mapper.CourseMapper;

@Service
public class CourseDAO {

	@Autowired
	CourseMapper coursemapper;

	public List<Course> getCourseByPage(CourseDTO courseDTO) {
		return coursemapper.getCourseByPage(courseDTO);
	}

	public void add(Course course) {
		coursemapper.add(course);
	}

	public void update(Course course) {
		coursemapper.update(course);
	}

	public Course getCourseById(int id) {
		return coursemapper.getCourseById(id);
	}

	public double getallCid() {
		return coursemapper.getallCid();
	}

	public String getchapter(int id) {
		return coursemapper.getchapter(id);
	}

	public List<Course> getChapters() {
		return coursemapper.getChapters();
	}

	public List<Course> getLessons(int chid) {
		return coursemapper.getLessons(chid);
	}

	public int getcpid(int cid) {
		return coursemapper.getcpid(cid);
	}

	public List<CourseInfo> finishcourse(int uid) {
		return coursemapper.finishcourse(uid);
	}

	public void delete(int id) {
		coursemapper.delete(id);
	}

	public void setOrder(Course course) {
		coursemapper.setOrder(course);
	}

	public void addCategory(Category category) {
		coursemapper.addCategory(category);
	}

	public int getLastCategoryId() {
		return coursemapper.getLastCategoryId();
	}

	public void addCourseAndCategory(CourseAndCategory courseAndCategory) {
		coursemapper.addCourseAndCategory(courseAndCategory);
	}

	public List<Category> getcategory() {
		return coursemapper.getcategory();
	}

	public List<Course> getcachapter(int caid) {
		return coursemapper.getcachapter(caid);
	}

	public List<Category> getCategoryByMeid(MemAndExp memAndExp) {
		return coursemapper.getCategoryByMeid(memAndExp);
	}

	public int getCourseGross(Courseandpro courseandpro) {
		return coursemapper.getCourseGross(courseandpro);
	}

	public List<Course> getChaptersNotInThisCategory(int caid) {
		return coursemapper.getChaptersNotInThisCategory(caid);
	}

	public void updateCategory(Category category) {
		coursemapper.updateCategory(category);
	}

	public void deleteCCByCaid(int id) {
		coursemapper.deleteCCByCaid(id);
	}

	public List<Integer> getCourseAmountBeforeThisChapter(Courseandpro courseandpro) {
		return coursemapper.getCourseAmountBeforeThisChapter(courseandpro);
	}

	public List<String> getCategoryTitleByCid(int cid) {
		return coursemapper.getCategoryTitleByCid(cid);
	}

	public void deleteCCByCid(int cid) {
		coursemapper.deleteCCByCid(cid);
	}

	public void deleteByChid(int chid) {
		coursemapper.deleteByChid(chid);
	}

	public List<Member> getTheSamePeriodMember(CourseDTO courseDTO) {
		return coursemapper.getTheSamePeriodMember(courseDTO);
	}

	public List<MemAndExp> getTheSameProgressStudent(CourseandproDTO courseandproDTO) {
		return coursemapper.getTheSameProgressStudent(courseandproDTO);
	}
}

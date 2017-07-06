package mapper;

import java.util.List;

import dto.CourseDTO;
import dto.CourseandproDTO;
import entity.Category;
import entity.Course;
import entity.CourseAndCategory;
import entity.CourseInfo;
import entity.Courseandpro;
import entity.MemAndExp;
import entity.Member;

public interface CourseMapper {
	public List<Course> getCourseByPage(CourseDTO courseDTO);
	public void add(Course course);
	public void update(Course course);
	public Course getCourseById(int id);
	public double getallCid();
	public String getchapter(int id);
	public List<Course> getChapters();
	public List<Course> getLessons(int chid);
	public int getcpid(int cid);
	public List<CourseInfo> finishcourse(int uid);
	public void delete(int id);
	public void setOrder(Course course);
	public void addCategory(Category category);
	public int getLastCategoryId();
	public void addCourseAndCategory(CourseAndCategory courseAndCategory);
	public List<Category> getcategory();
	public List<Course> getcachapter(int caid);
	public List<Category> getCategoryByMeid(MemAndExp memAndExp);
	public int getCourseGross(Courseandpro courseandpro);
	public List<Course> getChaptersNotInThisCategory(int caid);
	public void updateCategory(Category category);
	public void deleteCCByCaid(int id);
	public List<Integer> getCourseAmountBeforeThisChapter(Courseandpro courseandpro);
	public List<String> getCategoryTitleByCid(int cid);
	public void deleteCCByCid(int cid);
	public void deleteByChid(int chid);
	public List<Member> getTheSamePeriodMember(CourseDTO courseDTO);
	public List<MemAndExp> getTheSameProgressStudent(CourseandproDTO courseandproDTO);
}

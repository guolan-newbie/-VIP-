package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import dto.MemAndExpDTO;
import dto.SummaryDTO;
import entity.LookSummary;
import entity.MemAndExp;
import entity.Summary;
import entity.SummaryVisit;

public interface SummaryMapper {
	public int add(Summary summary);

	public int approveSumarry(Summary summary);

	public int updateSummary(Summary summary);

	public int updateRemind(int id);

	public int deleteRemind(int id);

	public int update1Summary(Summary summary);

	public List<Summary> getSummaryAll(String week);

	public Summary getSumById(int id);

	public int getMemId(int id);

	public int addTitle(Summary summary);

	public String getTitle(int mid);

	public Summary getComment(int pid);

	public int addComment(Summary summary);

	public Summary getContent(Summary summary);

	public int isChePid(int id);

	public int isApprove(int id);

	public int getAid(Summary summary);

	public int getExpId(int id);

	public int getMId(int id);

	public int getRemind(int id);

	public String checkIsRepeatByTit(Summary summary);

	public Summary getNewestComment(int pid);

	public int checkUserIsWrite(int mid);

	public Summary getContent2(Summary summary);

	public int JudgeMemIsModify(Summary summary);

	public List<Summary> getSummaryByWeek(String week);

	public List<LookSummary> getSummarysByPage(SummaryDTO summaryDTO);

	public List<LookSummary> getSummarysByNameWithPage(SummaryDTO summaryDTO);

	public Summary getCurrentSummary(Summary summary);

	public void delSum(int id);

	public void delCom(int pid);

	public int getEid(Summary summary);

	public List<MemAndExp> getSummaryInfoByPage(MemAndExpDTO memAndExpDTO);

	public List<LookSummary> getSummarysByMidByPage(SummaryDTO summaryDTO);

	public int checkHaveSumByNum(String cnum);

	public void addSummaryVisit(SummaryVisit summaryVisit);

	public int checkSummaryVisit(SummaryVisit summaryVisit);

	public List<SummaryVisit> getSummaryVisit(int sid);

	public void delSummaryVisitBySid(int sid);

	public Summary getCommentById(int id);

	public int updateComment(Summary summary);

	public List<Summary> getSummarys(SummaryDTO summaryDTO);

	public List<LookSummary> getExperienceSummarys(
			String name);
}

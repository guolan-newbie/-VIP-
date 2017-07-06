package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import dto.MemAndExpDTO;
import dto.SummaryDTO;
import entity.LookSummary;
import entity.MemAndExp;
import entity.Summary;
import entity.SummaryVisit;
import mapper.SummaryMapper;
import tools.Result;

@Service
public class SummaryDAO {
	@Autowired
	SummaryMapper summaryMapper;

	public int add(Summary summary) {
		return summaryMapper.add(summary);
	}

	public int approveSumarry(Summary summary) {
		return summaryMapper.approveSumarry(summary);
	}

	public int updateSummary(Summary summary) {
		return summaryMapper.updateSummary(summary);
	}

	public int updateRemind(int id) {
		return summaryMapper.updateRemind(id);
	}

	public int deleteRemind(int id) {
		return summaryMapper.deleteRemind(id);
	}

	public int update1Summary(Summary summary) {
		return summaryMapper.update1Summary(summary);
	}

	public List<Summary> getgetSummaryAll(String week) {
		return summaryMapper.getSummaryAll(week);
	}

	public Summary getSumById(int id) {
		return summaryMapper.getSumById(id);
	}

	public int getMemId(int id) {
		return summaryMapper.getMemId(id);
	}

	public int getRemind(int id) {
		return summaryMapper.getRemind(id);
	}

	public int addTitle(Summary summary) {
		return summaryMapper.addTitle(summary);
	}

	public Summary getComment(int pid) {
		return summaryMapper.getComment(pid);
	}

	public int addComment(Summary summary) {
		return summaryMapper.addComment(summary);
	}

	public Summary getContent(Summary summary) {
		return summaryMapper.getContent(summary);
	}

	public int isChePid(int id) {
		return summaryMapper.isChePid(id);
	}

	public int isApprove(int id) {
		return summaryMapper.isApprove(id);
	}

	public int getAid(Summary summary) {
		return summaryMapper.getAid(summary);
	}

	public int getExpId(int id) {
		return summaryMapper.getExpId(id);
	}

	public int getMId(int id) {
		return summaryMapper.getMId(id);
	}

	public String checkIsRepeatByTit(Summary summary) {
		return summaryMapper.checkIsRepeatByTit(summary);
	}

	public Summary getNewestComment(int pid) {
		return summaryMapper.getNewestComment(pid);
	}

	public int checkUserIsWrite(int mid) {
		return summaryMapper.checkUserIsWrite(mid);
	}

	public Summary getContent2(Summary summary) {
		return summaryMapper.getContent2(summary);
	}

	public int JudgeMemIsModify(Summary summary) {
		return summaryMapper.JudgeMemIsModify(summary);
	}

	public List<Summary> getSummaryByWeek(String week) {
		return summaryMapper.getSummaryByWeek(week);
	}

	public List<LookSummary> getSummarysByPage(SummaryDTO summaryDTO) {
		return summaryMapper.getSummarysByPage(summaryDTO);
	}

	public List<LookSummary> getSummarysByNameWithPage(SummaryDTO summaryDTO) {
		return summaryMapper.getSummarysByNameWithPage(summaryDTO);
	}

	public Summary getCurrentSummary(Summary summary) {
		return summaryMapper.getCurrentSummary(summary);
	}

	public void delSum(int id) {
		summaryMapper.delSum(id);
		summaryMapper.delCom(id);
		summaryMapper.delSummaryVisitBySid(id);
		return;
	}

	public void delCom(int id) {
		summaryMapper.delSum(id);
		return;
	}

	public int getEid(Summary summary) {
		return summaryMapper.getEid(summary);
	}

	public List<MemAndExp> getSummaryInfoByPage(MemAndExpDTO memAndExpDTO) {
		return summaryMapper.getSummaryInfoByPage(memAndExpDTO);
	}

	public List<LookSummary> getSummarysByMid(SummaryDTO summaryDTO) {
		return summaryMapper.getSummarysByMidByPage(summaryDTO);
	}

	public int checkHaveSumByNum(String cnum) {
		return summaryMapper.checkHaveSumByNum(cnum);
	}

	public void addSummaryVisit(SummaryVisit summaryVisit) {
		summaryMapper.addSummaryVisit(summaryVisit);
		return;
	}

	public int checkSummaryVisit(SummaryVisit summaryVisit) {
		return summaryMapper.checkSummaryVisit(summaryVisit);
	}

	public List<SummaryVisit> getSummaryVisit(int sid) {
		return summaryMapper.getSummaryVisit(sid);
	}

	public Summary getCommentById(int id) {
		return summaryMapper.getCommentById(id);
	}

	public int updateComment(Summary summary) {
		return summaryMapper.updateComment(summary);
	}
	public Result getSummarys(SummaryDTO summaryDTO,int page,int rows)
	{
		PageHelper.startPage(page, rows);
		List<Summary>list=summaryMapper.getSummarys(summaryDTO);
		long total = new PageInfo<>(list).getTotal();
		return Result.ok(list, page, (int)((total % rows ==0 ) ? total/rows : total/rows +1));
	}
	public Result getExperienceSummarys(String name,int page,int rows) {
		PageHelper.startPage(page, rows);
		List<LookSummary> list  = summaryMapper.getExperienceSummarys(name);
		PageInfo<LookSummary> pageInfo = new PageInfo<>(list);
		long total=pageInfo.getTotal();
		return Result.ok(list, pageInfo.getPageNum(), pageInfo.getPages(),total);
	}

}

package controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.DailyLogDAO;
import entity.Admin;
import entity.DailyLog;
import entity.StatusCode;
import tools.Authentication;
import tools.JsonUtils;
import tools.MemberResult;
import tools.Result;
import tools.VerifyIdentity;

@Controller
@RequestMapping("/dailylog")
public class DailyLogController {
	@Autowired
	private DailyLogDAO dailyLogDAO;

	@ResponseBody
	@RequestMapping("/getDailyLog")
	public Result getDailyLog(DailyLog dailyLog, @RequestParam(defaultValue = "1") Integer page,
			@RequestParam(defaultValue = "10") Integer rows,HttpSession session) {
		System.out.println(dailyLog.getTime());
		if(VerifyIdentity.verifyAdmin(session)==null)
		{
			return Result.build(201, "您不是管理员！");
		}
		return dailyLogDAO.getDailyLog(dailyLog, page, rows);
	}
	@ResponseBody
	@RequestMapping("/addDailyLog")
	public Result addDailyLog(DailyLog dailyLog, HttpSession session) {
		if(VerifyIdentity.verifyAdmin(session)==null)
		{
			return Result.build(201, "您不是管理员！");
		}
		Admin admin = (Admin) session.getAttribute("ADMIN");
		dailyLog.setName(admin.getRealname());
		dailyLog.setCreated(new Date());
		if (dailyLogDAO.checkDailyLog(dailyLog)) {
			return Result.build(301, "数据已存在!");
		}
		dailyLogDAO.addDailyLog(dailyLog);
		return Result.ok();
	}

	@ResponseBody
	@RequestMapping("/getDailyLogById")
	public String getDailyLogById(int id) {
		return JsonUtils.objectToJson(dailyLogDAO.getDailyLogById(id));
	}

	@ResponseBody
	@RequestMapping("/modifyDailyLog")
	public Result modifyDailyLog(DailyLog dailyLog, HttpSession session) {
		if(VerifyIdentity.verifyAdmin(session)==null)
		{
			return Result.build(201, "您不是管理员！");
		}
		Admin admin = (Admin) session.getAttribute("ADMIN");
		if (!dailyLog.getName().equals(admin.getRealname())) {
			return Result.build(204, "你的权限不足，只有本人才能修改工作日志！");
		}
		if (dailyLog.getTime().after(new Date())) {
			return Result.build(302, "日期不能大于今天！");
		}
		List<DailyLog> list = dailyLogDAO.getDailyLogTimeByName(dailyLog);
		for (DailyLog dailyLogs : list) {
			if (dailyLogs.getTime().equals(dailyLog.getTime())) {
				return Result.build(303, "日期与之前工作日志日期重复！");
			}
		}
		dailyLogDAO.modifyDailyLog(dailyLog);
		return Result.ok();
	}

	@ResponseBody
	@RequestMapping("/deleteDailyLog")
	public Result deleteDailyLog(DailyLog dailyLog, HttpSession session) {
		if(VerifyIdentity.verifyAdmin(session)==null)
		{
			return Result.build(201, "您不是管理员！");
		}
		Admin admin = (Admin) session.getAttribute("ADMIN");
		if (!"1".equals(admin.getAuthority()) & !dailyLog.getName().equals(admin.getRealname())) {
			return Result.build(204, "你的权限不足，只有超级管理员才能删除他人工作日志！");
		}
		dailyLogDAO.deleteDailyLog(dailyLog.getId());
		return Result.ok();
	}

	@ResponseBody
	@RequestMapping("/checkAuthority")
	public  Result checkAuthority(String name,HttpSession session)
	{
		if(VerifyIdentity.verifyAdmin(session)==null)
		{
			return Result.build(201, "您不是管理员！");
		}
		Admin admin = (Admin) session.getAttribute("ADMIN");
		if (!name.equals(admin.getRealname())) {
			if("1".equals(admin.getAuthority()))
			{
				return Result.build(205, "超级管理员");
			}
			return Result.build(204, "你的权限不足，只有本人才能修改工作日志！");
		}
		return Result.ok();
	}

}

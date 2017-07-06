package mapper;

import java.util.List;
import java.util.Map;

import dto.NoticeDTO;
import entity.Notice;

public interface NoticeMapper {
	public int add(Notice notice);
	public int update(Notice notice);
	public List<Notice> getall(Map<String, Object> map);
	public List<Notice> getNoticeByPage(NoticeDTO noticeDTO);
	public List<Notice> get(Notice notice);
	public void updatePublish(Notice notice);
	public void updateSettop(Notice notice);
	public Map<String, Object> getLastest();
	public String getnoticeTime(int uid);
	public String getnoticeExperienceTime(int eid);
	public void updatenoticeTime(Map<String,Object> map);
	public void updatenoticeExperienceTime(Map<String,Object> map);
	public List<Map<String, Object>> getNotices();
	public void delNotice(int id);
	public List<Notice> getAllByPage(NoticeDTO noticeDTO);
}

package dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.NoticeDTO;
import entity.Notice;
import mapper.NoticeMapper;

@Service
public class NoticeDAO {
	@Autowired
	private NoticeMapper noticeMapper;

	public int add(Notice notice) {
		return noticeMapper.add(notice);
	}

	public int update(Notice notice) {
		return noticeMapper.update(notice);
	}

	public List<Notice> getall(Map<String, Object> map) {
		return noticeMapper.getall(map);
	}

	public List<Notice> getNoticeByPage(NoticeDTO noticeDTO) {
		return noticeMapper.getNoticeByPage(noticeDTO);
	}

	public List<Notice> get(Notice notice) {
		return noticeMapper.get(notice);
	}

	public void updatePublish(Notice notice) {
		noticeMapper.updatePublish(notice);
	}

	public void updateSettop(Notice notice) {
		noticeMapper.updateSettop(notice);
	}

	public Map<String, Object> getLastest() {
		return noticeMapper.getLastest();
	}

	public String getnoticeTime(int uid) {
		return noticeMapper.getnoticeTime(uid);
	}

	public String getnoticeExperienceTime(int eid) {
		return noticeMapper.getnoticeExperienceTime(eid);
	}

	public void updatenoticeTime(Map<String, Object> map) {
		noticeMapper.updatenoticeTime(map);
	}

	public void updatenoticeExperienceTime(Map<String, Object> map) {
		noticeMapper.updatenoticeExperienceTime(map);
	}

	public List<Map<String, Object>> getNotices() {
		return noticeMapper.getNotices();
	}

	public void delNotice(int id) {
		noticeMapper.delNotice(id);
	}

	public List<Notice> getAllByPage(NoticeDTO noticeDTO) {
		List<Notice> list = noticeMapper.getAllByPage(noticeDTO);
		return list;
	}

}

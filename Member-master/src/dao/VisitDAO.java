package dao;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.VisitorDTO;
import entity.History;
import entity.Visitor;
import mapper.VisitMapper;

@Service
public class VisitDAO {
	@Autowired
	VisitMapper visitMapper;

	public int addvisit(Visitor visitor) throws IOException {
		return visitMapper.addvisit(visitor);
	}

	// 返回数据库中的数据
	public List<Visitor> getAll() {

		return visitMapper.getAll();
	}

	public List<Visitor> getVisitorByPage(VisitorDTO visitorDTO) {
		return visitMapper.getVisitorByPage(visitorDTO);
	}

	public List<History> get(int vid) {

		return visitMapper.get(vid);
	}

	// 返回数据库中的总个数
	public int getsize() {
		return visitMapper.getsize();
	}

	public int addhistory(History history) {
		return visitMapper.addhistory(history);
	}

	public void update(Visitor visitors) {
		visitMapper.update(visitors);
	}

	public Visitor getOne(Visitor visitor) {
		return visitMapper.getOne(visitor);
	}
}

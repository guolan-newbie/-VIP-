package mapper;



import java.util.List;

import dto.VisitorDTO;
import entity.History;
import entity.Visitor;
public interface VisitMapper{
	public int addvisit(Visitor visitor);
	public int addhistory(History history);
	public List<Visitor> getAll();
	public List<Visitor> getVisitorByPage(VisitorDTO visitorDTO);
	public List<History> get(int vid);
	public int getsize();
	public void update(Visitor visitors);
	public Visitor getOne(Visitor visitor);
}

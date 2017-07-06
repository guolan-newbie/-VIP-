package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import dto.ClueDTO;
import entity.Clue;

public interface ClueMapper {
	public List<Clue> getClueByPage(ClueDTO clueDTO);

	public Clue getClueById(int id);

	public List<Clue> getClueByAid(int id);

	public int checkExists(String num);

	public void add(Clue clue);

	public void update(Clue clue);

	public String getSaltByNum(String num);

	public Clue isValid(Clue clue);

	public int getMidById(int id);

	public int getUidById(int id);

	public void delete(int id);

	public String getNum();

	public List<Clue> getClues(@Param("type") int type, @Param("aid") int aid, @Param("qq") String qq);

	public List<Clue> getQqSearch(String qq);

	public boolean checkqq(String qq);

}

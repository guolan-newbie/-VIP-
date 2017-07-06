package mapper;

import java.util.List;

import dto.UserDTO;
import entity.QueryType;
import entity.User;

public interface UserMapper {
	public List<User> getValid(User user);
	public List<User> checkValid(User user);
	public int add(User user);
	public void update(User user);
	public void updatefinish(User user);
	public void updateimage(User user);
	public List<User> getUser(QueryType queryType);	
	public List<User> getExist(User user);
	public String getSalt(User user);
	public List<User> getInfo();
	public List<User> getInfoByPage(UserDTO userDTO);
	public void deleteById(int id);
	public String getName(User user);
	public List<User> getUserByPage(UserDTO userDTO);
	public User getLastOne();
	public User getUserById(int id);
	public User getUserByName(String name);
	public List<User> getMemberInfo(User user);
}

package mapper;
import java.util.List;

import entity.UserInfo;

public interface UserInfoMapper {
	public void add(UserInfo userInfo);
	public void update(UserInfo userInfo);
	public List<UserInfo> get(UserInfo userInfo);
	public void deleteByUid(int id);
	public UserInfo getUserInfoByUid(int id);
}

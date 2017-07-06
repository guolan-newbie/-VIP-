package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import entity.UserInfo;
import mapper.UserInfoMapper;

@Service
public class UserInfoDAO {
	@Autowired
	private UserInfoMapper userInfoMapper;

	public void add(UserInfo userInfo) {
		userInfoMapper.add(userInfo);
	}

	public void update(UserInfo userInfo) {
		userInfoMapper.update(userInfo);
	}

	public List<UserInfo> get(UserInfo userInfo) {
		return userInfoMapper.get(userInfo);
	}

	public void deleteByUid(int id) {
		userInfoMapper.deleteByUid(id);
	}

	public UserInfo getUserInfoByUid(int id) {
		return userInfoMapper.getUserInfoByUid(id);
	}
}

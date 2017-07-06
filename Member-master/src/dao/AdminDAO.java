package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import entity.Admin;
import mapper.AdminMapper;

@Service
public class AdminDAO {
	@Autowired
	AdminMapper adminMapper;

	public List<Admin> getValid(Admin admin) {
		return adminMapper.getValid(admin);
	}

	public int add(Admin admin) {
		return adminMapper.add(admin);
	}

	public String getSalt(Admin admin) {
		return adminMapper.getSalt(admin);
	}

	public String getAuthority(Admin admin) {
		return adminMapper.getAuthority(admin);
	}

	public Admin getAmById(int id) {
		return adminMapper.getAmById(id);
	}

	public List<Admin> getAll() {
		return adminMapper.getAll();
	}

	public int modifyPwd(Admin admin) {
		return adminMapper.modifyPwd(admin);
	}

	public List<Admin> getAllAdmin(Admin admin) {
		return adminMapper.getAllAdmin(admin);
	}

	public int modifyAuthority(Admin admin) {
		return adminMapper.modifyAuthority(admin);
	}

	public String getLoginAuthority(String name) {
		return adminMapper.getLoginAuthority(name);
	}

	public List<Admin> getWorkAdmin() {
		return adminMapper.getWorkAdmin();
	}
}

package mapper;

import java.util.List;


import entity.Admin;
import entity.Summary;

public interface AdminMapper {
	public List<Admin> getValid(Admin admin);
	public int add(Admin admin);
	public String getSalt(Admin admin);
	public String getAuthority(Admin admin);
	public Admin getAmById(int id);
	public List<Admin> getAll();
	public int modifyPwd(Admin admin);
	public List<Admin> getAllAdmin(Admin admin);
	public int modifyAuthority(Admin admin);
	public String getLoginAuthority(String name);
	public List<Admin> getWorkAdmin();
}

package mapper;

import java.util.List;

import dto.PictureDTO;
import entity.Picture;
import entity.User;


public interface PictureMapper {
	public void addPicture(Picture picture);
	public void modifyPicture(Picture picture);
	public void modifykey(Picture picture);
	public List<Picture> getPicture(int uid);
	public Picture getOne(int id);
	public Picture getCover(Picture picture);
	public List<Picture> getFlag();
	public List<Picture> getFlagByPage(PictureDTO pictureDTO);
	public List<Picture> getUserPicture(int uid);
	public List<Picture> getUserFlagPicture(int uid);
	public List<Picture> getUserPictureByPage(PictureDTO pictureDTO);
	public void flag(Picture picture);
	public int count(int uid);
	public void delete(int id);
	public Picture getpic(int id);
	public int allcount(int uid);
	public List<User> getAllUserCoverByPage(PictureDTO pictureDTO);
	public List<User> getAllFlagUserCoverByPage(PictureDTO pictureDTO);
	public List<User> getAllUserCoverInThisSchoolByPage(PictureDTO pictureDTO);
	public void deleteUserCover(int uid);
	public void deleteUserFlagCover(int uid);
	public void deleteCheckedUserCover(int uid);
	public void addAdminCover(Picture picture);
	public void modifyAdminCover(Picture picture);
}

package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.PictureDTO;
import entity.Picture;
import entity.User;
import mapper.PictureMapper;

@Service
public class PictureDAO {
	@Autowired
	PictureMapper pictureMapper;

	public void addPicture(Picture picture) {
		pictureMapper.addPicture(picture);

	}

	public void modifyPicture(Picture picture) {
		pictureMapper.modifyPicture(picture);
	}

	public List<Picture> getPicture(int uid) {
		return pictureMapper.getPicture(uid);
	}

	public Picture getOne(int id) {
		return pictureMapper.getOne(id);
	}

	public Picture getCover(Picture picture) {
		return pictureMapper.getCover(picture);
	}

	public List<Picture> getFlag() {
		return pictureMapper.getFlag();
	}

	public List<Picture> getFlagByPage(PictureDTO pictureDTO) {
		return pictureMapper.getFlagByPage(pictureDTO);
	}

	public List<Picture> getUserPicture(int uid) {
		return pictureMapper.getUserPicture(uid);
	}

	public boolean getUserFlagPicture(int uid) {
		return pictureMapper.getUserFlagPicture(uid).isEmpty() ? true : false;
	}

	public List<Picture> getUserPictureByPage(PictureDTO pictureDTO) {
		return pictureMapper.getUserPictureByPage(pictureDTO);
	}

	public void flag(Picture picture) {
		pictureMapper.modifyPicture(picture);
	}

	public void modifykey(Picture picture) {
		pictureMapper.modifykey(picture);
	}

	public int count(int uid) {
		return pictureMapper.count(uid);
	}

	public int allcount(int uid) {
		return pictureMapper.allcount(uid);
	}

	public void delete(int id) {
		pictureMapper.delete(id);
	}

	public Picture getpic(int id) {
		return pictureMapper.getpic(id);
	}

	public List<User> getAllUserCoverByPage(PictureDTO pictureDTO) {
		return pictureMapper.getAllUserCoverByPage(pictureDTO);
	}

	public List<User> getAllFlagUserCoverByPage(PictureDTO pictureDTO) {
		return pictureMapper.getAllFlagUserCoverByPage(pictureDTO);
	}

	public List<User> getAllUserCoverInThisSchoolByPage(PictureDTO pictureDTO) {
		return pictureMapper.getAllUserCoverInThisSchoolByPage(pictureDTO);
	}

	public void deleteUserCover(int uid) {
		pictureMapper.deleteUserCover(uid);
	}

	public void deleteUserFlagCover(int uid) {
		pictureMapper.deleteUserFlagCover(uid);
	}

	public void addAdminCover(Picture picture) {
		pictureMapper.addAdminCover(picture);
	}

	public void modifyAdminCover(Picture picture) {
		pictureMapper.modifyAdminCover(picture);
	}

	public void deleteCheckedUserCover(int uid) {
		pictureMapper.deleteCheckedUserCover(uid);
	}
}

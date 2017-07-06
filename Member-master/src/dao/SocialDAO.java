package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.SocialDTO;
import entity.Social;
import mapper.SocialMapper;

@Service
public class SocialDAO {
	// spring注入
	@Autowired
	SocialMapper sociaMapper;

	// controller层传入两条sql语句 放入map中传到mapper执行
	public List<Social> getSocialsPage(SocialDTO socialDTO) {
		List<Social> socials = sociaMapper.getSocialsByPage(socialDTO);
		return socials;

	}
}

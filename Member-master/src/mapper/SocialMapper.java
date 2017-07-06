package mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dto.SocialDTO;
import entity.Social;
public interface SocialMapper {
	
	public List<Social> getSocialsByPage(SocialDTO socialDTO);

}

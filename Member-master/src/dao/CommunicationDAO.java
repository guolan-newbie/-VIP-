package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.CommunicationDTO;
import entity.Communication;
import mapper.CommunicationMapper;

@Service
public class CommunicationDAO {
	@Autowired
	CommunicationMapper communicationMapper;

	public void add(Communication communication) {
		communicationMapper.add(communication);
	}

	public List<Communication> getCommunicationByCid(int cid) {
		return communicationMapper.getCommunicationByCid(cid);
	}

	public List<Communication> getCommunicationByEid(int eid) {
		return communicationMapper.getCommunicationByEid(eid);
	}

	public List<Communication> getCommunicationByMid(int mid) {
		return communicationMapper.getCommunicationByMid(mid);
	}

	public List<Communication> getAllCommunication() {
		return communicationMapper.getAllCommunication();
	}

	// 沟通分页
	public List<Communication> getCommunicationInfoByPage(CommunicationDTO communicationDTO) {
		return communicationMapper.getCommunicationInfoByPage(communicationDTO);

	}
	
	public void deleteClueCommunication(int cid) {
		communicationMapper.deleteClueCommunication(cid);
	}

}

package mapper;


import java.util.List;

import dto.CommunicationDTO;
import entity.Communication;

public interface CommunicationMapper{
	public void add(Communication communication);
	public List<Communication> getCommunicationByEid(int eid);
	public List<Communication> getCommunicationByCid(int cid);
	public List<Communication> getCommunicationByMid(int mid);
	public List<Communication> getAllCommunication();
	public void deleteClueCommunication(int cid);
	public void deleteById(int id);
	//沟通分页
	public List<Communication> getCommunicationInfoByPage(CommunicationDTO communicationDTO);
}
package tools;
import java.util.ArrayList;
import java.util.List;
public class Paging<T> {
	public List<T> paging(List<T> list,int pageSize,int page){
		List<T> newlist=new ArrayList<T>();
		int min=page*pageSize>list.size()?list.size():page*pageSize;
		for(int i=(page-1)*pageSize;i<min;i++){
			newlist.add(list.get(i));
		}
		return newlist;
	}
	public int pageCount(List<T>list,int pageSize){
		int pageCount=list.size() / pageSize;
		if(list.size() % pageSize>0){
			pageCount++;
		}
		return pageCount;
	}
	public static int pageCount(int listSize,int pageSize){
		int pageCount=listSize / pageSize;
		if(listSize % pageSize>0){
			pageCount++;
		}
		return pageCount;
	}
}


package mapper;

import java.util.ArrayList;

import entity.Book;

public interface BookMapper {
	ArrayList<Book> find(String pattern);
}

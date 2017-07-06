package dao;

import java.io.IOException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import entity.Book;
import mapper.BookMapper;

@Service
public class BookDAO {
	@Autowired
	BookMapper bookMapper;

	public ArrayList<Book> find(String pattern) throws IOException {
		ArrayList<Book> list = bookMapper.find(pattern);
		return list;
	}
}

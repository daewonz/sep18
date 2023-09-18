package com.ehr.web.board;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardService {
@Autowired
private BoardDAO boardDAO;

public int acount() {
	// TODO Auto-generated method stub
	return boardDAO.acount();
}

public List<Map<String, Object>> alist(Map<String, Integer> map) {
	// TODO Auto-generated method stub
	return boardDAO.alist(map);
}

public void awrite(Map<String, Object> map) {
	boardDAO.awrite(map);
	
}

public Map<String, Object> adetail(int num) {
	// TODO Auto-generated method stub
	return boardDAO.adetail(num);
}

public void areadUp(int abno) {
	boardDAO.areadUp(abno);
	
}

public void adel(int abno) {
	boardDAO.adel(abno);
	
}

public void adetailUp(Map<String, Object> map) {
	// TODO Auto-generated method stub
	boardDAO.adetailUp(map);
}

public int acheckEno(Map<String, Object> map) {
	return boardDAO.acheckEno(map);
	
}

public List<Map<String, Object>> commentList(int abno) {
	// TODO Auto-generated method stub
	return boardDAO.commentList(abno);
}

public void comment(Map<String, Object> map) {
	boardDAO.comment(map);
	
}

public int commentCount(int abno) {
	// TODO Auto-generated method stub
	return boardDAO.commentCount(abno);
}
}

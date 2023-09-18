package com.ehr.web.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardDAO {

	int acount();

	List<Map<String, Object>> alist(Map<String, Integer> map);

	void awrite(Map<String, Object> map);

	Map<String, Object> adetail(int num);

	void areadUp(int abno);

	void adel(int abno);

	void adetailUp(Map<String, Object> map);

	int acheckEno(Map<String, Object> map);

	List<Map<String, Object>> commentList(int abno);

	void comment(Map<String, Object> map);

	int commentCount(int abno);

}

package com.ehr.web.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ehr.web.attend.Paging;

@Controller
public class BoardController {
@Autowired
private BoardService boardService;


@GetMapping("/sampleboard")
public String sampleboard() {
	return "sampleboard";
}

@GetMapping("/annonyboard")
public String annonyBoard(@RequestParam(value = "page", required = false, defaultValue = "1") int page,
		Model model) {
	int pageSize = 10;
	int totalCnt = boardService.acount();
	model.addAttribute("totalCnt", totalCnt);

	Paging paging = new Paging(totalCnt, page, pageSize);

	if (page < 0 || page > paging.getTotalPage())
		page = 1;
	if (pageSize < 0 || pageSize > 50)
		pageSize = 10;

	
	
	 int pageCount = totalCnt /pageSize;
	 //System.out.println("첫 페이지 카운트는" + pageCount);
	 if(totalCnt % pageSize != 0) {
		 pageCount = pageCount+1;
		 }
	 
	 //System.out.println("결과 페이지 카운트는 : " + pageCount);

		Map<String, Integer> map = new HashMap<String, Integer>();
	// .put("pageIndex", pagingDTO.getPageIndex());
	map.put("pageSize", pageSize);
	map.put("offset", (page - 1) * pageSize);

	List<Map<String, Object>> list = boardService.alist(map);
	
	//System.out.println("리스트의 값은 : " + list);
	
	
	//System.out.println(count);
//	model.addAttribute("pageCount", pageCount);
	model.addAttribute("list", list);
	model.addAttribute("ph", paging);
	return "annonyboard";
}

//익명게시판 글쓴이 만들어주는 메소드
//2023-09-18 수정
public String annonywriter() {
	String[] arr01 = { "수진", "화진", "대원", "재윤", "지선", "승리" };
	String[] arr02 = { "집가는", "공부하는", "자는", "코딩하는", "사과게임하는", "일기쓰는", "커피마시는", "발표하는", "숨쉬는", "밥먹는", "운동하는", "병원가는",
			"지하철타는", "버스타는", "점프하는", "달리는", "쉬고있는","과자먹는","배고픈", "지루한", "부탁하는","분주한"};
	int random1 = (int) (Math.random() * arr01.length);
	int random2 = (int) (Math.random() * arr02.length);
	String nickName = arr02[random2] + " " + arr01[random1];
	return nickName;
}

//2023-09-18 수정
@GetMapping("/annonyWrite")
public String annonywrite(Model model, HttpSession session) {
	//System.out.println(nickName);
	if(session.getAttribute("eno") != null) {
		
		model.addAttribute("nickName", annonywriter());
		System.out.println();
		return "/annonywrite";
	}else {
		return "/";
	}
}

@PostMapping("/annonyWrite")
public String annonywrite(@RequestParam Map<String, Object> map) {

	System.out.println(map);
	boardService.awrite(map);
	return "redirect:/annonyboard";
}

//2023-09-18 수정(commentList추가)
@GetMapping("/annonyDetail")
public String annonyDetail(@RequestParam(value = "num", required = false, defaultValue = "1") int num, Model model) {
	Map<String, Object> detail = boardService.adetail(num);
	int abno = Integer.parseInt(String.valueOf(detail.get("abno")));
	boardService.areadUp(abno);
	//System.out.println(detail);
	// {abcontent=<p>FSADFSAD</p>, abdate=2023-09-16 11:09:38.0, rowNum=39, abread=14, abwrite=점프하는 재윤, eno=44, abtitle=FDAS, abdel=1, abno=410}
	int count = boardService.commentCount(abno);
	List<Map<String, Object>> commentList = boardService.commentList(abno);
	// [{c_date=2023-09-18 10:37:56.0, c_secret=0, c_write=부탁하는 무지1, cno=1, cdel=0, eno=13, abno=410, c_comment=ㅋㅋㅎㅇ}]
	model.addAttribute("count", count);
	model.addAttribute("commentList", commentList);
	model.addAttribute("detail", detail);
	
	
	model.addAttribute("commentWriter", annonywriter());
	return "annonydetail";
}
@GetMapping("/adetailDel")
public String adetailDel(@RequestParam(value = "abno") int abno, HttpSession session) {
	Map<String, Object> map = new HashMap<String, Object>();
	map.put("abno", abno);
	map.put("eno", session.getAttribute("eno"));
	int count = boardService.acheckEno(map);
	if(count == 1) {
		
		System.out.println("abno의 값은 : " + abno);
		boardService.adel(abno);
		return "redirect:/annonyboard";
	}else {
		return "redirect:/annonyboard";
	}
	
}
@GetMapping("/adetailUp")
public String adetailUp(@RequestParam(value = "num") int num, Model model, HttpSession session) {
	
	Map<String, Object> detail =  boardService.adetail(num);
	detail.put("eno", session.getAttribute("eno"));
	System.out.println("수정할 값은 : "+ detail);
	int count = boardService.acheckEno(detail);
	if(count == 1) {
		System.out.println("카운트의 값은 : " + count);
		model.addAttribute("detail", detail);
		return "adetailup";
		
	}else {
		return "redirect:/annonyboard";
	}
	
}
@PostMapping("/adetailUp")
public String adetailUp(@RequestParam Map<String, Object> map) {
	System.out.println(map);
	boardService.adetailUp(map);
	return "redirect:/annonyboard";
}
//2023-09-18 추가
@PostMapping("/comment")
public String comment(@RequestParam Map<String, Object> map, HttpSession session) {
	if(session.getAttribute("eno") != null) {
		
		if(map.get("secret") == null) {
			map.put("secret", 1);
		}
		//System.out.println("eno의 값 : " + session.getAttribute("eno"));
		//System.out.println("detailEno의 값 : " + map.get("detailEno"));
		//System.out.println(String.valueOf(session.getAttribute("eno")).equals(String.valueOf(map.get("detailEno"))));
		if(String.valueOf(session.getAttribute("eno")).equals(String.valueOf(map.get("detailEno")))) {
			//System.out.println("작성자와 게시판 글쓴이가 같습니다.");
			map.put("c_self", 0);
		}
		System.out.println("디테일 eno의 값은 : " + map.get("detailEno"));
		//게시판의 eno와 세션의 eno가 같으면 (작성자) 추가
		
		/*
		 * if( map.get("eno").equals(map.get("detailEno"))) {
		 * System.out.println("값이 같구나"); map.put("writer", map.get("writer") +
		 * " (작성자) "); }
		 */
		System.out.println("댓글에 들어오는 값은 : " + map);
		boardService.comment(map);
		
		return "redirect:/annonyDetail?num="+map.get("rowNum");
	}else {
		return "/";
	}
	
	
}



}//컨트롤러 끝

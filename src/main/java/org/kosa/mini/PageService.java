package org.kosa.mini;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosa.mini.page.PageResponseVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PageService {
	
	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private BoardDAO boardDAO;
	
	 public static final int NOTICE_CNO = 1;  // 공지사항 c_no
	 public static final int FREEBOARD_CNO = 2;  // 자유게시판 c_no
	
	//검색+페이징 멤버리스트출력
	public PageResponseVO<Member> memberList(String searchValue, int pageNo, int size) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", (pageNo-1) * size + 1);
		map.put("end", pageNo * size);
		map.put("searchValue", searchValue);
		
		return new PageResponseVO<Member> (searchValue, pageNo
				, memberDAO.memberList(map)
				, memberDAO.getTotalCount(map)
				, size); 
	}

	//아이디로 멤버 조회
	public Member getMember(String userid) {
		return memberDAO.getMember(userid);
	}

	public boolean register(Member member) {
		return memberDAO.register(member);
	}

	public Member login(String userid, String pw) {
		
		//아이디가 없을때
		Member member = memberDAO.getMember(userid);
		if (member == null) {
			return null;
		}
		
		boolean result = member.getPw().equals(pw);
		if (result == false) {			
			memberDAO.setFailLogCnt(userid); //로그인 실패 횟수 증가		
			return null;
		}
		
		memberDAO.resetFailCnt(member.getUserid()); //로그인 성공 시 0으로 설정

		return member;
	}

	public Member update(Member member) {
		Member memberDB = memberDAO.getMember(member.getUserid());
		if (memberDB == null) {
			return null;
		}
		//DB 데이터 수정작업
		memberDAO.update(member);
		return member;
	}

	public void delete(String userid) {
		
		Member member = memberDAO.getMember(userid);

		if (member == null) {
			return;
		}
		memberDAO.delete(userid);

	}

	public void unlock(String userid) {
		
		Member member = memberDAO.getMember(userid);

		if (member == null) {
			return;
		}
		
		memberDAO.unlock(userid);
		
	}
	
	public List<Board> notiecBoard() {

		List<Board> notiecBoard = boardDAO.categoryBoard(NOTICE_CNO);
		
		return notiecBoard; 
	}
	
	public List<Board> freeBoard() {
		
		List<Board> freeBoard = boardDAO.categoryBoard(FREEBOARD_CNO);
		
		return freeBoard; 	
	}
	
	//검색+페이징 자유게시판출력
	public PageResponseVO<Board> freeBoard(String searchValue, int pageNo, int size) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", (pageNo-1) * size + 1);
		map.put("end", pageNo * size);
		map.put("searchValue", searchValue);
		map.put("c_no", FREEBOARD_CNO);
		
		return new PageResponseVO<Board> (searchValue, pageNo
				, boardDAO.boardList(map)
				, boardDAO.getTotalCount(map)
				, size); 
	}

	
	//검색+페이징 자유게시판출력
	public PageResponseVO<Board> notiecBoard(String searchValue, int pageNo, int size) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", (pageNo-1) * size + 1);
		map.put("end", pageNo * size);
		map.put("searchValue", searchValue);
		map.put("c_no", NOTICE_CNO);
		
		return new PageResponseVO<Board> (searchValue, pageNo
				, boardDAO.boardList(map)
				, boardDAO.getTotalCount(map)
				, size); 
	}

	public boolean write(Board board) {
		return boardDAO.write(board);
	}

	public Board getBoard(int post_no) {
		return boardDAO.getBoard(post_no);
	}

	//포스트번호로 비밀번호 체크
	public boolean checkPassword(int post_no, String post_pw) {
		
		String realPw = boardDAO.getPassword(post_no);
	    return realPw != null && realPw.equals(post_pw);
	}

	public void delete(int post_no) {
		Board board = boardDAO.getBoard(post_no);

		if (board == null) {
			return;
		}
		boardDAO.delete(post_no);

		
	}

	public void addView(int post_no) {
		
		boardDAO.addView(post_no);
	}

	public Board updateBoard(Board board) {
		Board boardDB = boardDAO.getBoard(board.getPost_no());
		
		if (boardDB == null) {
			return null;
		}
		//DB 데이터 수정작업
		boardDAO.updateBoard(board);
		return board;
	}

}

package org.kosa.mini;


import java.util.HashMap;
import java.util.Map;

import org.kosa.mini.page.PageResponseVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PageService {
	
	@Autowired
	private MemberDAO memberDAO;
//	private BoardDAO boardDAO;
	
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

}

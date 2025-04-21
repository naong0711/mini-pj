package org.kosa.mini;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberDAO {

	public Member getMember(String userid); //userid로 멤버 셀렉
	public List<Member> memberList(Map<String, Object> map); //전체 멤버 리스트
	public int getTotalCount(Map<String, Object> map); //전체건수
	public boolean register(Member member); //회원가입
	public void setFailLogCnt(String userid); //로그인 실패횟수
	public void resetFailCnt(String userid); //로그인 실패횟수 리셋

}

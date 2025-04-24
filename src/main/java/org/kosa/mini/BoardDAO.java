package org.kosa.mini;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface BoardDAO {
	
	public List<Board> categoryBoard(int c_no); //카테고리별 게시글
	public List<Board> boardList(Map<String, Object> map); //전체 멤버 리스트(페이징검색추가)
	public int getTotalCount(Map<String, Object> map); //전체건수
	public boolean write(Board board); //글쓰기
	public Board getBoard(int post_no); //게시글상세보기
	public String getPassword(int post_no); //삭제 시 패스워드 확인용
	public int delete(int post_no); //게시글 삭제
	public int addView(int post_no); //조회수 증가

}

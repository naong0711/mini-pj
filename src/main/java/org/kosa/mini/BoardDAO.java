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
	public String getPassword(int post_no);
	public int delete(int post_no);

}

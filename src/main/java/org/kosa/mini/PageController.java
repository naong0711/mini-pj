package org.kosa.mini;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.kosa.mini.util.Util;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Handles requests for the application home page.
 */
@Controller
public class PageController {

	@Autowired
	PageService pageService;

	private static final Logger logger = LoggerFactory.getLogger(PageController.class);

	// 메인
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {

		model.addAttribute("notiecBoard", pageService.notiecBoard());
		model.addAttribute("freeBoard", pageService.freeBoard());

		return "home";
	}

	// 멤버목록(관리자)
	@RequestMapping("member/list")
	public String memberList(Model model, String searchValue, String size, String pageNo) {

		model.addAttribute("pageResponse",
				pageService.memberList(searchValue, Util.parseInt(pageNo, 1), Util.parseInt(size, 10)));

		return "member/list";
	}

	// 회원가입(멤버)
	@RequestMapping("registerForm")
	public String registerForm() {

		return "member/registerForm";
	}

	// 회원가입(멤버)-아이디 검증
	@PostMapping("/isExistUserId")
	@ResponseBody
	public Map<String, Object> isExistUserId(@RequestBody Member member) {

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("existUserId", null != pageService.getMember(member.getUserid()));

		return map;
	}

	// 회원가입(멤버)-회원가입 버튼
	@PostMapping("/register")
	@ResponseBody
	public Map<String, Object> register(@RequestBody Member member) {

		Map<String, Object> map = new HashMap<String, Object>();

		boolean result = pageService.register(member);

		if (result) {
			map.put("success", true);
			map.put("message", "회원가입 성공");
		} else {
			map.put("success", false);
			map.put("message", "회원가입 도중 오류 발생");
		}

		return map;
	}

	// 로그인(멤버/관리자)
	@RequestMapping("/loginForm")
	public String loginForm() {
		return "member/loginForm";
	}

	// 로그인(멤버/관리자)-로그인 버튼
	@PostMapping("/login")
	@ResponseBody
	public Map<String, Object> login(@RequestBody Member member, HttpSession session) {

		Map<String, Object> map = new HashMap<String, Object>();

		int cnt = pageService.getMember(member.getUserid()).getFail_cnt();

		if (cnt >= 5) { // 로그인 실패 횟수가 5번 이상이면 무조건 실패
			System.out.println("ㅇㅇㅇㅇ");
			map.put("loginSecces", false);
			map.put("message", "로그인을 5회 이상 시도하여 계정이 잠겼습니다. 관리자에게 문의하세요.");
			return map;
		}

		Member result = pageService.login(member.getUserid(), member.getPw());

		if (result != null) {
			session.setAttribute("member", result);
			map.put("loginSecces", true);
		} else {
			map.put("loginSecces", false);
			map.put("message", "아이디 또는 비밀번호가 다릅니다.");

		}

		return map;
	}

	// 상세보기(멤버)
	@RequestMapping("/myPage")
	public String myPage(String userid, Model model) {

		Member member = pageService.getMember(userid);
		if (member == null) {
			return "redirect:/";
		}

		model.addAttribute("member", member);

		return "member/myPage";
	}

	// 회원정보수정폼(멤버)
	@RequestMapping("updateForm")
	public String updateForm(String userid, Model model) {

		Member member = pageService.getMember(userid);

		model.addAttribute("member", member);

		return "member/updateForm";
	}

	// 회원정보수정폼(멤버)-수정버튼
	@PostMapping("/update")
	@ResponseBody
	public Map<String, Object> update(@RequestBody Member member) {

		Map<String, Object> map = new HashMap<String, Object>();

		Member result = pageService.update(member);

		if (result != null) {
			map.put("success", true);
			map.put("message", "수정 성공");
		} else {
			map.put("success", false);
			map.put("message", "수정 도중 오류 발생");
		}

		return map;
	}

	// 회원정보수정폼(멤버)-탈퇴버튼
	@DeleteMapping("/deleteMember")
	@ResponseBody
	public Map<String, Object> deleteMember(@RequestBody Map<String, String> param) {

		String userid = param.get("userid");

		Map<String, Object> map = new HashMap<String, Object>();

		pageService.delete(userid);

		map.put("success", true);
		map.put("message", "탈퇴완료");

		return map;
	}

	// 멤버 상세보기(관리자)
	@RequestMapping("/memberDetail")
	public String memberDetail(String userid, Model model) {

		Member member = pageService.getMember(userid);
		if (member == null) {
			return "redirect:/";
		}

		model.addAttribute("member", member);

		return "member/memberDetail";
	}

	// 멤버 상세보기(관리자)-잠금해제 버튼
	@PatchMapping("/unlockMember")
	@ResponseBody
	public Map<String, Object> unlockMember(@RequestBody Map<String, String> param) {

		String userid = param.get("userid");

		Map<String, Object> map = new HashMap<String, Object>();

		pageService.unlock(userid);

		map.put("success", true);
		map.put("message", "해제완료");

		return map;
	}

	// 자유게시판
	@RequestMapping("freeBoard")
	public String freeboard(Model model, String searchValue, String size, String pageNo) {

		model.addAttribute("pageResponse",
				pageService.freeBoard(searchValue, Util.parseInt(pageNo, 1), Util.parseInt(size, 10)));

		return "board/freeList";
	}

	// 공지사항
	@RequestMapping("notiecBoard")
	public String notiecBoard(Model model, String searchValue, String size, String pageNo) {

		model.addAttribute("pageResponse",
				pageService.notiecBoard(searchValue, Util.parseInt(pageNo, 1), Util.parseInt(size, 10)));

		return "board/noticeList";
	}

	// 게시판 글쓰기
	@RequestMapping("writeForm")
	public String writeForm() {

		return "board/writeForm";
	}

	// 게시판 글쓰기(멤버)-글쓰기 버튼
	@PostMapping("/write")
	@ResponseBody
	public Map<String, Object> write(@RequestBody Board board) {

		Map<String, Object> map = new HashMap<String, Object>();

		boolean result = pageService.write(board);

		if (result) {
			map.put("success", true);
			map.put("message", "업로드 성공");
		} else {
			map.put("success", false);
			map.put("message", "업로드 도중 오류 발생");
		}

		return map;
	}

	// 상세보기(게시물)
	@RequestMapping("/detailView")
	public String detailView(int post_no, Model model) {

		Board board = pageService.getBoard(post_no);
		if (board == null) {
			return "redirect:/";
		}

		model.addAttribute("board", board);

		return "board/detailView";
	}
	
	// 상세보기(게시물)-삭제/수정 비밀번호 확인
	@PostMapping("/checkPassword")
	@ResponseBody
	public Map<String, Object> checkPassword(@RequestBody Board board) {

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("res", pageService.checkPassword(board.getPost_no(), board.getPost_pw()));

		return map;
	}
	
	// 상세보기(게시물)-게시물 삭제버튼
		@DeleteMapping("/deletePost")
		@ResponseBody
		public Map<String, Object> deletePost(@RequestBody int post_no) {

			Map<String, Object> map = new HashMap<String, Object>();

			pageService.delete(post_no);

			map.put("success", true);
			map.put("message", "삭제 완료");

			return map;
		}
		
		// 게시물수정폼(게시물)
		@RequestMapping("updatePost")
		public String updatePost(int post_no, Model model) {

			Board board = pageService.getBoard(post_no);

			model.addAttribute("board", board);

			return "board/updateBoard";
		}
	
	

}

package org.kosa.mini;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Board {
	
	private int post_no;
	private int c_no;
	private String userid;
	private String title;
	private String post_pw;
	private String content;
	private String post_at;
	private int view_cnt;
	private String is_pDel;
	private String pDel_at;
	

}

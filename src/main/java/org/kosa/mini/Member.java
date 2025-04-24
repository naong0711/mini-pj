package org.kosa.mini;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Member {
	
	private String userid;
	private String pw;
	private String name;
	private String nickname;
	private String phone;
	private int add_No;
	private String address1;
	private String address2;
	private String email;
	private String reg_at;
	private String is_del;
	private String del_at;
	private String is_lock;
	private int fail_cnt;
	private String m_role;
	

}

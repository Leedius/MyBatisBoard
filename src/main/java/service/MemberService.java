package service;

import dto.MemberDTO;

public interface MemberService {
	//회원 가입
	public int joinMember(MemberDTO memberDTO);
	
	//아이디 중복체크
	public boolean idCheck(String memId);
	
	//로그인 기능
	public MemberDTO login(MemberDTO memberDTO);
}

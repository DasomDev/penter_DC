package com.kosta.petner.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;


import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.kosta.petner.bean.Notice;
import com.kosta.petner.bean.Users;
import com.kosta.petner.dao.UsersDAO;

@Service
public class UsersServiceImpl implements UsersService {

	@Autowired
	UsersDAO usersDAO;
	
	@Autowired
	BCryptPasswordEncoder bcryptPasswordEncoder;
	
	
	@Override
	public void joinUsers(Users users) throws Exception {
		Users usersvo = usersDAO.selectId(users.getId());
		if(usersvo!=null) throw new Exception("아이디 중복");
		usersDAO.insertUsers(users);
		
	}

 
	@Override
	public boolean isDoubleId(String id) throws Exception {

		//userDAO를 통해 xml에서 가져온 id 값을 users에 담는다.
		Users users = usersDAO.selectId(id);
		if(users==null) return false;
		return true;
	}


	
	@Override
	public Users login(Users users) throws Exception{
		return usersDAO.loginById(users);
			}


	@Override
	public Users findId(Users users){
		return usersDAO.getId(users.getName(), users.getEmail());
	}

	//gmail로 ID찾기
	@Override
	public void sendEmail(Users users, String div) throws Exception {
		
		System.setProperty("https.protocols", "TLSv1,TLSv1.1,TLSv1.2");


		// Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.gmail.com"; //네이버 이용시 smtp.naver.com
		String hostSMTPid = "cdu3124@gmail.com";
		String hostSMTPpwd = "gzsytehpztjwwnib";

		// 보내는 사람 EMail, 제목, 내용
		String fromEmail = "petner@petner.com";
		String fromName = "펫트너";
		String subject = "";
		String msg = "";

		if(div.equals("findPass")) {
			subject = "펫트너 임시 비밀번호 입니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += users.getId() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
			msg += "<p>임시 비밀번호 : ";
			msg += users.getPassword() + "</p></div>";
		}

		// 받는 사람 E-Mail 주소
		String mail = users.getEmail();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSL(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(465); //네이버 이용시 587

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setTLS(true);
			email.addTo(mail, charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		} catch (Exception e) {
			System.out.println("메일발송 실패 : " + e);
		}
	}
	
	//임시비밀번호변경
		@Override
		public void findPass(HttpServletResponse response,Users users) throws Exception {
			response.setContentType("text/html;charset=utf-8");
			Users vo = usersDAO.selectId(users.getId());
			PrintWriter out = response.getWriter();
			// 가입된 아이디가 없으면
			if(usersDAO.selectId(users.getId()) == null) {
				out.print("아이디 정보가 일치하지 않습니다.");
				out.close();
			}
			// 가입된 이메일이 아니면
			else if(!users.getEmail().equals(vo.getEmail()))  {
				out.print( "이메일 정보가 일치하지 않습니다.");
				out.close();
			}else {
				
					// 임시 비밀번호 생성
					String pw = "";
					for (int i = 0; i < 12; i++) {
						pw += (char) ((Math.random() * 26) + 97);
					}
					users.setPassword(pw);
					// 비밀번호 변경
					usersDAO.updatePw(users);
					// 비밀번호 변경 메일 발송
					sendEmail(users, "findPass");
					
					out.print("임시비밀번호가 발송되었습니다.");
					out.close();
					System.out.println("임시비밀번호:" +pw);
					
					
					//메일을 보낸 후 db에 암호화 해줌
					String passBcrypt = bcryptPasswordEncoder.encode(pw);
					   users.setPassword(passBcrypt);
					 usersDAO.updatePw(users);
					 System.out.println("암호화비밀번호:" +passBcrypt);
				}
		}
			
		
	
	//비밀번호 확인
	@Override
	public Users checkPass(Users users)throws Exception{
		return usersDAO.checkPass(users.getId(), users.getPassword());
	}
	//비밀번호 수정
	@Override
	public void updatePass(String id, String password)throws Exception{
		usersDAO.updatePass(id, password);
	}

	
	
	//카카오 로그인
	@Override
	public String getAccessToken (String authorize_code) {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=7d545fe4f1b025d4ae839deae7232c74"); //본인이 발급받은 key
			sb.append("&redirect_uri=http://localhost:8088/petner/kakaoLogin"); // 본인이 설정한 주소
			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			access_Token = element.getAsJsonObject().get("access_token").getAsString();
			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);
			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return access_Token;
	}
	// 카카오 로그인 정보 저장
	@Override
	public Users getUserInfo(String access_Token) {
		
		 //    요청하는 클라이언트마다 가진 정보가 다를 수 있기에 HashMap타입으로 선언
		HashMap<String, Object> userInfo = new HashMap<String, Object>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject kakao_account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();
			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			String email = kakao_account.getAsJsonObject().get("email").getAsString();
			userInfo.put("nickname", nickname);
			userInfo.put("email", email);
		} catch (IOException e) {
			e.printStackTrace();
		}
			// catch 아래 코드 추가.
			Users result = usersDAO.findkakao(userInfo);
			// 위 코드는 먼저 정보가 저장되있는지 확인하는 코드.
			System.out.println("S:" + result);
			if(result==null) {
			// result가 null이면 정보가 저장이 안되있는거므로 정보를 저장.
				usersDAO.kakaoinsert(userInfo);
				// 위 코드가 정보를 저장하기 위해 Repository로 보내는 코드임.
				return usersDAO.findkakao(userInfo);
				// 위 코드는 정보 저장 후 컨트롤러에 정보를 보내는 코드임.
				//  result를 리턴으로 보내면 null이 리턴되므로 위 코드를 사용.
			} else {
				return result;
				// 정보가 이미 있기 때문에 result를 리턴함.
			}
	        
		}


	//user_no를 파라미터로 받아 유저의 모든 정보를 가져온다
	@Override
	public Users getUserByUserNo(Integer user_no) {
		return usersDAO.getUserByUserNo(user_no);
	}


	@Override
	public Users inquiryOfUserById(String id){
		// TODO Auto-generated method stub
		return usersDAO.inquiryOfUserById(id);
	}


	@Override
	public Users inquiryOfUserByUserNo(int userNo) throws Exception {
		return usersDAO.inquiryOfUserByUserNo(userNo);
	}


	//로그인유지
	@Override
	public void keepLogin(String uid, String sessionId, Date next) {
		usersDAO.keepLogin(uid, sessionId, next);
		
	}

	//로그인유지 체크
	@Override
	public Users checkUserWithSessionKey(String sessionId) {
		return usersDAO.checkUserWithSessionKey(sessionId);
	}

	// 유진 : 회원탈퇴
	@Override
	public void deleteUsers(Integer user_no) throws Exception {
		Users users = getUserByUserNo(user_no);
		System.out.println("Service:"+user_no);
		System.out.println("Service:"+users);
		usersDAO.deleteUsers(user_no);
		
	}

	// 타입 업데이트
	@Override
	public void updateUserType(Users users) {
		usersDAO.updateUserType(users);

	}

		
			
	}
			




	
	
	


	

<%@ page language="java" contentType="text/html; charset=EUC-KR"    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.board.bean.Member" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	String user_id = request.getParameter("id");
	String user_pw = request.getParameter("pw");
	
	if(user_id.indexOf("\'") > 0 || user_pw.indexOf("\'") > 0 ){
		request.setAttribute("msg", "wrong character");
		request.setAttribute("url", "index.jsp");
	}else{
	
		Member user = null;
		try {
			String driverName = "oracle.jdbc.driver.OracleDriver";	
			String url = "jdbc:oracle:thin:@localhost:1521:XE";	
			
			ResultSet rs = null;
			Class.forName(driverName);
			Connection con = DriverManager.getConnection(url,"board","board");
			Statement stmt = con.createStatement();	
	
			//String sql = "select * from member where user_id = '" + user_id + "' and user_pw = '" + user_pw +"'";
			String sql = "select * from member where user_id = (select user_id from member where user_id = '" + user_id + "' and user_pw= '" + user_pw +"')";
			System.out.println(sql);
			
			rs = stmt.executeQuery(sql);	
	
			if(rs.next()){
				user = new Member();
				user.setUser_id(rs.getString("user_id"));
				user.setUser_pw(rs.getString("user_pw"));
			}
		}catch(Exception e){
			out.println("error!");
		}finally{
			if(user == null){
				request.setAttribute("msg", "there is no member Infomation");
				request.setAttribute("url", "index.jsp");
			}else{
				request.setAttribute("msg", "welcome!");
				request.setAttribute("url", "list.do");
				request.getSession().setAttribute("user", user_id); 
			}
		}
	}

%>
<script>
	alert("${msg} "+ " ${user}");
	location.href="${url}";
</script>
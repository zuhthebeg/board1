<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.board.bean.Board" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<%
	ResultSet rs = null;
	String idx = request.getParameter("idx");
	try {
		String driverName = "oracle.jdbc.driver.OracleDriver";	
		String url = "jdbc:oracle:thin:@localhost:1521:XE";	
	 
		Class.forName(driverName);
		Connection con = DriverManager.getConnection(url,"board","board");
		out.println("Oracle Database Connection Success.");
	 
		Statement stmt = con.createStatement();			
		String sql = "select * from board where idx = " + idx ;	//게시글 질의
		rs = stmt.executeQuery(sql);
		//게시글이 있으면 bean 객체 생성후 값 셋팅
		if(rs.next()){
			Board article = new Board();
			article.setTitle(rs.getString("title"));
			article.setContent(rs.getString("content"));
			request.setAttribute("article", article);
		}
		//게시글이 없으면 index.jsp 페이지로 전환->list.jsp로 전환
		else{
			out.print("<script>location.href='index.jsp';</script>");
		}
	}catch (Exception e) {
		out.println("Oracle Database Connection Something Problem. <hr>");
		out.println(e.getMessage());
		e.printStackTrace();
	}
%>

<form action="update.jsp" method="post">
	제목 <input type="text" name="title" value="${article.title }"><br>
	내용 <textarea name="content">${article.content}</textarea><br>
	<input type="hidden" name="idx" value="<%=idx %>">
	<input type="submit" value="수정하기!!">
</form>
</body>
</html>

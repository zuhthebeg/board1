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
		String sql = "select * from board where idx = " + idx ;	//�Խñ� ����
		rs = stmt.executeQuery(sql);
		//�Խñ��� ������ bean ��ü ������ �� ����
		if(rs.next()){
			Board article = new Board();
			article.setTitle(rs.getString("title"));
			article.setContent(rs.getString("content"));
			request.setAttribute("article", article);
		}
		//�Խñ��� ������ index.jsp �������� ��ȯ->list.jsp�� ��ȯ
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
	���� <input type="text" name="title" value="${article.title }"><br>
	���� <textarea name="content">${article.content}</textarea><br>
	<input type="hidden" name="idx" value="<%=idx %>">
	<input type="submit" value="�����ϱ�!!">
</form>
</body>
</html>

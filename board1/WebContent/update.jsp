<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>			
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("euc-kr");
	String idx = request.getParameter("idx");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
try {
	 String driverName = "oracle.jdbc.driver.OracleDriver";	
	 String url = "jdbc:oracle:thin:@localhost:1521:XE";	
	 
	 Class.forName(driverName);
	 Connection con = DriverManager.getConnection(url,"board","board");
	 out.println("Oracle Database Connection Success.");
	 
	 Statement stmt = con.createStatement();			
	 String sql = "update board set title = '"+title+"',content ='"+content+"' where idx = "+idx;
	 stmt.executeUpdate(sql);
	 
	 con.close();
	}catch (Exception e) {
	 out.println("Oracle Database Connection Something Problem. <hr>");
	 out.println(e.getMessage());
	 e.printStackTrace();
	}finally{
		out.print("<script>location.href='index.jsp';</script>");
	}
%>
<body>
</body>
</html>
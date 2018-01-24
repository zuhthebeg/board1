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
	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	int count = 0;
	String content = request.getParameter("content");
	
	if(title == "" ||title == null) out.println("title is null");
	
	if(writer == "" ||writer == null) out.println("writer is null");	
	else if(!Pattern.matches("^[_0-9a-zA-Z-]+@[0-9a-zA-Z-]+(.[_0-9a-zA-Z-]+)*$", writer)) out.println("no e-mail.");
	
	if(content == "" ||content == null) out.println("content is null");
	
try {
	 //String driverName = "oracle.jdbc.driver.OracleDriver";	
	 //String url = "jdbc:oracle:thin:@localhost:1521:XE";	
	 
	 String driverName = "com.sybase.jdbc4.jdbc.SybDriver";	
	 String url = "jdbc:sybase:Tds:210.115.58.233:2638?ServiceName=test";	
	 
	 Class.forName(driverName);
	 Connection con = DriverManager.getConnection(url,"DBA", "sql");
	 out.println("Oracle Database Connection Success.");
	 
	 Statement stmt = con.createStatement();			
	 String sql = "INSERT INTO BOARD "+
	 			"(IDX, TITLE, WRITER, REGDATE, COUNT, CONTENT) "+ 
	 			"VALUES (board_seq.nextval, '"+title+"', '"+writer+"', sysdate, "+count+", '"+content+"')";
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
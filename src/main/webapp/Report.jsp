<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<title>AML SYSTEM</title>
</head>

<body>
<h2>AML 업무수행</h2>
<h3>금융당국에 보고하기</h3>
<div class="transaction">
<%@ include file="dbconn.jsp"%>
	<%
		PreparedStatement pstmt;
		int cnt;
		ResultSet rs;
	%>
<h4>-------------Dangerous Transaction for Report-------------</h4>
<form action="result.jsp" method="post">
<%
	int txn_id = Integer.parseInt(request.getParameter("txn_id"));
	out.println("<input type='hidden' name='txn_id' value="+txn_id+">");
	
	String query = "SELECT * FROM DNG_TXN WHERE TXN_ID=?";
	pstmt = conn.prepareStatement(query);
	pstmt.setInt(1,txn_id);
	
	rs = pstmt.executeQuery();
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	for(int i =1;i<=cnt;i++){
		out.println("<th>"+rsmd.getColumnName(i)+"</th>");
	}
	while(rs.next()){
		out.println("<tr>");
		out.println("<td>"+rs.getString(1)+"</td>");
		out.println("<td>"+rs.getString(2)+"</td>");
		out.println("<td>"+rs.getString(3)+"</td>");
		out.println("<td>"+rs.getString(4)+"</td>");
		out.println("</tr>");		
	}
	out.println("</table>");

%>
<%

	rs.close();
	pstmt.close();
	conn.close();
%>
</div>

	<label>보고사유: </label>
		<textarea name="" id="" cols="200" rows="30"></textarea>
		<br><br>
	<input type="submit" value="Report">

</form>

	<div></div>
</div>
</body>
</html>
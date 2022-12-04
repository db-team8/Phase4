<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>AML SYSTEM</title>
</head>
<body>

<%@ include file="dbconn.jsp"%>
<%
	PreparedStatement pstmt;
	int feedback;
	int cnt;
	ResultSet rs;
%>
<%
	int state = Integer.parseInt(request.getParameter("button"));
	int txn_id = Integer.parseInt(request.getParameter("txn_id"));
	
	if(state == 1)
	{
		// DNG_TXN UPDATE
		String query = "UPDATE DNG_TXN SET STATUS=1 WHERE TXN_ID=?";
		pstmt = conn.prepareStatement(query);
		
		pstmt.setInt(1, txn_id);
		
		feedback = pstmt.executeUpdate();
		
		if(feedback==0) System.out.println("No Updated.");
	    else out.println("<h4> 거래ID: "+txn_id+" 거래가 허가 되었습니다. </h4>");
		
		// TRANSACTION UPDATE
		query = "UPDATE TRANSACTION SET STATUS='1' WHERE TXN_ID=?";
		pstmt = conn.prepareStatement(query);
		
		pstmt.setInt(1, txn_id);
		
		feedback = pstmt.executeUpdate();
		
		if(feedback==0) System.out.println("No Updated.");

		pstmt.close();
		
	}
	else if(state == 2)
	{
		// DNG_TXN UPDATE
		String query = "UPDATE DNG_TXN SET STATUS=2 WHERE TXN_ID=?";
		pstmt = conn.prepareStatement(query);
		
		pstmt.setInt(1, txn_id);
		
		feedback = pstmt.executeUpdate();
		if(feedback==0) System.out.println("No Updated.");
	    else out.println("<h4> 거래ID: "+txn_id+" 거래가 거부 되었습니다. </h4>");
		
		// TRANSACTION UPDATE
		query = "UPDATE TRANSACTION SET STATUS='2' WHERE TXN_ID=?";
		pstmt = conn.prepareStatement(query);
		
		pstmt.setInt(1, txn_id);
		
		feedback = pstmt.executeUpdate();
		
		if(feedback==0) System.out.println("No Updated.");

		pstmt.close();
		
	}	
	
	conn.close();
%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<title>AML SYSTEM</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>
<%@ include file="dbconn.jsp"%>
<%
	PreparedStatement pstmt;
	int cnt;
	ResultSet rs;
%>
<%
	int txn_id = Integer.parseInt(request.getParameter("txn_id"));

	// DNG_TXN UPDATE
	String query = "UPDATE DNG_TXN SET STATUS=3 WHERE TXN_ID=?";
	pstmt = conn.prepareStatement(query);
	
	pstmt.setInt(1, txn_id);

    int feedback = pstmt.executeUpdate();
    if(feedback==0) out.println("No Updated.");
    else out.println("거래ID: "+txn_id+"가 보고되었습니다.");
	
 // TRANSACTION UPDATE
    query = "UPDATE TRANSACTION SET STATUS='2' WHERE TXN_ID=?";
	pstmt = conn.prepareStatement(query);
	
	pstmt.setInt(1, txn_id);

    feedback = pstmt.executeUpdate();
    if(feedback==0) out.println("No Updated.");
    
	pstmt.close();
	conn.close();
%>

</body>
</html>

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
<% 
	/*----------connect----------*/
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "db8";
	String pass = "db8";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	System.out.println(url);
	Connection conn = null;
	PreparedStatement pstmt;
	int cnt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);
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
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>AML SYSTEM</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
</head>
<body>
<h2>AML 업무수행</h2>
<h3>위험 의심 거래를 확인하세요.</h3>

<div class="transaction" width="520px" id="transaction">
	<h4>-------------Dangerous Transactions-------------</h4>
<!-- <iframe src="transactions.jsp" name='transaction'></iframe>  -->
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
	String status="";
	String[] filter = null;
	if(request.getParameterValues("filter") != null) filter = request.getParameterValues("filter");
	
	if(filter == null){
		String query = "SELECT * FROM DNG_TXN";
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		
		out.println("<table class='table' border=\"1\">");
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
			switch(rs.getString(4)){
				case "0" : status = "심사 필요";
				break;
				case "1": status = "거래 허용";
				break;
				case "2": status = "거래 거부";
				break;
				case "3": status = "금융당국에 보고됨";
				break;
			}
			out.println("<td>"+status+"</td>");
			out.println("</tr>");		
		}
		out.println("</table>");

		rs.close();
		pstmt.close();
		conn.close();
	}else if(filter.length == 2){
		String query = "SELECT * FROM DNG_TXN WHERE STATUS = 0 ORDER BY SCORE DESC";
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		
		out.println("<table class='table' border=\"1\">");
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
			switch(rs.getString(4)){
				case "0" : status = "심사 필요";
				break;
				case "1": status = "거래 허용";
				break;
				case "2": status = "거래 거부";
				break;
				case "3": status = "금융당국에 보고됨";
				break;
			}
			out.println("<td>"+status+"</td>");
			out.println("</tr>");		
		}
		out.println("</table>");

		rs.close();
		pstmt.close();
		conn.close();
	}
	else if(filter.length == 1){
		if(filter[0].equals("2")){
			String query = "SELECT * FROM DNG_TXN WHERE STATUS = 0";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			out.println("<table class='table' border=\"1\">");
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
				switch(rs.getString(4)){
					case "0" : status = "심사 필요";
					break;
					case "1": status = "거래 허용";
					break;
					case "2": status = "거래 거부";
					break;
					case "3": status = "금융당국에 보고됨";
					break;
				}
				out.println("<td>"+status+"</td>");
				out.println("</tr>");		
			}
			out.println("</table>");

			rs.close();
			pstmt.close();
			conn.close();
		}else if(filter[0].equals("3")){
			String query = "SELECT * FROM DNG_TXN ORDER BY SCORE DESC";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			out.println("<table class='table' border=\"1\">");
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
				switch(rs.getString(4)){
					case "0" : status = "심사 필요";
					break;
					case "1": status = "거래 허용";
					break;
					case "2": status = "거래 거부";
					break;
					case "3": status = "금융당국에 보고됨";
					break;
				}
				out.println("<td>"+status+"</td>");
				out.println("</tr>");		
			}
			out.println("</table>");

			rs.close();
			pstmt.close();
			conn.close();
		}
	}
%>
</div>

<div class="work">
	<div class="options">
	
	<form method="post">
		<div class="form-check form-switch">
		  <input class="form-check-input" name="filter" value="2" type="checkbox" role="switch" id="flexSwitchCheckChecked">
		  <label class="form-check-label" for="flexSwitchCheckChecked">심사가 필요한 거래만 보기</label>
			<br><br>
		 	<input class="form-check-input" name="filter" value="3" type="checkbox" role="switch" id="flexSwitchCheckChecked">
			<label class="form-check-label" for="flexSwitchCheckChecked">위험도 점수 순으로 정렬하기</label>
		</div>
			<br>
		<button onclick="reloadDivArea()" value="적용">적용</button>
	
	</form>

	</div>
	<br><br>

<form name="permission" method="post">
	<p>작업을 수행할 거래ID: <input type="text" name="txn_id"></p>
		<br><br>
		<button name="button" onclick="javascript: form.action='permission.jsp';" value=1>거래 허용</button>
		<button name="button" onclick="javascript: form.action='permission.jsp';" value=2>거래 거부</button>
		<button name="button" onclick="javascript: form.action='Report.jsp';" value=3>금융당국에 보고</button>
</form>

	<div></div>
</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous">

	reloadDivArea(); //함수 실행
	 
	function reloadDivArea() {
	    $('#transaction').load(location.href+' #transaction');
	}
	
</script>
</html>
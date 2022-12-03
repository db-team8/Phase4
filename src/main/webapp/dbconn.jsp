<%@ page import="java.sql.*"%>�
<%
  String serverIP = "localhost";
  String strSID = "xe";
  String portNum = "11523";
  String user = "dongyoun";
  String pass = "4123";
  String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
  System.out.println(url);
  Connection conn = null;
  Class.forName("oracle.jdbc.driver.OracleDriver");
  conn = DriverManager.getConnection(url,user,pass);
%>
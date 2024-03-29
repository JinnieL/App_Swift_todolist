<%@page import="org.springframework.boot.configurationprocessor.json.JSONArray"%>
<%@page import="org.springframework.boot.configurationprocessor.json.JSONObject"%>
<%@page import="java.sql.*"%>
<%  
    /*
    Date: 2022-01-01
    Notes : Json Module을 이용한 Json 구성
    */
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String url_mysql = "jdbc:mysql://localhost/swift_todo_list?serverTimezone=UTC&characterEncoding=utf8&useSSL=FALSE";
 	String id_mysql = "root";
 	String pw_mysql = "qwer1234";
    String WhereDefault = "select seq, userid, content, viewstatus, donestatus from todolist ";

    // Date : 2021-12-25
    JSONObject jsonList = new JSONObject();
    JSONArray itemList = new JSONArray();

    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn_mysql = DriverManager.getConnection(url_mysql, id_mysql, pw_mysql);
        Statement stmt_mysql = conn_mysql.createStatement();

        ResultSet rs = stmt_mysql.executeQuery(WhereDefault);
        while (rs.next()) {
            JSONObject tempJson = new JSONObject();
            tempJson.put("seq", rs.getInt(1));
            tempJson.put("userid", rs.getString(2));
            tempJson.put("content", rs.getString(3));
            tempJson.put("viewstatus", rs.getInt(4));
            tempJson.put("donestatus", rs.getInt(5));
            itemList.add(tempJson);
        }
        // jsonList.put("results",itemList);
        conn_mysql.close();
        out.print(itemList);        
    } catch (Exception e) {
        e.printStackTrace();
    }
	
%>

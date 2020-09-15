<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>显示单词生疏度</title>
</head>
<body>
    <% Class.forName("org.sqlite.JDBC"); %>
    <% out.println("序号    单词    生疏度（3-0）<br/>"); %>
<%
  Class.forName("com.mysql.jdbc.Driver");      
  String url="jdbc:mysql://localhost:3306/wordfriend";   
   Connection conn;
        conn = (Connection) DriverManager.getConnection(url,"root","123456");
        //创建一个Statement对象
        Statement stmt = (Statement) conn.createStatement(); 
        ResultSet rs = stmt.executeQuery("select * from wordlist");
        //显示库中所有单词生疏度
          while (rs.next()) {%> 
          <tr>
           <td><% out.println(rs.getInt("id")+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");%></td>
           <td><% out.println(rs.getString("word")+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");%></td>
           <td><% out.println(rs.getInt("rustydegree"));%></td>  
           <%  out.print("<br>"); %>       
           </tr>
  <%           
    }     
        stmt.close();
        conn.close();
    %>
  
    <input type="button" value="进行生疏度评价 "onclick = "window.location.href='forth.jsp'">
</body>
</html>
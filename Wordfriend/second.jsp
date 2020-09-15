<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>显示单词频率</title>
</head>
<body>

     <% out.println("显示单词频率"); %>
     <p><a href="./third.jsp">前往查看单词生疏度</a></p>
     <% out.println("序号    单词    当前频率    历史频率<br/>"); %>
     
<%
  Class.forName("com.mysql.jdbc.Driver");      
  String url="jdbc:mysql://localhost:3306/wordfriend";   
   Connection conn;
        conn = (Connection) DriverManager.getConnection(url,"root","123456");
        //创建一个Statement对象
        Statement stmt = (Statement) conn.createStatement();
        ResultSet rs = stmt.executeQuery("select * from wordlist");
        String sql = "UPDATE wordlist SET currentnumber=?,historynumber=? WHERE id=?";
       
        //显示库中所有单词的当前频率，历史频率
          while (rs.next()) {%>  
          <tr>
           <td><%  out.println(rs.getInt("id")+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");%></td>
           <td><%  out.println(rs.getString("word")+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");%></td>
           <td><%  out.println(rs.getInt("currentnumber")+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");%></td>
           <td><%  out.println(rs.getInt("historynumber"));%></td>  
           <%  out.print("<br>"); %>       
           </tr>
   <% PreparedStatement ps = null; //当前文章查看完毕，当前频率加入历史频率
            int n = rs.getInt("id");
            int j = rs.getInt("currentnumber");
            int k = rs.getInt("historynumber");
            ps = conn.prepareStatement(sql);
            ps.setInt(1, 0);
            ps.setInt(2, j+k);
            ps.setInt(3, n);
            ps.executeUpdate();           
    }
       
        stmt.close();
        conn.close();
    %>

</body>
</html>
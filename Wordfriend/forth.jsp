<%@ page language="java" import="java.sql.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>生疏度评价</title>
</head>
<body>
    <%  Class.forName("com.mysql.jdbc.Driver"); %>
    <% out.println("更新单词生疏度"); %>
    <% 
	String content1 = request.getParameter("content1");
    String content2 = request.getParameter("content2");
	//显示更新界面
	if (content1 != null&&content2 != null) {
		out.println(content1);
		out.println(content2);
		int num = Integer.valueOf(content2);
		String[] slist = content1.split("[^a-zA-z]+");
		   for (int i = 0; i < slist.length; i++) {
			   Change(slist[i],num);
	    } 
		   response.sendRedirect("./third.jsp");
	} else {
		out.println("<p>请输入英文单词后，点击更新按钮。</p>");
	}
    %>
    <form method="post" action="./forth.jsp">
    <textarea name="content1" rows="20" cols="80"></textarea>
    <% out.println("生疏度（0-3）："); %>
    <textarea name="content2" rows="2" cols="8"></textarea>
    <input type="submit" value="更新 ">
    </form>
    
     <%! private void Change(String words,int numb) throws SQLException {
    	 String url="jdbc:mysql://localhost:3306/wordfriend";   
    	   Connection conn;
    	        conn = (Connection) DriverManager.getConnection(url,"root","123456");
    	        //创建一个Statement对象
    	        Statement stmt = (Statement) conn.createStatement(); 
    	        ResultSet rs = stmt.executeQuery("select * from wordlist");
    	        String sql = "UPDATE wordlist SET rustydegree=? WHERE word=?";       
    	       PreparedStatement ps = null;    
    	            ps = conn.prepareStatement(sql);
    	            ps.setInt(1, numb);
    	            ps.setString(2, words);     
    	            ps.executeUpdate();             	       
    	        stmt.close();
    	        conn.close();          
  }
%>
</body>
</html>
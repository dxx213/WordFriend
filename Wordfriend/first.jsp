<%@ page language="java" import="java.sql.*"  contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>输入文章</title>
</head>
<body>
   <%-- 创建界面，调用单词插入数据库的函数  --%>
    <% Class.forName("com.mysql.jdbc.Driver"); %>
    <% out.println("输入文章："); %>
    <% 
	String content = request.getParameter("content");
	if (content != null) {
		out.println(content);
		content = content.toLowerCase();
		String[] slist = content.split("[^a-zA-z]+");
		   for (int i = 0; i < slist.length; i++) {
			   Insert(slist[i]);
		} 
		   response.sendRedirect("./second.jsp");	
	} else {
		out.println("<p>请输入英文文章后，点击确认按钮。</p>");
	}
	
    %>
   
    <form method="post" action="./first.jsp">
		<textarea name="content" rows="20" cols="120"></textarea>
		<br /> <input type="submit" value="确定 "></input>
	</form>	
	
    <%! private void Insert(String words) throws SQLException { 
     try {
    	 String url="jdbc:mysql://localhost:3306/wordfriend";   
    	   Connection conn;
    	        conn = (Connection) DriverManager.getConnection(url,"root","123456");
    	        //创建一个Statement对象
    	        Statement stmt = (Statement) conn.createStatement(); 
    	        ResultSet rs1 = stmt.executeQuery("select * from wordlist");
    	//得到当前数据卡 中所有单词序号
        int i=1 , k=1;
        boolean n= false;
        while(rs1.next()){
        	i++;
        }
        String sql3= "select * from wordlist where word like ?";
		//查询是否有该word
		PreparedStatement pstmt3= conn.prepareStatement(sql3);
		pstmt3.setString(1,words);
		ResultSet rs2=pstmt3.executeQuery();
		while(rs2.next()){
			k = rs2.getInt("currentnumber"); 
			n=true; 
		}	
        if(n==false){ //当数据库中不存在该单词，插入
        	String sql2 = "insert into wordlist(id,word,currentnumber,historynumber,rustydegree) values(?,?,?,?,?)";
        	PreparedStatement pstmt=conn.prepareStatement(sql2);
        	pstmt.setInt(1,i);
        	pstmt.setString(2,words);
        	pstmt.setInt(3,1);
        	pstmt.setInt(4,0);
        	pstmt.setInt(5,0);
        	pstmt.executeUpdate();
        }  else { //当数据库中存在该单词，更新
        	String sql1 = "UPDATE wordlist SET currentnumber=? WHERE word=?";
        	PreparedStatement ps = conn.prepareStatement(sql1);
            ps.setInt(1, k+1);
            ps.setString(2, words);          
            ps.executeUpdate();  
        }
        stmt.close();
        conn.close();
     } catch (SQLException e) { 
    	 e.printStackTrace();
     } 
  }
%>
	<p>
		<font color="grey">当前时间： <%=new java.util.Date()%></font>
	</p>

</body>
</html>
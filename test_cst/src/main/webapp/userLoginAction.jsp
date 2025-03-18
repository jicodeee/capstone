<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    import="java.sql.*, member.*, java.util.List" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
   <title>User Registration</title>
</head>
<body>
<% 
	String email = null;
	String pwd = null;
	
	request.setCharacterEncoding("UTF-8");
	 
	// Initialize the response writer
     PrintWriter responseWriter  = response.getWriter();

      // Get the form inputs from the request
      if(request.getParameter("email") != null){
    	   email = request.getParameter("email");
      }
	  if(request.getParameter("pwd") != null){
		  pwd = request.getParameter("pwd");
      }
      if(email == null || pwd == null){
    	  responseWriter.println("<script>");
    	  responseWriter.println("alert('입력이 안된 항목이 있습니다')");
    	  responseWriter.println("history.back();");
    	  responseWriter.println("</script>");
      }
      
      // Create an instance of the MemberDAO
      MemberDAO memberDAO = new MemberDAO();
      
      
      try {
         // Call the join() function to register the user
         int student_id = memberDAO.login(email, pwd);
         
         session.setAttribute("student_id", student_id);
         
         if (student_id>0) {
        	 session.setAttribute("student_id",student_id);
        	 responseWriter.println("<p>Welcome, " + email + "!</p>");
        	 responseWriter.println("<script>");
        	 responseWriter.println("alert('로그인에 성공하셨습니다.');");
        	 responseWriter.println("location.href = 'main.jsp'");
        	 responseWriter.println("</script>;");
         } else {
        	 responseWriter.println("<h1>login failed.</h1>");
        	 responseWriter.println("<p>Please try again.</p>");
        	 responseWriter.println("<script>");
        	 responseWriter.println("alert('로그인에 실패하셨습니다');");
       	  	 responseWriter.println("history.back();");
        	 responseWriter.println("</script>");
         }
      } catch (Exception e) {
    	  responseWriter.println("<h1>Error occurred during login.</h1>");
    	  responseWriter.println("<p>Please try again later.</p>");
         e.printStackTrace();
      } finally {
         // Close the response writer
         responseWriter.close();
      }
   %>
   
</body>
</html>
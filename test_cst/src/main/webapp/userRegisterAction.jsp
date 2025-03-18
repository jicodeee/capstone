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
	String name =null;
	String email = null;
	String pwd = null;
	String major = null;
	int year = 0;
	 request.setCharacterEncoding("UTF-8");
	 
	// Initialize the response writer
     PrintWriter responseWriter  = response.getWriter();

      // Get the form inputs from the request
      if(request.getParameter("name") != null){
    	   name = request.getParameter("name");
      }
      if(request.getParameter("email") != null){
    	   email = request.getParameter("email");
      }
	  if(request.getParameter("pwd") != null){
		   pwd = request.getParameter("pwd");
      }
	  if(request.getParameter("major") != null){
		   major = request.getParameter("major");
	  }
	  if (request.getParameter("year") != null) {
		    year = Integer.parseInt(request.getParameter("year"));
		}
      if(name ==null ||email == null || pwd == null || major == null || year == 0){
    	  responseWriter.println("<script>");
    	  responseWriter.println("alert('입력인 안된 항목이 있습니다')");
    	  responseWriter.println("history.back();");
    	  responseWriter.println("</script>");
      }
      
      // Create an instance of the MemberDAO
      MemberDAO memberDAO = new MemberDAO();
      
      
      try {
         // Call the join() function to register the user
         boolean registrationSuccessful = memberDAO.join(name, email, pwd, major, year);
         
         if (registrationSuccessful) {
        	 session.setAttribute("email",email);
        	 responseWriter.println("<h1>User registration successful!</h1>");
        	 responseWriter.println("<p>Welcome, " + name + "!</p>");
        	 responseWriter.println("<script>");
        	 responseWriter.println("location.href = 'login.jsp'");
        	 responseWriter.println("</script>;");
         } else {
        	 responseWriter.println("<h1>Registration failed.</h1>");
        	 responseWriter.println("<p>Please try again.</p>");
         }
      } catch (Exception e) {
    	  responseWriter.println("<h1>Error occurred during registration.</h1>");
    	  responseWriter.println("<p>Please try again later.</p>");
         e.printStackTrace();
      } finally {
         // Close the response writer
         responseWriter.close();
      }
   %>
   
</body>
</html>
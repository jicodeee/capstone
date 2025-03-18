<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register Timetable</title>
</head>
<body>

<%
    Integer studentID = (Integer) session.getAttribute("student_id");

    if (studentID == null) {
        out.println("<p>로그인된 사용자가 없습니다. 로그인 후 다시 시도해주세요.</p>");
        return;
    }

    int student_id = studentID;

    String courseName = request.getParameter("courseName");
    String dayOfWeek = request.getParameter("dayOfWeek");
    String startTimeParam = request.getParameter("startTime");
    String endTimeParam = request.getParameter("endTime");
    String room = request.getParameter("room");
    
    if (dayOfWeek != null) {
        dayOfWeek = new String(dayOfWeek.getBytes("ISO-8859-1"), "UTF-8");
    }
    if (courseName != null) {
    	courseName = new String(courseName.getBytes("ISO-8859-1"), "UTF-8");
    }
    
    Time startTime = null;
    Time endTime = null;

    if (startTimeParam != null) {
        startTimeParam = convertTo24HourFormat(startTimeParam);
    }
    if (endTimeParam != null) {
        endTimeParam = convertTo24HourFormat(endTimeParam);
    }

    try {
        if (startTimeParam != null && !startTimeParam.isEmpty()) {
            startTime = Time.valueOf(startTimeParam + ":00");
        }
        if (endTimeParam != null && !endTimeParam.isEmpty()) {
            endTime = Time.valueOf(endTimeParam + ":00");
        }
    } catch (IllegalArgumentException e) {
        out.println("<p>잘못된 시간 형식입니다. HH:mm 형식으로 입력해 주세요.</p>");
        e.printStackTrace();
    }

    if (courseName != null && dayOfWeek != null && startTime != null && endTime != null) {
        String url = "jdbc:mysql://localhost:3306/learning_resource_system?useUnicode=true&characterEncoding=UTF-8";
        String dbUser = "root";
        String dbPassword = "wltjsdn123!";

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, dbUser, dbPassword);

            String sql = "INSERT INTO Timetable (student_id, course_name, day_of_week, start_time, end_time, room) VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, student_id);
            pstmt.setString(2, courseName);
            pstmt.setString(3, dayOfWeek);
            pstmt.setTime(4, startTime);
            pstmt.setTime(5, endTime);
            pstmt.setString(6, room);

            int result = pstmt.executeUpdate();

            if (result > 0) {
                out.println("<h3>시간표 등록 성공!</h3>");
                response.sendRedirect("main.jsp");
                return;
            } else {
                out.println("<h3>시간표 등록 실패. 다시 시도해 주세요.</h3>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>에러 발생: " + e.getMessage() + "</h3>");
        } finally {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        }
    }
%>

<%! 
    String convertTo24HourFormat(String time) {
        try {
            SimpleDateFormat displayFormat = new SimpleDateFormat("HH:mm");
            SimpleDateFormat parseFormatWithMeridiem = new SimpleDateFormat("a hh:mm", Locale.KOREA);
            SimpleDateFormat parseFormatWithoutMeridiem = new SimpleDateFormat("HH:mm");

            if (time.contains("오전") || time.contains("오후") || time.toLowerCase().contains("am") || time.toLowerCase().contains("pm")) {
                // 오전/오후 형식일 경우 처리
                Date date = parseFormatWithMeridiem.parse(time);
                return displayFormat.format(date);
            } else {
                // 24시간 형식일 경우 그대로 반환
                Date date = parseFormatWithoutMeridiem.parse(time);
                return displayFormat.format(date);
            }
        } catch (ParseException e) {
            e.printStackTrace();
            return null; // 파싱 실패 시 null 반환
        }
    }
%>

</body>
</html>
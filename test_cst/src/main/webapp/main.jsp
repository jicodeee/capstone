<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.sql.*, java.util.ArrayList" %>
<%@ page import="timetable.TimetableDTO" %> <!-- TimetableDTO 클래스 가져오기 -->
<!DOCTYPE html>
<html>
<head>
    <title>시간표</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <style>
    	.btn-light-green {
            background-color: #90ee90; /* 연녹색 */
            border-color: #90ee90;
            color: white;
        }
        .btn-light-green:hover {
            background-color: #76c776; /* 좀 더 진한 연녹색 */
            border-color: #76c776;
        }
        
        .card {
            border: 3px solid #90ee90; /* 연녹색 테두리 */
            border-radius: 10px; /* 모서리를 둥글게 */
        }
       
        .header {
            text-align: center;
            font-size: 17px; /* 큰 글자 크기 */
            color: #90ee90; /* 연녹색 */
            margin-top: 10px;
        }
        
        .header-line {
            border-top: 3px solid #90ee90; /* 연녹색 가로선 */
            width: 600%;
            margin: 10px auto;
        }
        .timetable {
            border-collapse: collapse;
            width: 100%;
            text-align: center;
        }
        .timetable th, .timetable td {
            border: 1px solid #ddd;
            padding: 15px;
            min-width: 100px;
        }
        .timetable th {
            background-color: #f2f2f2;
        }
        .timetable td {
            height: 100px;
        }
        .course {
            background-color: #90EE90;
        }
    </style>
</head>
<body>

	<div class="header">Running mate</div>
    <div class="header-line"></div>
    <div class="container mt-4">
        <h1>시간표 등록</h1>
        <form method="POST" action="timetableRegister.jsp">
            <button type="submit" class="btn btn-light-green">시간표 등록</button>
        </form>

        <h2 class="mt-5">시간표 보기</h2>
        <table class="timetable">
            <thead>
                <tr>
                    <th>시간</th>
                    <th>월</th>
                    <th>화</th>
                    <th>수</th>
                    <th>목</th>
                    <th>금</th>
                </tr>
            </thead>
            <tbody>
                <% 
                String url = "jdbc:mysql://localhost:3306/learning_resource_system?useUnicode=true&characterEncoding=UTF-8";
                String dbUser = "root";
                String dbPassword = "wltjsdn123!";
                Connection con = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                List<TimetableDTO> timetableList = new ArrayList<>();

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    con = DriverManager.getConnection(url, dbUser, dbPassword);
                    
                    Integer studentID = (Integer) session.getAttribute("student_id");
                    if (studentID == null) {
                        out.println("<p>로그인된 사용자가 없습니다. 로그인 후 다시 시도해주세요.</p>");
                        return;
                    }

                    String sql = "SELECT * FROM Timetable WHERE student_id = ?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setInt(1, studentID);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        TimetableDTO t = new TimetableDTO();
                        t.setStudentId(rs.getInt("student_id"));
                        t.setCourseName(rs.getString("course_name")); 
                        t.setDayOfWeek(rs.getString("day_of_week"));
                        t.setStartTime(rs.getString("start_time"));
                        t.setEndTime(rs.getString("end_time"));
                        t.setRoom(rs.getString("room"));
                        timetableList.add(t);
                    }

                    session.setAttribute("timetableList", timetableList);
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>시간표 데이터를 불러오는 중 오류가 발생했습니다.</p>");
                } finally {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (con != null) con.close();
                }

                String[] times = {"09:00:00-10:00:00", "10:00:00-11:00:00", "11:00:00-12:00:00", "12:00:00-13:00:00", "13:00:00-14:00:00", "14:00:00-15:00:00", "15:00:00-16:00:00", "16:00:00-17:00:00", "17:00:00-18:00:00"};

                if (timetableList != null && !timetableList.isEmpty()) {
                    for (String time : times) {
                        out.print("<tr><td>" + time + "</td>");
                        for (String day : new String[]{"월", "화", "수", "목", "금"}) {
                            String courseName = "";
                            for (TimetableDTO t : timetableList) {
                                if (t.getDayOfWeek().equals(day) && 
                                    time.split("-")[0].compareTo(t.getStartTime()) >= 0 &&
                                    time.split("-")[1].compareTo(t.getEndTime()) <= 0) {
                                    courseName = t.getCourseName(); 
                                    break;
                                }
                            }
                            out.print("<td class='" + (courseName.isEmpty() ? "" : "course") + "'>");
                            if (!courseName.isEmpty()) {
                                out.print("<a href='resource.jsp?course_name=" + courseName + "'>" + courseName + "</a>");
                            }
                            out.print("</td>");
                        }
                        out.print("</tr>");
                    }
                } else {
                    out.print("<tr><td colspan='6'>시간표 데이터가 없습니다.</td></tr>");
                }
                %>
            </tbody>
        </table>
        
    </div>
</body>
</html>
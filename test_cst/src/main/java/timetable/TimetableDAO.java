package timetable;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.DB; // 데이터베이스 연결 유틸리티

public class TimetableDAO {
    private Connection con;

    // 생성자: 데이터베이스 연결 초기화
    public TimetableDAO() {
        con = DB.getConnection();
    }

    // 특정 학생의 모든 시간표 가져오기
    public List<TimetableDTO> getAllTimetable(int student_id) throws SQLException {
        List<TimetableDTO> timetableList = new ArrayList<>();
        String sql = "SELECT student_id, course_name, day_of_week, start_time, end_time, room FROM Timetable WHERE student_id = ?"; // student_id 기준으로 시간표 가져오기

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, student_id); // student_id 파라미터 설정

            try (ResultSet resultSet = stmt.executeQuery()) {
                // 결과 처리
                while (resultSet.next()) {
                    String courseName = resultSet.getString("course_name");
                    String dayOfWeek = resultSet.getString("day_of_week");
                    String startTime = resultSet.getString("start_time");
                    String endTime = resultSet.getString("end_time");
                    String room = resultSet.getString("room");

                    // TimetableDTO 객체 생성
                    TimetableDTO timetable = new TimetableDTO(student_id, courseName, dayOfWeek, startTime, endTime, room);

                    // 리스트에 추가
                    timetableList.add(timetable);
                }
            }
        }

        return timetableList; // 시간표 리스트 반환
    }

    // 새로운 시간표 등록 메서드
    public boolean registerCourse(TimetableDTO timetableDTO) {
        String sql = "INSERT INTO Timetable (student_id, course_name, day_of_week, start_time, end_time, room) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, timetableDTO.getStudentId());
            stmt.setString(2, timetableDTO.getCourseName());
            stmt.setString(3, timetableDTO.getDayOfWeek());
            stmt.setString(4, timetableDTO.getStartTime());
            stmt.setString(5, timetableDTO.getEndTime());
            stmt.setString(6, timetableDTO.getRoom());

            int rowsAffected = stmt.executeUpdate(); // 쿼리 실행
            return rowsAffected > 0; // 성공적으로 삽입되었으면 true 반환
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false; // 삽입 실패 시 false 반환
    }

    // 메모리 해제 시 연결 종료 메서드
    public void close() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
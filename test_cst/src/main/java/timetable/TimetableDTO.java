package timetable;

public class TimetableDTO {
    private int student_id; // 학생 ID (이메일 대신 student_id 사용)
    private String courseName;
    private String dayOfWeek;
    private String startTime;
    private String endTime;
    private String room;
    
    public TimetableDTO() {
    }

    // 생성자
    public TimetableDTO(int student_id, String courseName, String dayOfWeek, String startTime, String endTime, String room) {
        this.student_id = student_id;
        this.courseName = courseName;
        this.dayOfWeek = dayOfWeek;
        this.startTime = startTime;
        this.endTime = endTime;
        this.room = room;
    }

    // Getter와 Setter
    public int getStudentId() {
        return student_id;
    }

    public void setStudentId(int student_id) {
        this.student_id = student_id;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(String dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getRoom() {
        return room;
    }

    public void setRoom(String room) {
        this.room = room;
    }
}
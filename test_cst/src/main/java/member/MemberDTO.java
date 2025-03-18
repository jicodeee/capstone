package member;

public class MemberDTO {
	private int student_id;
	private String name;
	private String email;
	private String major;
	private String pwd;
	private int year;
	public MemberDTO() {}
	public MemberDTO(int student_id, String name, String email,String major, String pwd, int year) {
		super();
		this.student_id = student_id;
		this.name = name;
		this.email = email;
		this.setMajor(major);
		this.pwd = pwd;
		this.year = year; 
		
	}
	public int getMember_id() {
		return student_id;
	}
	public void setMember_id(int student_id) {
		this.student_id = student_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	
}

package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import util.DB;

public class MemberDAO {
	
	Connection con = DB.getConnection();
	
	 public List<MemberDTO> getAllMembers() throws SQLException {
	        List<MemberDTO> members = new ArrayList<>();

	        Statement statement = null;
	        ResultSet resultSet = null;

	        try {
	            // Create statement
	            statement = con.createStatement();

	            // Execute SQL query
	            String sql = "SELECT * FROM Students";
	            resultSet = statement.executeQuery(sql);

	            // Process the result set
	            while (resultSet.next()) {
	                int student_id = resultSet.getInt("student_id");
	                String name = resultSet.getString("name");
	                String email = resultSet.getString("email");
	                String major = resultSet.getString("major");
	                String pwd = resultSet.getString("pwd");
	                int year = resultSet.getInt("year");

	                // Create a new MemberDTO object
	                MemberDTO member = new MemberDTO(student_id, name, email, major, pwd, year);
	                // Add the MemberDTO object to the list
	                members.add(member);
	            }
	        } finally {
	            // Close the result set, statement, and connection
	            if (resultSet != null) {
	                resultSet.close();
	            }
	            if (statement != null) {
	                statement.close();
	            }
	        }

	        return members;
	    }
	 
	 
	 public boolean  join(String name, String email, String pwd, String major, int year) {
		 PreparedStatement stmt = null;
		 try {
	            String query = "INSERT INTO Students (name, email, pwd, major, year) VALUES (?,?,?,?,?)";
	            stmt = con.prepareStatement(query);
	            
	            stmt.setString(1, name);
	            stmt.setString(2, email);
	            stmt.setString(3, pwd);
	            stmt.setString(4, major);
	            stmt.setInt(5, year);
	            
	            
	            int rowsAffected = stmt.executeUpdate();
	            return rowsAffected > 0;
	        } catch (SQLException e) {
	            e.printStackTrace();
	        } finally {
	            if (stmt != null) {try {stmt.close(); } catch (SQLException e) {e.printStackTrace();}}
	            if (con != null) {try {con.close();} catch (SQLException e) {e.printStackTrace();} }
	        }
	        return false;
	 }
	 
	 public int login(String email, String pwd) {
		 PreparedStatement stmt = null;
	     ResultSet rs = null;
	     int student_id = 0;
		 try {
	            String query = "SELECT student_id FROM Students WHERE email = ? AND pwd = ?";
	            stmt = con.prepareStatement(query);
	            stmt.setString(1, email);
	            stmt.setString(2, pwd);
	            
	            rs = stmt.executeQuery();
	            if(rs.next()) {
	            	student_id = rs.getInt(1);
	            }
	            System.out.print(student_id);
	            
	        } catch (SQLException e) {
	            e.printStackTrace();
	            student_id = -1;
	        } finally {
	            if (rs != null) {try {rs.close();} catch (SQLException e) {e.printStackTrace(); } }
	            if (stmt != null) {try {stmt.close(); } catch (SQLException e) {e.printStackTrace();}}
	            if (con != null) {try {con.close();} catch (SQLException e) {e.printStackTrace();} }
	        }
	        return student_id;
	 }
	
	 
	 
	 
	 
	 
	 
}

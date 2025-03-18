package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;


public class DB {
	
	public static Connection getConnection() {
		try {
			String driver= "com.mysql.cj.jdbc.Driver";
			String URL = "jdbc:mysql://localhost:3306/learning_resource_system" ;;
			// 연결하기
			try {
				Class.forName(driver);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Connection con = DriverManager.getConnection(URL, "root", "wltjsdn123!");
			System.out.println("\n"+URL+"에 연결됨");
		
			return con;
		} catch( SQLException ex ) {
			System.err.println("**  DB connection error: " + ex.getMessage() );
			ex.printStackTrace();
			
		}
		return null;
		}

	}
	
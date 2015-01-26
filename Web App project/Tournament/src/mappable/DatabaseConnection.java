package mappable;

import java.sql.Connection;  
import java.sql.DriverManager;  
import java.sql.PreparedStatement;  
import java.sql.ResultSet;  
import java.sql.SQLException; 

public class DatabaseConnection {
	private String username;
	private String password;

	public DatabaseConnection(String username, String password) {
		this.username = username;
		this.password = password;
	}
	
	public Connection connect(){
		String url = "jdbc:mysql://localhost:3306/";  
        String dbName = "tournament-tracker";  
        String driver = "com.mysql.jdbc.Driver";
		
		try {  
            Class.forName(driver).newInstance();  
            return DriverManager.getConnection(url + dbName, username, password); 
            
        } catch (Exception e) {  
        	e.printStackTrace();
            return null;  
        }
	}

}

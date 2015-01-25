package mappable;

import java.sql.SQLException;

import java.sql.Connection;  
import java.sql.DriverManager;  
import java.sql.PreparedStatement;  
import java.sql.ResultSet;  
import java.sql.SQLException;  

public class User extends Mappable {
	private String first_name;
	private String last_name;
	private String email;
	
	public User(String name) {
		super();
		this.first_name = name;
		this.last_name = name;
		this.email = name;
	}

	// User-specific methods
	public String name(){
		return first_name + " " + last_name;
	}
	
	public String get_email(){ return email; }
	public String get_first_name(){ return first_name; }
	public String get_last_name(){ return last_name; }
	
	
	/**
	 * This method will return a user if it exists in the database
	 * @param username
	 * @param password
	 * @return User or null
	 */
	public static User find_by_authentication(String username, String password){
		System.out.println("Attempting to log in...");
		
		Connection conn = (Connection) new DatabaseConnection("root","root").connect();
		User user = null;
		
		if (conn == null)
			return user;
		
		try {
			PreparedStatement pst = conn.prepareStatement("select * from users where username=? and password=?");
			pst.setString(1, username);
			pst.setString(2, password);
			
			ResultSet rs = pst.executeQuery();
			
			if (rs.next()){
				user = new User(rs.getString(2));
				System.out.println("USER FOUND!!");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;  
	}
	
	
	
	
	
	
	
	// Mappable Methods
	public boolean save() {
		// Run before save callbacks
		before_save();
		
		// Validate User
		if (!validate())
			return false; // Return false if 
		
		// TODO SQL here
		return true;
	}

	public boolean validate() {
		boolean status = true;
		Connection conn = new DatabaseConnection("root","root").connect();
		PreparedStatement pst = null;
		ResultSet rs = null;
		
		//UNIQUE EMAILS ONLY
		try {
			pst = conn.prepareStatement("select * from users where email=?");
			pst.setString(1, email);
			rs = pst.executeQuery();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			return false;
		}
		
		
		
		return status;
	}

	public boolean destroy() {
		// TODO Auto-generated method stub
		return false;
	}

	public void before_save() {
		// TODO Auto-generated method stub

	}

	public void after_save() {
		// TODO Auto-generated method stub

	}

	/*	This method will be used to find a User if we already know the ID
	 *	It will make for easier to read code elsewhere
	 */
	public Mappable find(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	// This will return an array of users (or we can change to a list of something)
	// based on a passed in SQL query
	public Mappable[] where(String query) {
		// TODO Auto-generated method stub
		return null;
	}

	// This I plan to allow a HashMap where keys are attributes and values are attributes to match
	// Not sure how I want to do that yet, we can place it on the back burner
	public Mappable[] where() {
		// TODO Auto-generated method stub
		return null;
	}

}

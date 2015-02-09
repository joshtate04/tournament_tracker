package mappable;

import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Connection;  
import java.sql.DriverManager;  
import java.sql.PreparedStatement;  
import java.sql.ResultSet;  
import java.sql.SQLException;  
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

public class User extends Mappable {
	private String firstname;
	private String lastname;
	private String email;
	private String password;
	private String password_confirmation;
	private int id;
	private String username;
	private String session_id;
	
	public final int MIN_PASSWORD_LENGTH = 8;
	
	public User(HashMap<String, Object> attributes) {
		super();
		if(attributes.containsKey("firstname"))
			this.firstname = attributes.get("firstname").toString();
		if(attributes.containsKey("lastname"))
			this.lastname = attributes.get("lastname").toString();
		if(attributes.containsKey("email"))
			this.email = attributes.get("email").toString();
		if(attributes.containsKey("username"))
			this.username = attributes.get("username").toString();
		if(attributes.containsKey("id"))
			this.id = Integer.parseInt(attributes.get("id").toString());
	}
	
	
	public static User find_by_session(String session_id) {
		System.out.println("Authenticating user...");
		Connection conn = (Connection) new DatabaseConnection().connect();
		User user = null;
		
		if (conn == null)
			return user;
		
		try {
			PreparedStatement pst1 = conn.prepareStatement("select user_id from sessions where session_id=? AND expiry > ?");
			pst1.setString(1, session_id);
			pst1.setString(2, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()));
			ResultSet rs1 = pst1.executeQuery();
			
			if(rs1.next()){
				PreparedStatement pst2 = conn.prepareStatement("select * from users where id=?");
				pst2.setString(1, Integer.toString(rs1.getInt("user_id")));
				
				ResultSet rs2 = pst2.executeQuery();
				ResultSetMetaData md = rs2.getMetaData();
				HashMap<String, Object> datamap = new HashMap<String, Object>();
				
				if (rs2.next()){
					for(int i = 1; i <= md.getColumnCount(); ++i)
						datamap.put(md.getColumnName(i), rs2.getObject(i));
					
					user = new User(datamap);
					System.out.println("USER FOUND!!");
				}
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user; 
	}

	// User-specific methods
	public String name(){
		return firstname + " " + lastname;
	}
	
	public String get_email(){ return email; }
	public String get_first_name(){ return firstname; }
	public String get_last_name(){ return lastname; }
	
	
	/**
	 * This method will return a user if it exists in the database
	 * @param username
	 * @param password
	 * @return User or null
	 */
	public static User find_by_authentication(String username, String password){
		System.out.println("Attempting to log in...");
		
		//Move to the Login Servlet
		Connection conn = (Connection) new DatabaseConnection().connect();
		User user = null;
		
		if (conn == null)
			return user;
		
		try {
			PreparedStatement pst = conn.prepareStatement("select id from users where username=? and password=?");
			pst.setString(1, username);
			pst.setString(2, password);
			
			ResultSet rs = pst.executeQuery();
			ResultSetMetaData md = rs.getMetaData();
			HashMap<String, Object> datamap = new HashMap<String, Object>();
			
			if (rs.next()){
				for(int i = 1; i <= md.getColumnCount(); ++i)
					datamap.put(md.getColumnName(i), rs.getObject(i));
				
				user = new User(datamap);
				System.out.println("USER FOUND!!");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user;  
	}

	public String SessionID(){
		return session_id;
	}

	public boolean CreateSession(String session_id){
		this.session_id = session_id;
		Connection conn = (Connection) new DatabaseConnection().connect();
		
		if (conn == null)
			return false;
		
		try {
			PreparedStatement pst = conn.prepareStatement("INSERT INTO sessions (session_id,user_id,expiry) VALUES(?,?,?)");
			pst.setString(1, session_id);
			pst.setString(2, Integer.toString(id));
			pst.setString(3, SetSessionExpiry());
			pst.execute();
			return true;
		}
		catch (SQLException e){
			e.printStackTrace();
			return false;
		}
	}
	
	private String SetSessionExpiry(){
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, 1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		return sdf.format(cal.getTime());
	}
	
	
	
	
	// Mappable Methods
	public boolean save() {
		// Run before save callbacks
		
		
		// Validate User
		if (!validate())
			return false; // Return false if 
		
		// TODO SQL here
		after_save();
		return true;
	}

	public boolean validate() {
		boolean status = true;
		Connection conn = new DatabaseConnection().connect();
		PreparedStatement pst = null;
		ResultSet rs = null;
		
		
		//UNIQUE EMAILS ONLY
		try {
			pst = conn.prepareStatement("select * from users where email=?");
			pst.setString(1, email);
			rs = pst.executeQuery();
			
		} catch (SQLException e) {
			add_error("Email", "email is already taken");
			status = false;
		}
		
		//PASSWORD MUST BE AT LEAST 8 CHARS
		if (password != null){
			if (password.length() < MIN_PASSWORD_LENGTH){
				status = false;
				add_error("Password","must be at least "+MIN_PASSWORD_LENGTH+" characters long");
			}
		}
		
		//PASSWORD MUST MATCH (IF PRESENT)
		if (password != null || password_confirmation != null){
			if (!password.equals(password_confirmation)){
				status = false;
				add_error("Password Confirmation","does not match password");
			}
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

	private void add_error(String key, String error_message){
		
	}
	
	public void after_save() {
		password = null;
		password_confirmation = null;

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

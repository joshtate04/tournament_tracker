package mappable;

import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Connection;  
import java.sql.DriverManager;  
import java.sql.PreparedStatement;  
import java.sql.ResultSet;  
import java.sql.SQLException;  
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
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
	private String regdate;
	private int permission;
	
	public final int MIN_PASSWORD_LENGTH = 8;
	
	/**
	 * This constructor instantiates a User using the attributes passed into it
	 * @param attributes
	 */
	public User(HashMap<String, Object> attributes) {
		super();
		
		// For each attribute, try and pull from the hashmap
		if(attributes.containsKey("firstname"))
			this.firstname = attributes.get("firstname").toString();
		
		if(attributes.containsKey("lastname"))
			this.lastname = attributes.get("lastname").toString();
		
		if(attributes.containsKey("email"))
			this.email = attributes.get("email").toString();
		
		if(attributes.containsKey("username"))
			this.username = attributes.get("username").toString();
		
		if(attributes.containsKey("password"))
			this.password = attributes.get("password").toString();
		
		if(attributes.containsKey("id"))
			this.id = Integer.parseInt(attributes.get("id").toString());
		else
			this.id = 0;
		
		if(attributes.containsKey("regdate"))
			this.regdate = attributes.get("regdate").toString();
		
		//Default Permission
		permission = 0;
		
		System.out.println(this.toString());
	}
	
	/**
	 * Returns a User object if a session exists for it.
	 * @param session_id
	 * @return User if found, null if not found
	 */
	public static User find_by_session(String session_id) {
		System.out.println("Authenticating user...");
		Connection conn = (Connection) new DatabaseConnection().connect();
		User user = null;
		
		// Check connection
		if (conn == null)
			return user;
		
		try {
			// Check db if session_id exists and what user it belongs to
			PreparedStatement pst1 = conn.prepareStatement("select user_id from sessions where session_id=? AND expiry > ?");
			pst1.setString(1, session_id);
			pst1.setString(2, new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime()));
			ResultSet rs1 = pst1.executeQuery();
			
			// Session is found, find user
			if(rs1.next()){
				PreparedStatement pst2 = conn.prepareStatement("select * from users where id=?");
				pst2.setString(1, Integer.toString(rs1.getInt("user_id")));
				
				ResultSet rs2 = pst2.executeQuery();
				ResultSetMetaData md = rs2.getMetaData();
				HashMap<String, Object> datamap = new HashMap<String, Object>();
				
				// User is found, build map and create user object
				if (rs2.next()){
					for(int i = 1; i <= md.getColumnCount(); ++i)
						datamap.put(md.getColumnName(i), rs2.getObject(i));
					
					user = new User(datamap);
					System.out.println("USER FOUND!!");
				}
			}
		// Error occurred	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return user; 
	}

	/**
	 * Adds first and last names together
	 * @return String name
	 */
	public String name(){
		return firstname + " " + lastname;
	}
	
	// Get methods
	public String get_email(){ return email; }
	public String get_first_name(){ return firstname; }
	public String get_last_name(){ return lastname; }
	public String get_reg_date(){ return regdate; }
	
	
	/**
	 * This method will return a user if it exists in the database
	 * @param username
	 * @param password
	 * @return User or null
	 */
	public static User find_by_authentication(String username, String password){
		System.out.println("Attempting to log in...");
		
		//TODO Move to the Login Servlet
		Connection conn = (Connection) new DatabaseConnection().connect();
		User user = null;
		
		//Check connection
		if (conn == null)
			return user;
		
		try {
			//Find User by username and password
			PreparedStatement pst = conn.prepareStatement("select id from users where username=? and password=?");
			pst.setString(1, username);
			pst.setString(2, password);
			
			ResultSet rs = pst.executeQuery();
			ResultSetMetaData md = rs.getMetaData();
			HashMap<String, Object> datamap = new HashMap<String, Object>();
			
			//User is found, build map and create User
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

	/**
	 * Creates a session for a User using the passed string
	 * @param session_id
	 * @return true if successfully created, false if it fails
	 */
	public boolean CreateSession(String session_id){
		this.session_id = session_id;
		Connection conn = (Connection) new DatabaseConnection().connect();
		
		//Check connection
		if (conn == null)
			return false;
		
		try {
			// Insert session
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
	
	/**
	 * Creates expiry date for a session token
	 * @return String date
	 */
	private String SetSessionExpiry(){
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DATE, 1);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		return sdf.format(cal.getTime());
	}
	
	
	
	
	/**
	 * Saves user to database
	 * Will call validate to make sure attributes are valid before committing to the database
	 * before_save() and after_save() methods are also called
	 */
	public boolean save() {
		// Run before save callbacks
		
		
		// Validate User
		if (!validate())
			return false; // Return false if 
		
		Connection conn = new DatabaseConnection().connect();
		try {
			PreparedStatement pst = conn.prepareStatement("INSERT INTO users "
					+ "(username,email,password,firstname,lastname,permission,regdate) "
					+ "VALUES(?,?,?,?,?,?,CURDATE())");
			pst.setString(1, username);
			pst.setString(2, email);
			pst.setString(3, password);
			pst.setString(4, firstname);
			pst.setString(5, lastname);
			pst.setInt(6, permission);
			pst.execute();
			
			PreparedStatement pst_id = conn.prepareStatement("SELECT id FROM users "
					+ "WHERE email=?");
			pst_id.setString(1, email);
			ResultSet rs = pst_id.executeQuery();
			rs.next();
			id = rs.getInt("id");
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

		
		after_save();
		return true;
	}

	/**
	 * Validates attributes
	 * Returns true if successful, false if not
	 */
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
			
			if(rs.next()){
				if(id == 0 || id != rs.getInt("id")){
					add_error("email","This email is already taken");
					status = false;
				}
			}

			
		} catch (SQLException e) {
			add_error("Email", "This email is already taken");
			status = false;
		}
		
		//UNIQUE USERNAMES
		try {
			pst = conn.prepareStatement("select * from users where username=?");
			pst.setString(1, username);
			rs = pst.executeQuery();
			if(rs.next()){
				if(id == 0 || id != rs.getInt("id")){
					add_error("username","This username is already taken");
					status = false;
				}
			}
			
			
		} catch (SQLException e) {
			add_error("username", "This username is already taken");
			status = false;
		}
		
		//PASSWORD MUST BE AT LEAST 8 CHARS
		if (password != null){
			if (password.length() < MIN_PASSWORD_LENGTH){
				System.out.println("NOT MIN LENGTH");
				status = false;
				add_error("password","Your password must be at least "+MIN_PASSWORD_LENGTH+" characters long");
			}
		}
		
		//PASSWORD MUST NOT BE EMPTY IF NEW USER
		if(id == 0 && password == null){
			status = false;
			add_error("password","You must enter a password");
		}

		//FIRST NAME MUST NOT BE EMPTY
		if(firstname == null){
			status = false;
			add_error("firstname","You must enter a first name");
		}
		
		//LAST NAME MUST NOT BE EMPTY
		if(lastname == null){
			status = false;
			add_error("lastname","You must enter a last name");
		}
		
		//USERNAME MUST NOT BE EMPTY
		if(username == null){
			status = false;
			add_error("username","You must enter a username");
		}
		
		//EMAIL ADDRESS MUST NOT BE EMPTY
		if(email == null){
			status = false;
			add_error("email","You must enter an email address");
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

	/**
	 * Adds error for an attribute
	 * @param key
	 * @param error_message
	 */
	private void add_error(String attribute, String error_message){
		errors.put(attribute, error_message);
	}
	
	public void after_save() {
		
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

		return null;
	}

	// This I plan to allow a HashMap where keys are attributes and values are attributes to match
	// Not sure how I want to do that yet, we can place it on the back burner
	public Mappable[] where() {
		// TODO Auto-generated method stub
		
		
		
		return null;
	}

}

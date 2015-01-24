package mappable;

public class User extends Mappable {
	private String first_name;
	private String last_name;
	private String email;
	
	public User(String first_name, String last_name, String email) {
		this.first_name = first_name;
		this.last_name = last_name;
		this.email = email;
	}

	// User-specific methods
	public String name(){
		return first_name + " " + last_name;
	}
	
	public String get_email(){ return email; }
	public String get_first_name(){ return first_name; }
	public String get_last_name(){ return last_name; }
	
	
	
	
	
	
	
	
	
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
		// TODO Auto-generated method stub
		return false;
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

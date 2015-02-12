package mappable;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public abstract class Mappable {
	protected int id;
	protected HashMap<String,String> errors;
	
	public Mappable(){
		errors = new HashMap<String,String>();
	}
	
	// Instance CRUD methods
	public abstract boolean save();
	public abstract boolean validate();
	public abstract boolean destroy();
	
	// Callbacks
	public abstract void before_save();
	public abstract void after_save();
	
	// DB Methods
	public abstract Mappable find(int id);
	public abstract Mappable[] where(String query);
	public abstract Mappable[] where();
	
	public HashMap<String,String> errors(){
		return errors;
	}
}

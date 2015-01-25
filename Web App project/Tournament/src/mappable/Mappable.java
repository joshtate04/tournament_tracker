package mappable;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public abstract class Mappable {
	private int id;
	
	public Mappable(){
		
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
}

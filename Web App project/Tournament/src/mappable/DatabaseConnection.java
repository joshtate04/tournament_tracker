package mappable;

import org.yaml.snakeyaml.Yaml;


import java.io.InputStream;
import java.sql.Connection;  
import java.sql.DriverManager; 
import java.util.Map;

public class DatabaseConnection {
	private String username;
	private String password;
	private String dbName;
	private String port;
	private String driver;
	private String url;
	private Yaml yaml;

	public DatabaseConnection() {
		yaml = new Yaml();
		try {
			
			InputStream input = this.getClass().getClassLoader().getResourceAsStream("mappable/config.yml");
			//yaml.load(input);
			@SuppressWarnings("unchecked")
			Map<String,Object> result = (Map<String,Object>)yaml.load(input);
			System.out.println(result.toString());
			
			@SuppressWarnings("unchecked")
			Map<String,Object> params = (Map<String, Object>) result.get("database");
			username = (String)params.get("username");
			password = (String)params.get("password");
			url = (String)params.get("url");
			dbName = (String)params.get("dbName");
			port = (String)params.get("port").toString();
			driver = (String)params.get("driver");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			yaml = null;
			e.printStackTrace();
		}
		
		
	}
	
	private String connectionParams(){
		return url+":"+port+"/";
	}
	
	public Connection connect(){
		if(yaml == null){ return null; }
		
		try {  
            Class.forName(driver).newInstance();  
            return DriverManager.getConnection(connectionParams() + dbName, username, password); 
            
        } catch (Exception e) {  
        	e.printStackTrace();
            return null;  
        }
	}

}

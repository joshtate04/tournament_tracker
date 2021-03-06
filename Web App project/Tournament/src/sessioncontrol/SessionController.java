package sessioncontrol;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import mappable.DatabaseConnection;
import mappable.User;

public class SessionController {

	public SessionController() {
		
	}
	
	//TODO We may use this as validation, for now, we are using CurrentUser()
	public String ValidateSession(String url_if_found, String url_if_invalid, HttpServletRequest request){		
		if (!ValidSession(request) || User.find_by_session(request.getSession().getAttribute("session_id").toString()) == null)
			return url_if_found;
					
		return url_if_invalid;
	}
	
	
	/**
	 * Returns the currently logged in User object
	 * @param request
	 * @return User if logged in, null if not
	 */
	public static User CurrentUser(HttpServletRequest request){
		System.out.println("Checking current user");
		if(ValidSession(request))
			return User.find_by_session(request.getSession().getAttribute("session_id").toString());
		
		return null;
	}
	
	//TODO Used in ValidateSession()
	private static boolean ValidSession(HttpServletRequest request){
		return request.getSession().getAttribute("session_id") != null;
	}
	
	/**
	 * Destroys the current session
	 * @param request
	 */
	public static void DestroySession(HttpServletRequest request){
		Connection conn = (Connection) new DatabaseConnection().connect();
		PreparedStatement pst;
		try {
			//Remove session from table
			pst = conn.prepareStatement("DELETE FROM sessions WHERE session_id=?");
			pst.setString(1, request.getSession().getAttribute("session_id").toString());
			pst.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// Clear session
		request.getSession().setAttribute("session_id", null);
	}

}

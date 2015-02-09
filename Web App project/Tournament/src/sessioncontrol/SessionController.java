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
	
	public String ValidateSession(String url_if_found, String url_if_invalid, HttpServletRequest request){		
		if (!ValidSession(request) || User.find_by_session(request.getSession().getAttribute("session_id").toString()) == null)
			return url_if_found;
					
		return url_if_invalid;
	}
	
	
	
	public static User CurrentUser(HttpServletRequest request){
		if(ValidSession(request))
			return User.find_by_session(request.getSession().getAttribute("session_id").toString());
		
		return null;
	}
	
	private static boolean ValidSession(HttpServletRequest request){
		return request.getSession().getAttribute("session_id") != null;
	}
	
	public static void DestroySession(HttpServletRequest request){
		Connection conn = (Connection) new DatabaseConnection().connect();
		PreparedStatement pst;
		try {
			pst = conn.prepareStatement("DELETE FROM sessions WHERE session_id=?");
			pst.setString(1, request.getSession().getAttribute("session_id").toString());
			pst.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.getSession().setAttribute("session_id", null);
	}

}

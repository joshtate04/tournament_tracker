package com.amzi.servlets;  
  
import java.io.IOException;  
import java.io.PrintWriter;  
import java.math.BigInteger;

import javax.servlet.RequestDispatcher;  
import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession; 

import java.security.SecureRandom;
import java.sql.*; 

import mappable.DatabaseConnection;
import mappable.User;

public class RegisterServlet extends HttpServlet{  
  
    private static final long serialVersionUID = 1L;  
  
    public void doPost(HttpServletRequest request, HttpServletResponse response)    
            throws ServletException, IOException {    
  
        response.setContentType("text/html");    
        PrintWriter out = response.getWriter();    
        String usr = request.getParameter("username");    
        String pwd = request.getParameter("password");
        String fname = request.getParameter("firstname");
        String lname = request.getParameter("lastname");
        String email = request.getParameter("email");
        int permission =  0;
        int i = 0;
        //connect to database
        Connection conn = (Connection) new DatabaseConnection().connect();
        
        //todo validate data
        
        //add new user data to database
		try {
			PreparedStatement pst = conn.prepareStatement("insert into users(username, password, firstname, lastname, email, permission, regdate) VALUES(?,?,?,?,?,?,CURDATE())");
			pst.setString(1, usr);
			pst.setString(2, pwd);
			pst.setString(3, fname);
			pst.setString(4, lname);
			pst.setString(5, email);
			pst.setInt(6, permission);
			pst.execute();
			i = 1;
			
		}catch (SQLException e){
			e.printStackTrace();
			i = 0;
		}
		//data was added succesfully, retrieve data for session
		if (i > 0) {
        	 User user = User.find_by_authentication(usr,pwd);
             //if user is not null
        	 if (user != null) {
     			HttpSession session = request.getSession(false);
     			if (session != null)
     				session.setAttribute("username", usr);

     			//create a new session id to store in database
     			String session_id = new BigInteger(130, new SecureRandom())
     					.toString(32);
     			//store the session in database
     			user.CreateSession(session_id);
     			session.setAttribute("session_id", session_id);

     			//show welcome screen
     			RequestDispatcher rd = request
     					.getRequestDispatcher("/Login/welcome.jsp");
     			rd.forward(request, response);
     		} else {//user does not exists, login failed
     			RequestDispatcher rd = request
     					.getRequestDispatcher("/Login/signup.jsp");
     			response.addHeader("login", "fail");
     			rd.forward(request, response);
     		}
      
        } else {//login failed
        	RequestDispatcher rd = request
 					.getRequestDispatcher("/Login/signup.jsp");
 			response.addHeader("login", "fail");
 			rd.forward(request, response);
        }
        out.close();    
    }
  
}   
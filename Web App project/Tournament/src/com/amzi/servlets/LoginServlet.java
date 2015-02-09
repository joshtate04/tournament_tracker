package com.amzi.servlets;  
  
import java.io.IOException;  
import java.io.PrintWriter;  
  
import java.math.BigInteger;
import java.security.SecureRandom;

import javax.servlet.RequestDispatcher;  
import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession;  
  
import mappable.User;
  
import sessioncontrol.*;

public class LoginServlet extends HttpServlet{  
  
    private static final long serialVersionUID = 1L;  
  
    public void doPost(HttpServletRequest request, HttpServletResponse response)    
            throws ServletException, IOException {    
<<<<<<< HEAD
  
        response.setContentType("text/html");    
        PrintWriter out = response.getWriter();    
          
        String n=request.getParameter("username");    
        String p=request.getParameter("password");   
  
        User user = User.find_by_authentication(n,p);
        if(user != null){
            HttpSession session = request.getSession(false);  
            if(session!=null)  
            	session.setAttribute("username", n);  

            RequestDispatcher rd=request.getRequestDispatcher("/Login/welcome.jsp");    
            rd.forward(request,response);
        }    
        else{     
            RequestDispatcher rd=request.getRequestDispatcher("Login/login.jsp");
            response.addHeader("login", "fail");
=======
    	response.setContentType("text/html");    
        PrintWriter out = response.getWriter(); 
    	if(SessionController.CurrentUser(request) != null) {
    		RequestDispatcher rd=request.getRequestDispatcher("/Login/welcome.jsp");    
>>>>>>> origin/Josh
            rd.forward(request,response);
    	}
    	else {
    		String n=request.getParameter("username");    
	        String p=request.getParameter("password");   
	  
	        User user = User.find_by_authentication(n,p);
	        
	        if(user != null){
	            HttpSession session = request.getSession(false);  
	            if(session!=null)  
	            	session.setAttribute("name", n);  

	            String session_id = new BigInteger(130, new SecureRandom()).toString(32);
	
	            user.CreateSession(session_id);
	            session.setAttribute("session_id", session_id);
	            
	            RequestDispatcher rd=request.getRequestDispatcher("/Login/welcome.jsp");    
	            rd.forward(request,response);
	        }    
	        else{     
	            RequestDispatcher rd=request.getRequestDispatcher("/Login/login.jsp");
	            response.addHeader("login", "fail");
	            rd.forward(request,response);
	        }    
    	}
  
        out.close();    
    }    
}   
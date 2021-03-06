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
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import mappable.DatabaseConnection;
import mappable.User;

public class RegisterServlet extends HttpServlet{  
  
    private static final long serialVersionUID = 1L;  
  
    public void doPost(HttpServletRequest request, HttpServletResponse response)    
            throws ServletException, IOException {    
  
    	//Build datamap from input
        HashMap<String,Object> datamap = new HashMap<String,Object>();
        if(!request.getParameter("username").isEmpty())
        	datamap.put("username", request.getParameter("username"));
        if(!request.getParameter("password").isEmpty())
        	datamap.put("password", request.getParameter("password"));
        if(!request.getParameter("firstname").isEmpty())
        	datamap.put("firstname", request.getParameter("firstname"));
        if(!request.getParameter("lastname").isEmpty())
        	datamap.put("lastname", request.getParameter("lastname"));
        if(!request.getParameter("email").isEmpty())
        	datamap.put("email", request.getParameter("email"));
        
        //DEBUG
        System.out.println(request.getParameter("password"));
        
        //Create User object
		User user = new User(datamap);
		
		//User successfully saves
		if(user.save()){
			//DEBUG
			System.out.println("User saved!");
			//Create session_id and assign to user/current session
			String session_id = new BigInteger(130, new SecureRandom()).toString(32);
			user.CreateSession(session_id);
			request.getSession().setAttribute("session_id", session_id);
			//DEBUG
			System.out.println("Sign up succeeded");
			response.sendRedirect("/UserPage/UserPage.jsp");
		}
		else {
			//Keep user attributes to resubmit form
			Iterator param_iterator = datamap.entrySet().iterator();
			while(param_iterator.hasNext()){
				Map.Entry pair = (Map.Entry)param_iterator.next();
				System.out.println("DATAMAP: "+pair.toString());
				response.addHeader(pair.getKey().toString(), pair.getValue().toString());
			}
			
			//Build errors to attach to form
			Iterator error_iterator = user.errors().entrySet().iterator();
			while(error_iterator.hasNext()){
				Map.Entry pair = (Map.Entry)error_iterator.next();
				//DEBUG
				System.out.println("ERROR: "+pair.toString());
				response.addHeader(pair.getKey().toString()+"_error", pair.getValue().toString());
			}
			//DEBUG
			System.out.println("Sign up failed");
			response.addHeader("signup", "fail");
			RequestDispatcher rd = request
					.getRequestDispatcher("/Login/signup.jsp");
			//DEBUG
			System.out.println(response.containsHeader("email"));
			rd.forward(request, response);
		}
    }
  
}   
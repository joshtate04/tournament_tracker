package com.amzi.servlets;

import java.io.IOException;

import javax.servlet.http.*;

import sessioncontrol.SessionController;

public class LogoutServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public LogoutServlet() {
		// TODO Auto-generated constructor stub
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response){
		
		try {
			SessionController.DestroySession(request);
			response.sendRedirect("/index.jsp");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}

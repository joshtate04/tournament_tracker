package com.amzi.servlets;  
  
import java.io.IOException;  
import java.io.PrintWriter;  

import javax.servlet.RequestDispatcher;  
import javax.servlet.ServletException;  
import javax.servlet.http.HttpServlet;  
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
import javax.servlet.http.HttpSession; 

import java.sql.*;

import com.amzi.dao.LoginDao;  

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
        Statement st = null;
        Connection con = null;
        try {
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tournament-tracker",
		                "root", "");
		   st = con.createStatement();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
      
        //try to add user to db
        int i = 0;
		try {
			i = st.executeUpdate("insert into users(username, password, firstname, lastname, email, permission, regdate) values ('" + usr + "','" + pwd + "','" + fname + "','" + lname + "','" + email + "','" + permission+ "', CURDATE())");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (i > 0) {
        	 User user = User.find_by_authentication(usr,pwd);
        	 if(user != null){
                 HttpSession session = request.getSession(false);  
                 if(session!=null)  
                 	session.setAttribute("username", usr); 
                 	session.setAttribute("fname", fname); 
                 	session.setAttribute("lname", lname); 
                 	session.setAttribute("email", email); 
                 	session.setAttribute("permission", permission); 

                 RequestDispatcher rd=request.getRequestDispatcher("/Login/welcome.jsp");    
                 rd.forward(request,response);
             }    
             else{     
                 RequestDispatcher rd=request.getRequestDispatcher("Login/signup.jsp");
                 response.addHeader("login", "fail");
                 rd.forward(request,response);
             }    
       
        	
            response.sendRedirect("welcome.jsp");
           // out.print("Registration Successfull!"+"<a href='index.jsp'>Go to Login</a>");
        } else {
            response.sendRedirect("/Login/signup.jsp");
        }
        out.close();    
    }
  
}   
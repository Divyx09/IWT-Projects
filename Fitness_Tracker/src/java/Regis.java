import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
public  class Regis extends HttpServlet
{
	public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException,IOException
	{
		PrintWriter out=response.getWriter();
		String s1=request.getParameter("u1");
                String s2=request.getParameter("u2");
                String s3=request.getParameter("u3");
		out.println("<html>");
		out.println("<body>");
		try
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql:///fit?useSSL=false","root","root");
			Statement st=con.createStatement();
			String q="insert into Users values('"+s1+"','"+s2+"','"+s3+"')";
		int x=st.executeUpdate(q);
			response.sendRedirect("login.html");
			con.close();
			
		}
		catch(Exception e)
		{
		 out.println(e);
		}
		
		out.println("</body>");
		out.println("</html>");
		out.close();
	}
}
//set classpath=C:\Program Files\Apache Software Foundation\Tomcat 8.5\lib\servlet-api.jar;.;%classpath%
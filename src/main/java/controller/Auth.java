package controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Reservation;
import dao.GestionClient;
import dao.GestionReservation;

/**
 * Servlet implementation class Auth
 */
@WebServlet("/Auth")
public class Auth extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	String token = request.getParameter("token");
	ArrayList<Reservation> ar = new ArrayList<Reservation>();
	String clientCin = new GestionClient().GetClientByToken(token);
	System.out.println(ar.size());
	ar.addAll(new GestionReservation().GetReservationByCinClient(clientCin));
	System.out.println(ar.size());	
	if(ar.size() == 0) {
		request.setAttribute("error", "Vous n'avez pas encore une reservation chez nouz !");
		request.getRequestDispatcher("MesRes.jsp").forward(request, response);
	}
	else{	
	request.setAttribute("AllReservations", ar);
	request.getRequestDispatcher("Reservations.jsp").forward(request, response);
	}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("method").equals("update")) {
			int id = Integer.parseInt(request.getParameter("id"));		
			String dated = request.getParameter("dated");
			String datef = request.getParameter("datef");
						
				if(new GestionReservation().UpdateDatesReservation(id, LocalDate.parse(dated),LocalDate.parse(datef))) {	
						response.getWriter().print("done");
					
				}else {
					response.getWriter().print("no");
				}

		}else {
			if(new GestionReservation().DeleteReservation(Integer.parseInt(request.getParameter("id")))) {
				response.getWriter().print("yes");
			}else {
				response.getWriter().print("no");
			}
			
		}
		
			
	}

}

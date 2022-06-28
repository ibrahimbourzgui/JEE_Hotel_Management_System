package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.Chambre;
import dao.GestionChambre;
import dao.GestionClient;
import dao.GestionReservation;

@WebServlet("/Home")
public class Home extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Home() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ArrayList<Chambre> allchambres = new GestionChambre().GetAllChambres();
		request.setAttribute("allchambres", allchambres);
		request.getRequestDispatcher("Acceuil.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String nom = request.getParameter("nom");
		String prenom = request.getParameter("prenom");
		String cin = request.getParameter("cin");
		String telephone = request.getParameter("telephone");

		String prixtotal = request.getParameter("prixtotal");
		String numero = request.getParameter("numero");
		
		String dated = request.getParameter("dated");
		String datef = request.getParameter("datef");
		String generatedToken = getSaltString();
		if(new GestionClient().GetClientByCin(cin) != null) { //client déja existe
			
			if(new GestionReservation().AddReservation(cin, Integer.parseInt(numero),
					LocalDate.parse(dated), LocalDate.parse(datef),Double.parseDouble(prixtotal) , 0)) {	
				new GestionClient().ClientSetGeneratedToken(cin, generatedToken);
					response.getWriter().print(generatedToken);
				
			}else {
				response.getWriter().print("no");
			}	
		}else { // nouveau client
			new GestionClient().AddClient(nom, prenom, telephone, cin , generatedToken);
			if(new GestionReservation().AddReservation(cin, Integer.parseInt(numero),
						LocalDate.parse(dated), LocalDate.parse(datef),Double.parseDouble(prixtotal) , 0)) {	
					new GestionClient().ClientSetGeneratedToken(cin, generatedToken); 
						response.getWriter().print(generatedToken);
				}else {
					response.getWriter().print("no");
				}
		}
	}
	
	protected String getSaltString() {

		  String SALTCHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
		        StringBuilder salt = new StringBuilder();
		        Random rnd = new Random();
		        while (salt.length() < 18) { // length of the random string.
		            int index = (int) (rnd.nextFloat() * SALTCHARS.length());
		            salt.append(SALTCHARS.charAt(index));
		        }
		        String saltStr = salt.toString();
		         
		        return saltStr;
		      		      
		}

    }



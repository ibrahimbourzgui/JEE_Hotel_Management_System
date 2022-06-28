package dao;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;


import bean.Reservation;

public interface IGestionReservation {
	
	// Get Functions
	
	public ArrayList<Reservation> GetReservationByCinClient(String cin);

	//Update Functions
	public boolean UpdateDatesReservation(int id,LocalDate date_debut,LocalDate date_fin);
	
	// Add Functions
	public Boolean AddReservation(String cin, int numero_chambre, LocalDate date_debut,LocalDate date_fin,double prix_total,int confirme);

	// used function 
	public Boolean ActualiserPrixTotal(int id);
	public Boolean DeleteReservation(int id);

	

}

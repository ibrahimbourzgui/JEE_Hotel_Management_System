package dao;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;


import bean.Reservation;
import databaseconnection.GetConnection;

public class GestionReservation implements IGestionReservation{
	

	public ArrayList<Reservation> GetReservationByCinClient(String cin_client) {
		GetConnection.connect();
		ResultSet rs = null;
		rs = GetConnection.Select("select * FROM reservation JOIN client ON reservation.cin_client=client.cin WHERE cin_client='"+cin_client+"'");
		ArrayList<Reservation> ar=new ArrayList<Reservation>();
		try {			
			while (rs.next()) {
				Reservation r = new Reservation();
				r=new Reservation();
				r.setId(rs.getInt("id"));
				r.setCin_client(rs.getString("cin_client"));
				r.setNumero_chambre(rs.getInt("numero_chambre"));
				r.setDate_debut(rs.getDate("date_debut").toLocalDate());
				r.setDate_fin(rs.getDate("date_fin").toLocalDate());
				r.setPrix_total(rs.getDouble("prix_total"));
				r.setConfirme(rs.getInt("confirme"));
				ar.add(r);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		GetConnection.disconnect();
		return ar;
		
		
		}
	
	public boolean UpdateDatesReservation(int id, LocalDate date_debut,LocalDate date_fin) {
		GetConnection.connect();
		int num=0;
		ResultSet dates = GetConnection.Select("Select numero_chambre, date_debut ,date_fin from reservation where id ='"+id+"'");
		LocalDate OldDebut = null;
		LocalDate OldFin = null;
		int numero = 0;
		try {
			if(dates.next()) {
				OldDebut = dates.getDate("date_debut").toLocalDate();
				OldFin = dates.getDate("date_fin").toLocalDate();
				numero = dates.getInt("numero_chambre");
			}
			System.out.println("UpdateDatesReservation : numchambre"+numero);
			System.out.println("UpdateDatesReservation : washempty "+new GestionChambre().IfEmpty(numero, date_debut , id));
			
			if(!new GestionChambre().IfEmpty(numero, date_debut , id)) return false;
			num=GetConnection.Maj("UPDATE reservation SET date_debut='"+date_debut+"',date_fin='"+date_fin+"' where id='"+id+"'");		

			if(num > 0 && ActualiserPrixTotal(id)/* nActualisiw le prixTotal 3la hssab les date jdaad */) {
				System.out.println("UpdateDatesReservation : koulshi mzyan ");

			}
			else {
				
				System.out.println("UpdateDatesReservation : koulshi mamzyanch");

				GetConnection.Maj("UPDATE reservation SET date_debut='"+OldDebut+"',date_fin='"+OldFin+"' where id='"+id+"'");
				return false;
			};
		} 
		catch (Exception e) {
			return false;
		}	
		GetConnection.disconnect();
		if(num > 0)
		return true;
		else return false;	
	}
	
	// Add Function
	public Boolean AddReservation(String cin_client, int numero_chambre, LocalDate date_debut,LocalDate date_fin,double prix_total,int confirme){
		
		int num=0,n=0;
		try {
			boolean empty = new GestionChambre().IfEmpty(numero_chambre,date_debut,0);
			System.out.println("empty = "+empty);
			if(!empty) return false; 
			GetConnection.connect();
			num=GetConnection.Maj("insert into reservation (cin_client, numero_chambre,date_debut,date_fin, prix_total,confirme) values"
						+ "('"+cin_client+"','"+numero_chambre+"','"+date_debut+"','"+date_fin+"','"+prix_total+"','"+confirme+"')");
			System.out.println("num=  : "+num);
			new GestionChambre().SetChambreOnServiceFalse(numero_chambre);
		}catch (Exception e) {
			 return false;
		}
		GetConnection.disconnect();
		if(num == 0) return false;
		else return true;
	}
	
	public Boolean ActualiserPrixTotal(int id) {
		GetConnection.connect();
		int num=0;
		double prixTotal=0;
			try {
				
				ResultSet rs= GetConnection.Select("select r.date_debut ,r.date_fin , c.prix FROM reservation r, chambre c"
						+ " where r.id = '"+id+"' and r.numero_chambre = c.numero ");
				if(rs.next()){
				prixTotal = ChronoUnit.DAYS.between(rs.getDate("date_debut").toLocalDate(), rs.getDate("date_fin").toLocalDate())*rs.getDouble("prix");
				num = GetConnection.Maj("update reservation set prix_total = '"+prixTotal+"' where id = "+id);
				}
				else return false;
			} 
			catch (Exception e) {
				return false;
			}
			
		GetConnection.disconnect();
		if(num > 0)
		return true;
		else return false;
	};
	
	public Boolean DeleteReservation(int id) {
		GetConnection.connect();
		int num=0, numero= 0;
		ResultSet rs = null;
		try {
			rs = GetConnection.Select("select * from reservation where id='"+id+"'");
			rs.next();
			numero = rs.getInt("numero_chambre");
			num=GetConnection.Maj("DELETE FROM reservation WHERE id='"+id+"'");
		} 
		catch(Exception e) {
			return false;
		}
		GetConnection.disconnect();
		if(num > 0 ) {
			new GestionChambre().SetChambreOnServiceTrue(numero);
			return true;
		}
		else return false;
		}
	
	
	public static void main(String[] args) throws ParseException {

	}
}



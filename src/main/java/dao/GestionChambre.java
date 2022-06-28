package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;

import databaseconnection.GetConnection;
import bean.Chambre;

public class GestionChambre implements IGestionChambre {

	// Get Functions Start 
	@Override
	public ArrayList<Chambre> GetAllChambres(){
		GetConnection.connect();
		
		ResultSet rs = null;
		rs = GetConnection.Select("select * from chambre where disponibilité > 0 ");
		ArrayList<Chambre> ChambreList = new ArrayList<>();
		try{
			while(rs.next()) {
					ChambreList.add(new Chambre(rs.getInt("id"),rs.getInt("numero"),rs.getString("type"),
							rs.getInt("enservice"),rs.getDouble("prix"),rs.getInt("disponibilité")));
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		GetConnection.disconnect();
		if(ChambreList.size()>0)
			return ChambreList;
		else 
			return null;
	}
	@Override
	public Double GetChambrePrixByNum(int num) {
		GetConnection.connect();
		ResultSet rs = null;
		rs = GetConnection.Select("select prix from chambre where numero = '"+num+"'");
		Double c = 0.0;
		try{
			while(rs.next()) {
					c = rs.getDouble("prix");
			}
		}catch (SQLException e) {
			System.out.println(e.getMessage()+"  GetChambrePrixByNum");
		}
		GetConnection.disconnect();
		System.out.println("L9it lprix : "+ c);
		return c;
	}
	public Boolean IfEmpty(int numero ,LocalDate dateDebut ,int id){
		GetConnection.connect();
		ResultSet rs = null;
		ResultSet rs2 = null;
		if(id>0)
		rs = GetConnection.Select("select MAX(date_fin) from reservation where numero_chambre = "+numero+" and id <> "+id+"");
		else
		rs = GetConnection.Select("select MAX(date_fin) from reservation where numero_chambre = "+numero+"");

		rs2 = GetConnection.Select("select numero from chambre where disponibilité > '0'  and numero = "+numero+" and numero not in (select numero_chambre from reservation)");
			try {
			rs.next();
			long diff_dates = -1;
			if(rs.getString("MAX(date_fin)") != null)
				{diff_dates = ChronoUnit.DAYS.between(LocalDate.parse(rs.getString("MAX(date_fin)")), dateDebut);
					System.out.println(LocalDate.parse(rs.getString("MAX(date_fin)"))+"     "+dateDebut);	
				}
			
			System.out.println("diff dates :  "+diff_dates);
			if( diff_dates >= 0 || rs2.next()) {
				
				return true;
			}else {
				
				return false;
				
			}
			
		}catch(Exception e ) {
			e.printStackTrace();
			System.out.println("error : "+e.getMessage());
			return false;
		}
	}
	public ArrayList<Integer> GetAllUnusedChambresNum(LocalDate dateFin){
 		GetConnection.connect();
		ResultSet rs = null;
		ArrayList<Integer> ChambreList = new ArrayList<>();
		rs = GetConnection.Select("select numero from chambre where disponibilité > '0'  and numero not in (select numero_chambre from reservation) union"
				+ " select numero_chambre from reservation where date_fin <= '"+dateFin+"';");
		try{
			while(rs.next()) {
					ChambreList.add(rs.getInt("numero"));
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		GetConnection.disconnect();
		if(ChambreList.size()>0)
			return ChambreList;
		else 
			return null;
	}
	@Override
	
	public ArrayList<Chambre> GetChambreByPrix(double prix) {
		GetConnection.connect();
		ResultSet rs = null;
		rs = GetConnection.Select("select * from chambre where prix <= '"+prix+"'");
		ArrayList<Chambre> ChambreList = new ArrayList<>();
		try{
			while(rs.next()) {
					ChambreList.add(new Chambre(rs.getInt("id"),rs.getInt("numero"),rs.getString("type"),
							rs.getInt("enservice"),rs.getDouble("prix"),rs.getInt("diponibilité")));
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		GetConnection.disconnect();
		if(ChambreList.size()>0)
			return ChambreList;
		else 
			return null;
	}
			
	/* Actualiser enservice 1 */ 
	public Boolean SetChambreOnServiceTrue(int numero) {
		GetConnection.connect();
		int num=0;
		try {
			num = GetConnection.Maj("update chambre set enservice = 1 where numero ='"+numero+"'");
		} 
		catch (Exception e) {
			return false;
		}
		GetConnection.disconnect();
		if(num > 0)
		return true;
		else return false;
	};
	/* Actualiser Prix Total */ 
	public Boolean SetChambreOnServiceFalse(int numero) {
		GetConnection.connect();
		int num=0;
		try {
			num = GetConnection.Maj("update chambre set enservice = 0 where numero ='"+numero+"'");
		} 
		catch (Exception e) {
			return false;
		}
		GetConnection.disconnect();
		if(num > 0)
		return true;
		else return false;
	};
	
	public static void main(String[] args) {
		System.out.println(new GestionChambre().IfEmpty(89, LocalDate.parse("2022-02-04"),52));
	}
}

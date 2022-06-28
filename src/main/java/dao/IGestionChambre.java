package dao;

import java.time.LocalDate;
import java.util.ArrayList;

import bean.Chambre;

public interface IGestionChambre {
	
	// Get Functions
	public ArrayList<Chambre> GetAllChambres();
	public Double GetChambrePrixByNum(int num);
	public ArrayList<Integer> GetAllUnusedChambresNum(LocalDate dateFin);
	public Boolean IfEmpty(int numero ,LocalDate dateFin,int id);

	public ArrayList<Chambre> GetChambreByPrix(double prix);
	// Used Function
	public Boolean SetChambreOnServiceFalse(int numero);
	public Boolean SetChambreOnServiceTrue(int numero);

	
}

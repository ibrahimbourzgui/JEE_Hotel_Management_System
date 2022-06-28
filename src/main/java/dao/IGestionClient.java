package dao;

import java.util.ArrayList;

import bean.Chambre;
import bean.Client;

public interface IGestionClient {


	public Client GetClientByCin(String cin);
	public String GetClientByToken(String token);

	// Add Functions
	public Boolean AddClient(String newnom, String newprenom, String newtelephone, String newcin, String newtoken);
	public Boolean ClientSetGeneratedToken(String cin, String token);

	
}

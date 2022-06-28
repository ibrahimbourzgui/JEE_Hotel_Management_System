package dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import databaseconnection.GetConnection;
import bean.Client;

public class GestionClient implements IGestionClient {

	@Override
	public Client GetClientByCin(String cin) {
		GetConnection.connect();
		ResultSet rs = null;
		rs = GetConnection.Select("select * from client where cin = '"+cin+"'");
		Client c = null;
		try{
			while(rs.next()) {
					c = new Client(rs.getInt("id"),rs.getString("nom"),
							rs.getString("prenom"),rs.getString("telephone"),rs.getString("cin"),rs.getString("token"));
			}
		}catch (SQLException e) {
			e.printStackTrace();
		}
		GetConnection.disconnect();
		return c;
	}
	@Override
	public String GetClientByToken(String token) {
		GetConnection.connect();
		ResultSet rs = null;
		rs = GetConnection.Select("select cin from client where token = '"+token+"'");
		String cin = null;
		try{
			rs.next();
			cin = rs.getString("cin");
		}catch (SQLException e) {
			e.printStackTrace();
		}
		GetConnection.disconnect();
		return cin;
	}

	@Override
	public Boolean AddClient(String newnom, String newprenom, String newtelephone, String newcin, String newtoken) {
		GetConnection.connect();
		int status = 0;
		status = GetConnection.Maj("insert into client(nom,prenom,telephone,cin ,token) values('"+newnom+"','"+newprenom+"','"+newtelephone+"','"+newcin+"','"+newtoken+"')");		
		GetConnection.disconnect();
		if(status == 0)
			return false;
		else 
			return true;
	}


	@Override
	public Boolean ClientSetGeneratedToken(String cin, String token) {
		GetConnection.connect();
		int status = 0;
		status = GetConnection.Maj("update client set token='"+token+"' where cin='"+cin+"'");		
		GetConnection.disconnect();
		if(status == 0)
			return false;
		else 
			return true;
	}
	public static void main(String[] args) {
	//	System.out.println(new GestionClient().GetClientByToken("EPMB6UXX8DWMI7PERX"));
	}

}
 
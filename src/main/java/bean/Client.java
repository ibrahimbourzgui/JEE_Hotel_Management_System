package bean;

public class Client {
	
	private int id;
	private String nom;
	private String prenom;
	private String telephone;
	private String cin;
	private String token;
	
	public Client() {
		super();
	}

	public Client(int id, String nom, String prenom, String telephone, String cin, String token) {
		super();
		this.id = id;
		this.nom = nom;
		this.prenom = prenom;
		this.telephone = telephone;
		this.cin = cin;
		this.token = token;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getPrenom() {
		return prenom;
	}

	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getCin() {
		return cin;
	}

	public void setCin(String cin) {
		this.cin = cin;
	}
	public String getToken() {
		return token;
	}

	public void setToken(String cin) {
		this.token = token;
	}

	@Override
	public String toString() {
		return "Client [id=" + id + ", nom=" + nom + ", prenom=" + prenom + ", telephone=" + telephone + ", cin=" + cin
				+ "]";
	}
	
	
}

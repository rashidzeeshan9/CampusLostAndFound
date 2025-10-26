package com.campussek.bean; 
public class User 
{   private int id;    
	private String name;    
	private String email;    
	private String universityId;    
	private String password;    
	private String phoneNumber;    
	private String role;        
	public User() {}        
	public User(String name, String email, String universityId,String password, String phoneNumber) {
			this.name = name;        
			this.email = email;        
			this.universityId = universityId;        
			this.password = password;        
			this.phoneNumber = phoneNumber;        
			this.role = "USER";    
			}        
	// Getters and Setters    
		public int getId() { return id; }   
		public void setId(int id) { this.id = id; }        
		
		public String getName() { return name; }    
		public void setName(String name) { this.name = name; }        
		
		public String getEmail() { return email; }    
		public void setEmail(String email) { this.email = email; }        
		
		public String getUniversityId() { return universityId; }    
		public void setUniversityId(String universityId) {
			this.universityId = universityId;     }        
		
		public String getPassword() { return password; }    
		public void setPassword(String password) { this.password = password; }        
		
		public String getPhoneNumber() { return phoneNumber; }    
		public void setPhoneNumber(String phoneNumber) {         
			this.phoneNumber = phoneNumber;     }        
		
		public String getRole() { return role; }    
		public void setRole(String role) { this.role = role; } 
		}

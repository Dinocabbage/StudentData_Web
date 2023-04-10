package model;

public class StudentManagementDO {
	private int studentId;
	private String studentName;
	private String studentGender;
	private int [] score;
	
	public StudentManagementDO() {
		
	}
	
	public int getStudentId() {
		return studentId;
	}

	public void setStudentId(int studentId) {
		this.studentId = studentId;
	}

	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public String getStudentGender() {
		return studentGender;
	}

	public void setStudentGender(String studentGender) {
		this.studentGender = studentGender;
	}

	public int [] getScore() {
		return score;
	}

	public void setScore(int [] score) {
		this.score = score;
	}
	

	
	
}

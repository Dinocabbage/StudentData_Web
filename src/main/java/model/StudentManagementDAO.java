package model;

import java.sql.*;
import java.util.ArrayList;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class StudentManagementDAO {
	private DataSource ds;
	private Connection conn;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;

	public StudentManagementDAO() {
		try {
			InitialContext context = new InitialContext();
			this.ds = (DataSource)context.lookup("java:comp/env/jdbc/oracleXE");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int addStudentList(int studentId, String studentName, String studentGender, int [] score) {
		int rowCount = 0;
		this.sql = "insert into student_info values(?, ?, ?, ?, ?, ?, ?)";
		
		try {
			this.conn = this.ds.getConnection();
			this.pstmt = this.conn.prepareStatement(this.sql);
			this.pstmt.setInt(1, studentId);
			this.pstmt.setString(2, studentName);
			this.pstmt.setString(3, studentGender);
			this.pstmt.setInt(4, score[0]);
			this.pstmt.setInt(5, score[1]);
			this.pstmt.setInt(6, score[2]);
			this.pstmt.setInt(7, score[3]);

			rowCount = this.pstmt.executeUpdate();
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(!this.pstmt.isClosed()) {
					this.pstmt.close();
				}
				if(!this.conn.isClosed()) {
					this.conn.close();
				}
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rowCount;
	}


	public StudentManagementDO selectedStudent(int studentId) {
		StudentManagementDO studentDO = null;
		this.sql = "select * from student_info where student_id = ?";

		try {
			this.conn = this.ds.getConnection();
			this.pstmt = conn.prepareStatement(this.sql);
			this.pstmt.setInt(1, studentId);

			this.rs = this.pstmt.executeQuery();
			
			if(rs.next()) {
				studentDO = new StudentManagementDO();
				studentDO.setStudentId(this.rs.getInt("student_id"));
				studentDO.setStudentName(this.rs.getString("student_name"));
				studentDO.setStudentGender(this.rs.getString("student_gender"));
				studentDO.setScore(new int[] {this.rs.getInt("korean_score"), rs.getInt("english_score"), rs.getInt("math_score"), rs.getInt("science_score")});
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(!this.pstmt.isClosed()) {
					this.pstmt.close();
				}
				if(!this.conn.isClosed()) {
					this.conn.close();
				}
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return studentDO;
	}

	public ArrayList<StudentManagementDO> allOfStudent() {
		ArrayList<StudentManagementDO> studentList = new ArrayList<>();
		StudentManagementDO studentDO = null;
		this.sql = "select * from student_info";

		try {
			this.conn = this.ds.getConnection();
			this.stmt = this.conn.createStatement();
			this.rs = this.stmt.executeQuery(this.sql);
			
			while(this.rs.next()) {
				studentDO = new StudentManagementDO();
				studentDO.setStudentId(this.rs.getInt("student_id"));
				studentDO.setStudentName(this.rs.getString("student_name"));
				studentDO.setStudentGender(this.rs.getString("student_gender"));
				studentDO.setScore(new int [] {this.rs.getInt("korean_score"), rs.getInt("english_score"), rs.getInt("math_score"), rs.getInt("science_score")});
				
				studentList.add(studentDO);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(!this.stmt.isClosed()) {
					this.stmt.close();
				}
				if(!this.conn.isClosed()) {
					this.conn.close();
				}
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return studentList;
	}

	public int updateScore(int studentId, String subject, int score) {
		int rowCount = 0;
		
		try {
			this.conn = this.ds.getConnection();
			this.stmt = this.conn.createStatement();
			this.sql = "update student_info set " + subject + " = " + score + " where student_id = " + studentId;
			rowCount = this.stmt.executeUpdate(this.sql);
			if(rowCount == 1) {
				this.conn.commit();
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(!this.stmt.isClosed()) {
					this.stmt.close();
				}
				if(!this.conn.isClosed()) {
					this.conn.close();
				}
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rowCount;
	}
	
	public int deleteStudentInfo(int studentId) {
		int rowCount = 0;

		try {
			this.sql = "delete from student_info where student_id = ?";
			
			this.conn = this.ds.getConnection();
			this.pstmt = this.conn.prepareStatement(this.sql);
			this.pstmt.setInt(1, studentId);

			rowCount = this.pstmt.executeUpdate();

		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			try {
				if(!this.pstmt.isClosed()) {
					this.pstmt.close();
				}
				if(!this.conn.isClosed()) {
					this.conn.close();
				}
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return rowCount;
	}
}


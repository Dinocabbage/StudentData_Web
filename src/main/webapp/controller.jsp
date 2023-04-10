<%@ page contentType="text/html; charset=UTF-8" 
		 import="model.*, java.util.*, java.util.regex.Pattern"
%>

<jsp:useBean id="studentDAO" class="model.StudentManagementDAO" scope="session" />
<jsp:useBean id="studentDO" class="model.StudentManagementDO" scope="page" />

<%
	String viewPath = "/WEB-INF/views/";
	String menu = request.getParameter("menu");
	String command = request.getParameter("command");
	int rowCount;
	
	if(menu != null) {
		session.setAttribute("menu", menu);
	}
	
	if(session.getAttribute("id") == null) {
		if(request.getMethod().equals("GET")) {
			pageContext.forward(viewPath + "login.jsp");
		}
		else if(request.getMethod().equals("POST")) {
			String id = request.getParameter("id");
			String passwd = request.getParameter("passwd");
			
			if(id.equals(application.getInitParameter("adminID")) && passwd.equals(application.getInitParameter("adminPasswd"))) {
				session.setAttribute("id", id);
				session.setAttribute("name", application.getInitParameter("adminName"));
				pageContext.forward(viewPath + "studentManagement.jsp");
			}
			else {
				session.setAttribute("loginMsg", "잘못된 계정 정보를 입력하였습니다.");
				response.sendRedirect("controller.jsp");
			}
		}
	}
	else {
		if(command != null && command.equals("logout")) {
			session.invalidate();
			response.sendRedirect("controller.jsp");
		}
		
		else if(command != null && command.equals("insert")) {
			String insertMsg = "";
			
			if(!request.getParameter("studentId").equals("") && !request.getParameter("studentName").equals("") && !request.getParameter("studentGender").equals("")
					&& !request.getParameter("koreanScore").equals("") && !request.getParameter("englishScore").equals("") && !request.getParameter("mathScore").equals("")
					&& !request.getParameter("scienceScore").equals("")) {
				
				if(Pattern.matches("^[가-힣]*$", request.getParameter("studentName"))) {
					int koreanScore = Integer.parseInt(request.getParameter("koreanScore"));
					int englishScore = Integer.parseInt(request.getParameter("englishScore"));
					int mathScore = Integer.parseInt(request.getParameter("mathScore"));
					int scienceScore = Integer.parseInt(request.getParameter("scienceScore"));
					int [] score = {koreanScore, englishScore, mathScore, scienceScore};
					
					rowCount = studentDAO.addStudentList(Integer.parseInt(request.getParameter("studentId")), request.getParameter("studentName"), request.getParameter("studentGender"), score);
					
					if(rowCount == 1) {
						insertMsg = "학생 정보가 입력되었습니다.";
					}
					else if(rowCount == 0) {
						insertMsg = "잘못된 양식으로 입력하였습니다. 다시 입력해주세요.";
					}
				}
				else {
					insertMsg = "이름은 한글만 입력할 수 있습니다.";
				}
			}
			else {
				insertMsg = "입력하지 않은 값이 있습니다. 모든 값을 입력해주세요.";
			}
			session.setAttribute("insertMsg", insertMsg);
			pageContext.forward(viewPath + "studentManagement.jsp");
		}
		
		else if(command != null && command.equals("selectAll")) {
			String selectMsg = "<table> <tr> <th>학번</th> <th>이름</th> <th>성별</th> <th>국어</th> <th>영어</th> <th>수학</th> <th>과학</th> </tr>";
			ArrayList<StudentManagementDO> studentList = studentDAO.allOfStudent();
			
			for(StudentManagementDO sDO : studentList) {
				selectMsg += "<tr> <td>" + sDO.getStudentId() + "</td> <td>" + sDO.getStudentName() + "</td> <td>" + sDO.getStudentGender() 
				+ "</td> <td>" + sDO.getScore()[0] + "</td> <td>" + sDO.getScore()[1] + "</td> <td>" + sDO.getScore()[2] + "</td> <td>" 
				+ sDO.getScore()[3] + "</td> </tr>";
			}
			selectMsg += "</table>";
			
			session.setAttribute("selectMsg", selectMsg);
			pageContext.forward(viewPath + "studentManagement.jsp");
		}
		else if(command != null && command.equals("select")) {
			String selectMsg = "<table> <tr> <th>학번</th> <th>이름</th> <th>성별</th> <th>국어</th> <th>영어</th> <th>수학</th> <th>과학</th> </tr>";
			StudentManagementDO sDO = null;
			
			if(!request.getParameter("studentId").equals("") && Integer.parseInt(request.getParameter("studentId")) < 1000000 && Integer.parseInt(request.getParameter("studentId")) >= 100000) {
				sDO = studentDAO.selectedStudent(Integer.parseInt(request.getParameter("studentId")));
			}
			if(sDO == null) {
				selectMsg = "존재하지 않는 학번입니다.";
			}
			else {
				selectMsg += "<tr> <td>" + sDO.getStudentId() + "</td> <td>" + sDO.getStudentName() + "</td> <td>" + sDO.getStudentGender() 
							+ "</td> <td>" + sDO.getScore()[0] + "</td> <td>" + sDO.getScore()[1] + "</td> <td>" + sDO.getScore()[2] + "</td> <td>" 
							+ sDO.getScore()[3] + "</td> </tr> </table>";
			}
			session.setAttribute("selectMsg", selectMsg);
			pageContext.forward(viewPath + "studentManagement.jsp");
		}
		else if(command != null && command.equals("idToUpdate")) {
			String selectToUpdate = "<table> <tr> <th>학번</th> <th>이름</th> <th>성별</th> <th>국어</th> <th>영어</th> <th>수학</th> <th>과학</th> </tr>";
			StudentManagementDO sDO = null;
			
			if(request.getParameter("updateStudentId") != null && !request.getParameter("updateStudentId").equals("") && Integer.parseInt(request.getParameter("updateStudentId")) < 1000000 && Integer.parseInt(request.getParameter("updateStudentId")) >= 100000) {
				sDO = studentDAO.selectedStudent(Integer.parseInt(request.getParameter("updateStudentId")));
			}
			if(sDO == null) {
				selectToUpdate = "존재하지 않는 학번입니다.";
				session.setAttribute("selectResult", "unchecked");
			}
			else {
				selectToUpdate += "<tr> <td>" + sDO.getStudentId() + "</td> <td>" + sDO.getStudentName() + "</td> <td>" + sDO.getStudentGender() 
							+ "</td> <td>" + sDO.getScore()[0] + "</td> <td>" + sDO.getScore()[1] + "</td> <td>" + sDO.getScore()[2] + "</td> <td>" 
							+ sDO.getScore()[3] + "</td> </tr> </table>";
				
				session.setAttribute("selectResult", "checked");
				session.setAttribute("updateStudentId", request.getParameter("updateStudentId"));
			}
			
			session.setAttribute("selectToUpdate", selectToUpdate);
			pageContext.forward(viewPath + "studentManagement.jsp");
		}
		else if(command != null && command.equals("update")) {
			String updateMsg = "";
			
			if(!request.getParameter("transScore").equals("") && Integer.parseInt(request.getParameter("transScore")) >= 0 && Integer.parseInt(request.getParameter("transScore")) <= 100) {
				rowCount = studentDAO.updateScore(Integer.parseInt((String)session.getAttribute("updateStudentId")), request.getParameter("subject"), Integer.parseInt(request.getParameter("transScore")));
				
				if(rowCount == 1) {
					updateMsg = "성적이 변경되었습니다.";
					
					String selectToUpdate = "<table> <tr> <th>학번</th> <th>이름</th> <th>성별</th> <th>국어</th> <th>영어</th> <th>수학</th> <th>과학</th> </tr>";
					StudentManagementDO sDO = studentDAO.selectedStudent(Integer.parseInt((String)session.getAttribute("updateStudentId")));
					selectToUpdate += "<tr> <td>" + sDO.getStudentId() + "</td> <td>" + sDO.getStudentName() + "</td> <td>" + sDO.getStudentGender() 
					+ "</td> <td>" + sDO.getScore()[0] + "</td> <td>" + sDO.getScore()[1] + "</td> <td>" + sDO.getScore()[2] + "</td> <td>" 
					+ sDO.getScore()[3] + "</td> </tr> </table>";
					
					session.setAttribute("selectToUpdate", selectToUpdate);
				}
			}
			else {
				updateMsg = "잘못된 값을 입력하였습니다.";
			}
			session.setAttribute("updateMsg", updateMsg);
			pageContext.forward(viewPath + "studentManagement.jsp");
		}
		else if(command != null && command.equals("idToDelete")) {
			String selectToDelete = "<table> <tr> <th>학번</th> <th>이름</th> <th>성별</th> <th>국어</th> <th>영어</th> <th>수학</th> <th>과학</th> </tr>";
			StudentManagementDO sDO = null;
			
			if(request.getParameter("deleteStudentId") != null && !request.getParameter("deleteStudentId").equals("") && Integer.parseInt(request.getParameter("deleteStudentId")) < 1000000 && Integer.parseInt(request.getParameter("deleteStudentId")) >= 100000) {
				sDO = studentDAO.selectedStudent(Integer.parseInt(request.getParameter("deleteStudentId")));
			}
			if(sDO == null) {
				selectToDelete = "존재하지 않는 학번입니다.";
				session.setAttribute("selectResult2", "unchecked");
			}
			else {
				selectToDelete += "<tr> <td>" + sDO.getStudentId() + "</td> <td>" + sDO.getStudentName() + "</td> <td>" + sDO.getStudentGender() 
							+ "</td> <td>" + sDO.getScore()[0] + "</td> <td>" + sDO.getScore()[1] + "</td> <td>" + sDO.getScore()[2] + "</td> <td>" 
							+ sDO.getScore()[3] + "</td> </tr> </table>";
				
				session.setAttribute("selectResult2", "checked");
				session.setAttribute("deleteStudentId", request.getParameter("deleteStudentId"));
			}
			
			session.setAttribute("selectToDelete", selectToDelete);
			pageContext.forward(viewPath + "studentManagement.jsp");
		}
		else if(command != null && command.equals("delete")) {
			String deleteMsg = "";
			
			rowCount = studentDAO.deleteStudentInfo(Integer.parseInt((String)session.getAttribute("deleteStudentId")));
			
			if(rowCount == 1) {
				deleteMsg = "해당 학생의 정보를 삭제하였습니다.";
			}
			
			session.setAttribute("deleteMsg", deleteMsg);
			session.removeAttribute("selectResult2");
			session.removeAttribute("selectToDelete");
			pageContext.forward(viewPath + "studentManagement.jsp");
		}
		else if(command != null && command.equals("cancel")) {
			session.removeAttribute("selectResult2");
			session.removeAttribute("selectToDelete");
			response.sendRedirect("controller.jsp");
		}
		else {
			pageContext.forward(viewPath + "studentManagement.jsp");
		}
	}
%>
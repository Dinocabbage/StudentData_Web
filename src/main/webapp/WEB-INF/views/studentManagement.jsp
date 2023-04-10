<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<html>
<head>
	<meta charset="UTF-8">
	<title>studentManagement.jsp</title>
	<style>
		th {
			border-bottom: 1px solid gray;
			padding-left: 20px;
			padding-right: 20px;
		}
		td {
			text-align: center;
		}
		div {
			border: 1px solid gray;
			padding: 10px;
		}
	</style>
</head>

<body>

	<h2>학생 성적 관리 프로그램</h2>
	<hr />
	
	<h4>${name} 선생님 반갑습니다.</h4>
	
	<form method="POST">
	<fieldset>
		<legend>메뉴 선택</legend>
		<select name="menu">
			<option>메뉴를 선택하세요</option>
			<option ${sessionScope.menu == '학생 정보 입력' ? 'selected' : '' }>학생 정보 입력</option>
			<option ${sessionScope.menu == '학생 정보 조회' ? 'selected' : '' }>학생 정보 조회</option>
			<option ${sessionScope.menu == '성적 변경' ? 'selected' : '' }>성적 변경</option>
			<option ${sessionScope.menu == '학생 정보 삭제' ? 'selected' : '' }>학생 정보 삭제</option>
		</select>
		<input type="submit" value="확인" />
	</fieldset>
	</form>
	<hr />
	
	<c:choose>
		<c:when test="${sessionScope.menu == '학생 정보 입력'}">
			<form method="POST">
				<fieldset>
					<legend>학생 정보 입력</legend>
					[인적사항]<br />
					<label for="studentId">학번</label>
					<input type="number" name="studentId" id="studentId" placeholder="6자리 학번을 입력하세요" /> <br />
					<label for="studentName">이름</label>
					<input type="text" name="studentName" id="studentName" placeholder="한글 5자 이내로 입력하세요" /> <br />
					<label for="studentGender">성별</label>
					<select name="studentGender">
						<option>남</option>
						<option>여</option>
					</select><br />
					[성적 정보]<br />
					<label for="koreanScore">국어</label>
					<input type="number" name="koreanScore" id="koreanScore" placeholder="0~100 사이의 정수를 입력하세요" /> <br />
					<label for="englishScore">영어</label>
					<input type="number" name="englishScore" id="englishScore" placeholder="0~100 사이의 정수를 입력하세요" /> <br />
					<label for="mathScore">수학</label>
					<input type="number" name="mathScore" id="mathScore" placeholder="0~100 사이의 정수를 입력하세요" /> <br />
					<label for="scienceScore">과학</label>
					<input type="number" name="scienceScore" id="scienceScore" placeholder="0~100 사이의 정수를 입력하세요" /> <br />
					<input type="hidden" name="command" value="insert" />
					<input type="submit" value="입력" />
					<font color="red">${sessionScope.insertMsg}</font>
				</fieldset>
			</form>
		</c:when>
		<c:when test="${sessionScope.menu == '학생 정보 조회'}">
			<div>
				<form method="POST">
					<b>[전체 학생 조회]</b> <br />
					<input type="hidden" name="command" value="selectAll" />
					<input type="submit" value="조회" /> <br /><br />
				</form>
				<form method="POST">
					<b>[학번 조회]</b><br />
						조회하고자 하는 학생의 학번을 입력하세요.<br />
						<label for="studentId">학번</label>
						<input type="number" name="studentId" id="studentId" placeholder="6자리 학번을 입력하세요" />
						<input type="hidden" name="command" value="select" />
						<input type="submit" value="조회" />
				</form>
			</div>
						<hr />
			<b>[조회 결과]</b><br />
			${sessionScope.selectMsg}
		</c:when>
		<c:when test="${sessionScope.menu == '성적 변경'}">
			<div>
				성적을 변경하고자 하는 학생의 학번을 입력하세요.<br />
				<form method="POST">
				<label for="updateStudentId">학번</label>
				<input type="number" name="updateStudentId" id="updateStudentId" placeholder="6자리 학번을 입력하세요" />
				<input type="hidden" name="command" value="idToUpdate" />
				<input type="submit" value="조회" />
				</form>
			
				<c:if test="${selectResult == 'checked'}" var="result">
					해당 학생의 정보입니다.<br />
					변경할 과목과 성적을 입력해주세요.
				</c:if>
					${sessionScope.selectToUpdate}
				<c:if test="${selectResult == 'checked'}" var="result">
					<form method="POST">
						<select name="subject">
							<option value="korean_score">국어</option>
							<option value="english_score">영어</option>
							<option value="math_score">수학</option>
							<option value="science_score">과학</option>
						</select>
						<input type="number" name="transScore" id="transScore" placeholder="0~100 사이의 정수를 입력하세요" />
						<input type="hidden" name="command" value="update" />
						<input type="submit" value="확인" /><br />
					</form>
				</c:if>
				${sessionScope.updateMsg}
			</div>
		</c:when>
		<c:when test="${sessionScope.menu == '학생 정보 삭제'}">
			<div>
				삭제하고자 하는 학생의 학번을 입력하세요.<br />
				<form method="POST">
				<label for="deleteStudentId">학번</label>
				<input type="number" name="deleteStudentId" id="deleteStudentId" placeholder="6자리 학번을 입력하세요" />
				<input type="hidden" name="command" value="idToDelete" />
				<input type="submit" value="조회" />
				</form>
			
				<c:if test="${selectResult2 == 'checked'}" var="result">
					해당 학생의 정보입니다.<br />
				</c:if>
					${sessionScope.selectToDelete}<br />
				<c:if test="${selectResult2 == 'checked'}" var="result">
					정말로 삭제하시겠습니까?
					<form method="POST">
						<input type="hidden" name="command" value="delete" />
						<input type="submit" value="예" />
					</form>
					<form method="POST">
						<input type="hidden" name="command" value="cancel" />
						<input type="submit" value="아니오" />
					</form>
				</c:if>
				${sessionScope.deleteMsg}
			</div>
		</c:when>
	</c:choose>
	
	<br />
	<form method="POST">
		<input type="hidden" name="command" value="logout" />
		<input type="submit" value="로그아웃" />
	</form>
	
</body>
</html>
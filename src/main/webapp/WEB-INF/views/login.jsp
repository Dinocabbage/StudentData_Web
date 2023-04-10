<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>

<html>
<head>
	<meta charset="UTF-8">
	<title>login.jsp</title>
</head>

<body>

	<h2>학생 성적 관리 프로그램</h2>
	<hr />
	
	<form method="POST">
	<fieldset>
		<legend>로그인</legend>
		<label for="id">교사 ID</label>
		<input type="text" name="id" id="id" /> /
		<label for="passwd">Passwd</label>
		<input type="password" name="passwd" id="passwd" />
		<input type="submit" value="login" />
	</fieldset>
	</form>
	<font color="red">${sessionScope.loginMsg}</font>
	
</body>
</html>
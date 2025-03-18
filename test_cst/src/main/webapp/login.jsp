<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Log</title>
    <link rel="stylesheet" href="	https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <style>
        .btn-light-green {
            background-color: #90ee90; /* 연녹색 */
            border-color: #90ee90;
            color: white;
        }
        .btn-light-green:hover {
            background-color: #76c776; /* 좀 더 진한 연녹색 */
            border-color: #76c776;
        }
        
        .card {
            border: 3px solid #90ee90; /* 연녹색 테두리 */
            border-radius: 10px; /* 모서리를 둥글게 */
        }
       
        .header {
            text-align: center;
            font-size: 17px; /* 큰 글자 크기 */
            color: #90ee90; /* 연녹색 */
            margin-top: 10px;
        }
        
        .header-line {
            border-top: 3px solid #90ee90; /* 연녹색 가로선 */
            width: 600%;
            margin: 10px auto;
        }
    </style>
    
</head>
<body>

	<div class="header">Running mate</div>
    <div class="header-line"></div>
    <div class="container d-flex justify-content-center align-items-center vh-100">
    	
        <div class="card">
            <div class="card-body">
                <h1 class="card-title">로그인</h1>

                <%-- Display error message if login fails --%>
                <% String errorMessage = request.getParameter("error");
                   if (errorMessage != null && !errorMessage.isEmpty()) { %>
                    <p style="color: red;"><%= errorMessage %></p>
                <% } %>

                <form method="POST" action="userLoginAction.jsp">
                    <div class="mb-3">
                        <label for="email" class="form-label">이메일:</label>
                        <input type="text" id="email" name="email" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label for="pwd" class="form-label">비밀번호:</label>
                        <input type="password" id="pwd" name="pwd" class="form-control" required>
                    </div>
                    <div class="form-group mt-3">
            		<label for="paymentMethod"></label>
            			<!-- <div class="form-check form-check-inline">
                			<input class="form-check-input" type="radio" name="authority" id="user" value="user" checked>
                			<label class="form-check-label" for="authority">
                    		일반 회원
                			</label>
            			</div>
            			<div class="form-check form-check-inline">
                			<input class="form-check-input" type="radio" name="authority" id="admin" value="admin">
                			<label class="form-check-label" for="authority">
                    		관리자
                			</label>
            			</div> -->
            		</div>

                    <button type="submit" class="btn btn-light-green">로그인</button>
                    <button type="button" class="btn btn-light-green" onclick="location.href='userJoin.jsp'">회원가입</button>
                </form>
            </div>
        </div>
    </div>

    <script src="	https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

    
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>시간표 등록</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
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
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        .header {
            text-align: center;
            font-size: 20px;
            color: #90ee90;
            margin-top: 10px;
            font-weight: bold;
        }

        .header-line {
            border-top: 3px solid #90ee90;
            width: 50%;
            margin: 10px auto;
        }

        body {
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>

    <div class="header">Running mate</div>
    <div class="header-line"></div>

    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card">
            <div class="card-body">
                <h2 class="card-title">시간표 등록</h2>

                <form method="post" action="timetableAction.jsp" accept-charset="UTF-8">
                    <div class="mb-3">
                        <label for="courseName" class="form-label">강의명:</label>
                        <input type="text" id="courseName" name="courseName" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="dayOfWeek" class="form-label">요일:</label>
                        <select id="dayOfWeek" name="dayOfWeek" class="form-select" required>
                            <option value="월">월</option>
                            <option value="화">화</option>
                            <option value="수">수</option>
                            <option value="목">목</option>
                            <option value="금">금</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="startTime" class="form-label">시작 시간:</label>
                        <input type="time" id="startTime" name="startTime" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="endTime" class="form-label">종료 시간:</label>
                        <input type="time" id="endTime" name="endTime" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="room" class="form-label">강의실:</label>
                        <input type="text" id="room" name="room" class="form-control">
                    </div>
                    <button type="submit" class="btn btn-light-green w-100">시간표 등록</button>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
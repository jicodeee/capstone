<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리소스 추천</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

	<div class="container mt-5">
	    <h2 class="mb-4">YouTube 강의 추천</h2>
	
	    <div class="input-group mb-3">
	        <input type="text" id="searchQuery" class="form-control" placeholder="강의명을 입력하세요" readonly>
	    </div>
	
	    <div id="videoResults" class="row"></div>
	</div>

<script>
const API_KEY = "AIzaSyDyQzTFXqtsEHC8cEu11ZVOzLqnVO2M8ok"; // YouTube API 키
const MAX_RESULTS = 10;

// ChatGPT API를 호출하여 검색어를 자연스럽게 변환하는 함수
function refineSearchQuery(courseName) {
    return $.ajax({
        url: "https://api.openai.com/v1/chat/completions",
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify({
            model: "gpt-4",
            messages: [{ role: "user", content: "\"" + courseName + "\" 관련 기초 강의를 검색할 최적의 검색어 하나만 추천해줘." }],
            max_tokens: 30
        }),
        headers: {
            "Authorization": "Bearer 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"
        }
    });
}

// URL 파라미터 가져오는 함수
function getUrlParameter(name) {
    var urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(name);
}

// 페이지 로드 시 강의명 자동 검색
$(document).ready(function() {
    var courseName = getUrlParameter('course_name'); 
    if (courseName) {
        refineSearchQuery(courseName).done(function(response) {
            var refinedQuery = response.choices[0].message.content.trim();
            refinedQuery = refinedQuery.replace(/^"|"$/g, '');
            $("#searchQuery").val(refinedQuery);
            searchYouTube(refinedQuery);
        }).fail(function() {
            var fallbackQuery = courseName + " 강의";
            $("#searchQuery").val(fallbackQuery);
            searchYouTube(fallbackQuery);
        });
    }
});

function getVideoSummary(videoId, videoTitle) {
    $.ajax({
        url: "https://api.openai.com/v1/chat/completions",
        method: "POST",
        contentType: "application/json",
        data: JSON.stringify({
            model: "gpt-4",
            messages: [{ role: "user", content: "\"" + videoTitle + "\" 이 유튜브 영상의 핵심 내용을 짧게 요약해줘." }],
            max_tokens: 50
        }),
        headers: {
            "Authorization": "Bearer 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"
        }
    }).done(function(response) {
        console.log("ChatGPT API 응답:", response);
        
        if (response.choices && response.choices.length > 0) {
            var summary = response.choices[0].message.content.trim();
            $("#summary-" + videoId).text(summary);  //videoId 기반으로 요약 반영
        } else {
            $("#summary-" + videoId).text("요약을 가져오지 못했습니다.");
        }
    }).fail(function(jqXHR, textStatus, errorThrown) {
        console.error("ChatGPT API 요청 실패:", textStatus, errorThrown);
        $("#summary-" + videoId).text("요약 요청 실패 (" + textStatus + ")");
    });
}

function searchYouTube(query) {
    if (!query) {
        alert("검색어가 없습니다!");
        return;
    }

    var encodedQuery = encodeURIComponent(query);
    var searchUrl = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=" 
        + MAX_RESULTS + "&q=" + encodedQuery + "&key=" + API_KEY + "&type=video";

    $.getJSON(searchUrl, function(data) {
        var videoList = $("#videoResults");
        videoList.empty();

        if (data.items.length === 0) {
            videoList.append("<p>추천된 강의 영상을 찾을 수 없습니다.</p>");
            return;
        }

        var videoIds = data.items.map(function(item) { return item.id.videoId; }).join(",");
        var videoDetailsUrl = "https://www.googleapis.com/youtube/v3/videos?part=snippet,statistics&id=" 
            + videoIds + "&key=" + API_KEY;

        $.getJSON(videoDetailsUrl, function(videoData) {
            videoData.items.forEach(function(item) {
                var videoId = item.id;
                var title = item.snippet.title;
                var thumbnail = item.snippet.thumbnails.medium.url;
                var publishedAt = new Date(item.snippet.publishedAt).toLocaleDateString(); // 업로드 날짜
                var viewCount = item.statistics.viewCount ? item.statistics.viewCount.toLocaleString() : "조회수 없음"; // 조회수

                var videoItem = 
                    '<div class="col-md-4 mb-3">' +
                        '<div class="card">' +
                            '<img src="' + thumbnail + '" class="card-img-top" alt="' + title + '">' +
                            '<div class="card-body">' +
                                '<h5 class="card-title">' + title + '</h5>' +
                                '<p class="text-muted">📅 ' + publishedAt + ' | 👀 ' + viewCount + '회 조회</p>' + // 업로드 날짜 & 조회수
                                '<iframe width="100%" height="280" src="https://www.youtube.com/embed/' + videoId + '" frameborder="0" allowfullscreen></iframe>' +
                                '<p id="summary-' + videoId + '" class="video-summary">요약을 불러오는 중...</p>' +  // 요약
                            '</div>' +
                        '</div>' +
                    '</div>';
                videoList.append(videoItem);

                // ChatGPT API를 호출해서 영상 요약 추가
                getVideoSummary(videoId, title);
            });
        });
    }).fail(function() {
        alert("YouTube API 요청 실패. API 키를 확인하세요.");
    });
}
</script>

</body>
</html>
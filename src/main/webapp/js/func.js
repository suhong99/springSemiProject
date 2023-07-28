/* 1. 검색 버튼 클릭 시 실행할 함수 */
function searchMovies() {
// 검색어를 입력하는 input 요소 참조
const searchInput = document.getElementById("searchInput");
// 검색어 값을 가져옴
const query = searchInput.value;

// 서버로 검색어를 전송하고 결과를 받아옴 (Ajax 사용)
$.ajax({
    url: "searchNetflix.do", // 검색 요청을 처리하는 서블릿 또는 컨트롤러 URL
    type: "GET", // GET 메서드로 변경
    data: { query: query }, // 검색어를 GET 파라미터로 전송
    success: function (data) {
    	console.log(data);
    	$("#searchResults").html(data);
    },
    error: function (e) {
        alert("검색 실패");
    }
});
}



/* 2. 홈으로 돌아가기 */
function back(){
	location.href = "home.do"; 
}




/* 3. 이전 페이지로 이동 */
function backSearch(){
	// 브라우저의 이전 페이지로 이동
    window.history.back();
}




/* 4. 즐겨찾기 추가시 알림 */
function favorite(){
    Swal.fire({
        title: '즐겨찾기에 추가하시겠습니까?',
        icon: 'question',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: '추가',
        cancelButtonText: '취소'
    })
    
    .then((result) => {
        if (result.isConfirmed) {
            // 확인 버튼을 누르면 즐겨찾기 추가
             $("#favorite").submit();
        }
    });
    
}




/* 5. 아이디 익명성 */
function star(id) {
  if (id === null || id.length <= 2) {
	  let maskedId = id.substring(0, 1) + "*".repeat(6);
      return id;
  }

  let maskedId = id.substring(0, 2) + "*".repeat(6);
  return maskedId;
}




/* 6. 비속어 필터링 */
function hasBadword(content) {
	  // 비속어 리스트 
	  const list = [
	    "시발",
	    "병신",
	    "개새끼",
	    "fuck",
	    "shit",
	    "ㅅㅂ",
	    "좆"
	    // 추가 가능..
	  ];

	  // content를 소문자로 변환하여 비속어를 체크합니다.
	  const lowerCaseContent = content.toLowerCase();

	  // list에 포함되어있는지 체크
	  for (const word of list) {
		    if (lowerCaseContent.includes(word.toLowerCase())) {
		      return "<span style='font-weight: bold; color: red;'>**욕설 및 부적절한 단어가 포함되어있습니다. 클린한 댓글 문화를 지켜주세요!**</span><br><br>"; 
		    }
	  }

	  return "<span style='font-weight: bold; color: #F2F2F2;'>" + content + "</span><br><br>"; // 비속어가 포함되지 않은 경우 그대로 반환
}





/* 7. 슬라이더 구현 */
const sliderContainer = document.querySelector('.slider-container');
const posters = document.querySelectorAll('.poster-container');

let isDragging = false;
let startPosition = 0;
let currentTranslate = 0;
let prevTranslate = 0;
let animationID = 0;

posters.forEach((poster, index) => {
    poster.addEventListener('dragstart', (e) => e.preventDefault());

    // Touch events
    poster.addEventListener('touchstart', touchStart(index));
    poster.addEventListener('touchend', touchEnd);
    poster.addEventListener('touchmove', touchMove);

    // Mouse events
    poster.addEventListener('mousedown', touchStart(index));
    poster.addEventListener('mouseup', touchEnd);
    poster.addEventListener('mouseleave', touchEnd);
    poster.addEventListener('mousemove', touchMove);
});

function touchStart(index) {
    return function (event) {
        isDragging = true;
        startPosition = getPositionX(event);
        currentTranslate = prevTranslate;
        animationID = requestAnimationFrame(animation);
        sliderContainer.classList.add('grabbing');
    };
}

function touchEnd() {
    isDragging = false;
    cancelAnimationFrame(animationID);
    const movedBy = currentTranslate - prevTranslate;
    if (movedBy < -100) {
        // Swipe right
        prevTranslate = currentTranslate - 300;
    } else if (movedBy > 100) {
        // Swipe left
        prevTranslate = currentTranslate + 300;
    }
    sliderContainer.classList.remove('grabbing');
    setSliderPositionByIndex();
}

function touchMove(event) {
    if (isDragging) {
        const currentPosition = getPositionX(event);
        currentTranslate = prevTranslate + currentPosition - startPosition;
    }
}

function getPositionX(event) {
    return event.type.includes('mouse') ? event.pageX : event.touches[0].clientX;
}

function animation() {
    setSliderPositionByIndex();
    if (isDragging) requestAnimationFrame(animation);
}

function setSliderPositionByIndex() {
    sliderContainer.style.transform = `translateX(${prevTranslate}px)`;
}

# TodoListPlus

## Teget iOS Version
iOS14 : iOS 점유율을 근거로 하여 설정

## Model
! : not optional
? : optional

<TodoList>
* listNumber: Int     / !
* isComplited: Bool   / !
* category: [String]  / !         -> 딕셔너리?
* title: String       / !
* date: Date          / !
* time: Date          / !
* memo: String        / ?

## View 와 View의 이동
![메인 페이지](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbuCsvs%2Fbtsr4kcQSC7%2Fq4x33pb6vAcQCm6XCchnek%2Fimg.jpg)

* 카테고리 안에서 시간 오름차순으로 표시
* 시간 있는 List가 위로, 시간 없는 List가 아래로 표시

![상세 페이지](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FJc16C%2FbtsrZlX0lWB%2FgQ8nJdzie6P2pDHIpdo4ok%2Fimg.jpg)

![쓰기 페이지](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FN9dZZ%2Fbtsr5Vp6lgH%2FxtSX9DSbwHGgSETe5K4SuK%2Fimg.jpg)

## Controller
* 메인 페이지 : mainViewController
    - didTappedList(with: TodoList) : 상세 페이지 이동
    - didTappedCheckbox() : 체크박스 토글
    - didTappedPlusButton() : 쓰기 페이지 이동
    (구현 예정)
    - 오늘 날짜 옆에 있는 < > Tap하면 날짜 변경 가능
    - 오늘 날짜 Tap하면 캘린더를 표시하고, 캘린더에서 날짜를 선택하면 선택한 날짜의 리스트를 보여주기
    
* 상세 페이지 : detailViewController
    - didTappedUpdateButton(with: TodoList) : 쓰기 페이지 이동
    - didTappedDeleteButton(wiht: listNumber) : 삭제 알림창 표시 후 삭제 -> 메인 페이지로 이동
    
* 쓰기 페이지 : writeViewController
    - didTappedCategory : 카테고리 보여주기 -> 선택 후 쓰기 페이지의 카테고리 변경
    - didTappedDate : 캘린더 보여주기 -> 선택 후 쓰기 페이지의 선택한 날짜와 시간 표시
    - didTappedDoneButton() : 새 글 쓰기 or 수정하기 처리

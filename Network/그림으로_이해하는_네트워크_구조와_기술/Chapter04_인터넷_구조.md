# DAY9
작성일 : 2024/02/01

> 범위
- 38 인터넷 구조

---

> 작성자 :  KUN

## Q. 인터넷의 구성요소중 제일 중요하다고 할수있는 이“네트워크기능”은 무엇이고 이것의 중요기능 3가지를 서술해주세요


### 정답은 라우터였습니다!

- 1. LAN 내부의 통신은 외부로 내보내지 않음
  2. 자신의 LAN주소가 아닌 통신은 내부로 들여보내지 않음
  3. 자신의 LAN주소가 아닌 통신은 라우팅 테이블이나
     기본게이트웨이를 설정하여 전달함

---

# DAY10
작성일 : 2024/02/05

> 범위
- 39 인터넷에서 사용하는
- 40 이메일을 주고받는 구조
- 41 웹 페이지를 열람할 수 있는 구조
- 42 URL/URI

> 작성자 :  Quarang

## 문제. 선량한 시민 A가 메일을 보내려할때 발신 측 클라이언트와 서버 사이에 일어나는 일의 과정을 설명하시오.

<img width="462" alt="스크린샷 2024-02-05 오후 12 45 31" src="https://github.com/team-imad-study/study-question/assets/31721255/b5c1562a-f48f-4c72-aa3c-5cc49700f53d">



### 전송 준비
• SMTP 클라이언트와 SMTP 서버 사이 TCP 연결을 설정하는 단계
1. 발신 : 발신자가 메일 메세지를 작성하여 A메일 서버에 TCP 접속 요청
2. 서버 : 220코드와 함께 도메인명과 서비스 준비완료 응답
3. 발신 : 받은 도메인명과 Halo 명령어 전송
4. 서버 : 200코드와 함께 발신 가능 응답

---



### 전송 과정
• SMTP 서버에 메일을 보내는 데이터 전송 단계

5. 발신 : 메일 발신자 이메일 전송 MAIL
6. 서버 : 250코드와 응답확인
7. 발신 : 메일 수신자 이메일 전송 RCPT
8. 서버 : 250코드와 응답 확인
8. 발신 : 데이터 요청을 보냄(본문 작성을 위함) DATA
9. 서버 : 354 코드로 메일 본문 작성 응답 확인
10. 발신 : 본문 작성 후 마지막에 ‘.’특수문자를 보내면 본문 전송이 끝나고 Quit 명령어를 전송함
11. 서버 : 완료 응답하고 TCP연결 세션이 끊킴
<img width="705" alt="스크린샷 2024-02-05 오후 12 26 17" src="https://github.com/team-imad-study/study-question/assets/31721255/6d95aed5-c25f-4f95-8ca9-808c47b0dbda">

---

> 작성자 :

---

> 작성자 : ncookie

## 아래 요소들을 사용해 IMAD의 로그인 과정 그리기

### 문제
![문제](https://github.com/team-imad-study/study-question/assets/16646208/0442ed2f-73a2-4b77-990b-a424b953b6e9)

### 답안
![답안](https://github.com/team-imad-study/study-question/assets/16646208/3f4b3967-b4d5-4041-8624-927b1521e405)

### 로그인 성공 시 응답
![로그인 성공 시 응답](https://github.com/team-imad-study/study-question/assets/16646208/35b8b2e6-0a90-443c-9ae4-ba64d864e932)

### 로그인 실패 시 응답
![로그인 실패 시 응답](https://github.com/team-imad-study/study-question/assets/16646208/7df3a1d9-fc47-499a-9ea8-b26be7d8bdc1)

---

> 작성자 : PCYSB

## Q. TCP/IP와 더불어 다양한 서비스 프로토콜을 사용하는 이유는?

TCP/IP는 주된 목적은 데이터의 전송과 라우팅을 담당하는 것이며, 실질적인 서비스 수준의 기능을 제공하지는 않는다. 여러가지 서비스를 제공하기 위해서는 상위 계층에서의 좀더 다양한 프로토콜이 함께 해야 원할한 서비스를 제공할 수 있다.


---
> 작성자 : KUN

## Q. ![image (4)](https://github.com/team-imad-study/study-question/assets/136051281/2a5f8cbc-efd7-43f1-83a7-bbe2b25c2021)
### 이것이 아이매드의 웹 서버의 페이지 부분이라고 했을때![image (3)](https://github.com/team-imad-study/study-question/assets/136051281/297a3284-61e8-4da5-9770-3c0249ca4d14)![image (2)](https://github.com/team-imad-study/study-question/assets/136051281/2eee632d-b674-49ed-8efa-233dc9b56aa3) 다음 두URL의 서버경로를 서술해주세요


- 1. ![image (1)](https://github.com/team-imad-study/study-question/assets/136051281/294b9602-c44e-403b-8490-d825e1b41ff9)
URL에서의 “/” 는 서버내 파일 경로를 의미하므로 
main/main_setting
즉 main 폴더안의
 main_setting 폴더안의 
index.tsx 페이지로 접속하게됩니다.

- 2. ![image](https://github.com/team-imad-study/study-question/assets/136051281/2a340fd3-7a69-4e71-92a8-2f57886d3039)
서버내 파일 경로임은 동일하지만 
“[boardId]” 부분이 
서버클라이언트 내에서 지정한 
다이나믹 라우팅 부분이므로 
https://iimad.com/boards/DAF75IPb7N/edit
DAF75IPb7N 부분은 
다이나믹 라우팅을 위한 게시물번호라고 유추할수있다

---

# DAY11
작성일 : 2024/02/08

> 범위
- 43 HTTP/HTTPS
- 44 DNS
- 45 ICMP
- 46 텔넷

> 작성자 : Quarang

---

> 작성자 : PCYSB

## Q. 해당 그림에서 불필요하게 경로를 돌아서 가고 있을때 이때 router 2번은 어떤 역할 을 할까? #5

![스크린샷 2024-02-07 063515](https://github.com/team-imad-study/study-question/assets/108323826/1f65a04b-9074-47d4-9f68-d7ea3f5d6cf7)

ICMP Redirect는 ICMP 프로토콜 중 하나의 타입으로, 더 좋은 경로가 있으면 라우터가 ICMP Redirect 패킷을 호스트에게 보내준다. 때문에 해당 라우터가 최적의 경로임을 호스트에게 알려주기 위하여 라우터로부터 호스트로 보내어주며 Host의 라우팅 테이블이 변경된다.

![스크린샷 2024-02-07 063505](https://github.com/team-imad-study/study-question/assets/108323826/3e32e4a9-a5d6-4ca4-8028-6af487406885)

참고
> - [ICMP에 대한 설명](https://www.youtube.com/watch?v=tos6Wlfkb18&t=912s)


---

> 작성자 :

---

> 작성자 : NCookie

## 텔넷은 패킷을 암호화하는 기능이 없기 때문에 보안 문제가 있다. 그럼에도 리눅스, 윈도우 등의 OS에서 아직까지 지원하는 이유는?

아래와 같은 경우나 이유 때문에 간간이 사용됨

- Telnet만을 지원하는 구식 장비 또는 서버에 접속하는 경우 (생각보다 많음)
- 서버의 특정 포트나 서비스가 제대로 작동하는지 확인하기 위해
- 조직 또는 기업 내부에서 서버/장치에 간단하게 연결 후 사용하기 위해
- SSH 설정하기 귀찮을 때

> 참고
> - [What is Telnet and what is it still used for?
](https://www.digitalcitizen.life/simple-questions-what-telnet-what-can-it-still-be-used/)
> - [[Serious] Why is Telnet still used?](https://www.reddit.com/r/AskNetsec/comments/52rdaf/serious_why_is_telnet_still_used/)

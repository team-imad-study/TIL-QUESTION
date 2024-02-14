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
- 39 인터넷에서 사용하는 프로토콜
- 40 이메일을 주고받는 구조
- 41 웹 페이지를 열람할 수 있는 구조
- 42 URL/URI

---

> 작성자 : PCYSB

## Q. TCP/IP와 더불어 다양한 서비스 프로토콜을 사용하는 이유는?

TCP/IP는 주된 목적은 데이터의 전송과 라우팅을 담당하는 것이며, 실질적인 서비스 수준의 기능을 제공하지는 않는다. 여러가지 서비스를 제공하기 위해서는 상위 계층에서의 좀더 다양한 프로토콜이 함께 해야 원할한 서비스를 제공할 수 있다.

---

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
작성일 : 2024/02/07

> 범위
- 43 HTTP/HTTPS
- 44 DNS
- 45 ICMP
- 46 텔넷

---

> 작성자 : Quarang

## 문제. HTTP통신은 왜 Stateless 방식이다. 그럼 Stateless는 무엇인가? 반대 개념도 있을까?

- stateless는 서로의 통신 주체 끼리 연결 스트림(세션)을 유지시키지 않는다는 말임
- 예를 들어 클라이언트가 서버에게 요청을 하고 응답을 받게 되면  세션이 끊키게 됨

### 근데 만약에 로그인을 한 번하면 그 다음부터는 로그인 없이 서버와 연결이 되있는데 그럼 연결이 되있다는 말 아닐까?

- 그런 이유 때문에 서로의 세션 상태를 유지시키는 것이 아닌 서로가 통신 했던 기억을 각자가 가지고 있게 되는데, 그게 우리가 아는 JWT 방식이다.
- 처음 로그인을 하게 되면 그 정보를 백엔드 서버에서 저장하고 그 인증정보로 특정 다른 요청을 걸 수 있도록 쿠키 혹은 토큰을 첨부해주고 클라이언트는 그것을 가지고 본인이 누구인지 서버에 알릴 수 있음

### 그럼 Stateless의 반대개념은 뭐고 어떨 때 사용할까?

- 마찬가지로 세션상태를 유지하는 방식임
- 채팅 프로그램 처럼 실시간으로 클라이언트와 서버가 상태를 업데이트 해야할때 사용하게 됨
- 로그아웃을 하면 세션이 종료됨
- 다만 세션이 유지되기 때문에 통신중인 서버가 항상 구동 중 이여야하며 서버에 결점이 생기면 데이가 손실되거나 복구가 어려운 큰 문제가 발생할 우려가 있음(카카오톡 서버 터졌을때 처럼)

---

> 작성자 : KUN

## Q. DNS 는 사용자가 IP 주소보단 알아보기 쉬운 도메인이름을 IP 주소에 할당하는 기능 입니다. 그렇다면 NAVER.COM 과 NEVER.COM YOUTUBE 와 YUUTUBE 처럼 유사한 도메인은 어떤 문제가 되고 어떻게 대처가 될까요?

유명한 사이트의 도메인을 유사하게 사용하는경우
이는 일종의 도메인 스쿼팅 (Domain Squatting)
이라고 볼수 있습니다.

이로써 벌어지는 문제는

- 1. 혼란유발: 유사한 도메인을 사용하는경우 사용자의 혼란을 유발시킬수 있습니다. 이를 악용하여 악성코드를 뿌리는 사람들도있음
  2. 상표권 침해: 유사한 도메인을 사용하고 사이트 자체도 유사하게 만들었다면 상표권침해를 할수있습니다 상표권 소유자는 해당 도메인을 통제하기위해 법적 분쟁을 걸수도 있습니다.

### 하지만 문제는 유사한 도메인을 사용하지만 두사이트가 전혀 다른 성향의 사이트일때 문제가 될수있습니다.이러한경우엔 상표권을 침해하지도 않았을뿐더러 유사한 도메인이라고 할지라도 내용물은 전혀 다른사이트이기 때문에 이를 법적으로 분쟁을 걸 껀덕지가 없습니다.

![image](https://github.com/team-imad-study/study-question/assets/136051281/8b6194f0-0af2-4998-88ee-074920551f78)

실제로 never.com의 경우 전혀 관련없어보이는 의미를 알수없는 사이트가 도메인으로 연결되어있음

그래서 좀더 대형 사이트의 경우 아래 사진의 DNS 의 특성을 이용하여 여러 유사한 도메인을 전부 구매해 하나의 IP주소로 리디렉션하는 방식을 사용하기도함



![DNS_특성](https://github.com/team-imad-study/study-question/assets/136051281/61541876-2156-4728-b97a-d6b94e371da2)

---

> 작성자 : PCYSB

## Q. 해당 그림에서 불필요하게 경로를 돌아서 가고 있을때 이때 router 2번은 어떤 역할 을 할까? 

([#1](https://github.com/team-imad-study/study-question/issues/5) 참고)

![스크린샷 2024-02-07 063515](https://github.com/team-imad-study/study-question/assets/108323826/1f65a04b-9074-47d4-9f68-d7ea3f5d6cf7)

ICMP Redirect는 ICMP 프로토콜 중 하나의 타입으로, 더 좋은 경로가 있으면 라우터가 ICMP Redirect 패킷을 호스트에게 보내준다. 때문에 해당 라우터가 최적의 경로임을 호스트에게 알려주기 위하여 라우터로부터 호스트로 보내어주며 Host의 라우팅 테이블이 변경된다.

![스크린샷 2024-02-07 063505](https://github.com/team-imad-study/study-question/assets/108323826/3e32e4a9-a5d6-4ca4-8028-6af487406885)

참고
> - [ICMP에 대한 설명](https://www.youtube.com/watch?v=tos6Wlfkb18&t=912s)

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

---

# DAY12
작성일 : 2024/02/13

> 범위
- 47 SSH
- 48 FTP
- 49 NTP
- 50 Ajax, REST API

---

> 작성자 : NCookie

## 공개키(비대칭키) 암호화 방식으로 데이터를 주고 받는 과정을 설명하시오. (A, B, Cracker)

A와 B는 각각 모두가 볼 수 있는 공개키와 자기만이 가지고 있는 개인키를 가지고 있다. 
(이 때 암호화 방식에 따라 다양한 알고리즘과 프로세스를 사용하여 공개키와 개인키 쌍을 생성한다. 대표적인 알고리즘으로 RSA, ECC, DSA 등이 있다.)

### A가 B에게 데이터를 보낼 때

- A 측에서 보내려는 평문 데이터(plain data)를 B의 공개키로 암호화한다. (encryption) 
- 이 데이터를 받은 B는 자신의 개인키로 해독한다. (decryption)
- B의 공개키와 개인키는 서로 쌍(pair)이기 때문에 이와 같이 해석할 수 있다.
- Cracker는 A와 B의 공개키를 알고 있더라도 개인키를 알지 못하기 때문에 데이터를 해석할 수 없다.

### 전자서명 응용

- A가 B에게 데이터를 보낼 때 본문 데이터 뒤에 자신의 개인키로 본문을 암호화한 데이터(전자서명)를 추가한다.
- B는 본문 데이터를 해석한 후, A의 개인키로 암호화한 데이터를 A의 공개키로 해석해서 본문과 전자서명 부분이 일치하는지 확인한다.
- A와 B의 공개키를 탈취한 해커가 B에게 데이터를 보내려고 해도, A의 공개키와 매칭되는 개인키가 없기 때문에 전자서명 부분이 일치하지 않는다.
- 전자서명을 사용하면 송신자의 인증과 신원 확인, 데이터의 무결성 보장 등의 이점이 있다.

> 참고
> - [암호학1 - 4.1. 양방향 암호화 - 비대칭키(공개키 방식) - 기밀성을 위해서 사용하기](https://www.youtube.com/watch?v=MR4sCU82tgo&ab_channel=%EC%83%9D%ED%99%9C%EC%BD%94%EB%94%A9)
> - [암호법1 - 4.2. 양방향 암호화 - 비대칭키(공개키) - 전자 서명하는 방법 (이벤트는 본문을 참고해주세요!)](https://www.youtube.com/watch?v=O7SiDuTCysM&ab_channel=%EC%83%9D%ED%99%9C%EC%BD%94%EB%94%A9)

---
> 작성자 :
---
> 작성자 :
---
> 작성자 : Quarang

# 문제. 왜 URI는 대부분 명사형으로 되어있을까?
![스크린샷 2024-02-14 오후 6 06 18](https://github.com/team-imad-study/study-question/assets/31721255/b468d6c6-e69a-4c93-b7d6-9bc9e96cc67d)
![스크린샷 2024-02-14 오후 6 06 24](https://github.com/team-imad-study/study-question/assets/31721255/d16f1b9d-2c4f-4bd3-98f9-c9834b02ffa6)

아래의 개념과 같이 설명
> RestAPI란?

Rest(Representational State Transfer)ful API는 자원을 이름으로 구분하여 해당자원의 상태를 주고받는 API 아키텍쳐 방식임.
- HTTP프로토콜을 사용하여 자원을 명시함
- CRUD 작업을 위한 메서드(get,post,patch,delete 등)사용

> 그럼 CRUD란?

CRUD는 대부분의 컴퓨터 소프트웨어가 가지는 기본적인 데이터 처리 기능인 Create(생성), Read(읽기), Update(갱신), Delete(삭제)를 묶어서 일컫는 말

> RestAPI의 설계 예시

1. 동사보다 명사를 사용해야함
   
-  HTTP에서 제공하는 메서드가 기능을 포함한 동사형을 사용하고 있기 때문
  
```
GET https://baseURL.com/apple/delete (X)
Delete https://baseURL.com/apple (O)
```

2. 마지막에 슬래시 (/)를 포함하지 않음
```
Delete https://baseURL.com/apple/ (X)
Delete https://baseURL.com/apple (O)
```
이것 외에도 설계 규칙 여러가지 존재

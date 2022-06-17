# Stop Watch 만들기 (기말 과제)
Stop Watch를 이용해 시간을 체크할 수 있습니다.

---
## 완성된 모습
![스크린샷 2022-06-10 오후 4 43 39](https://user-images.githubusercontent.com/106981296/173396452-6ae8ee52-fc3a-475b-9406-b3c03203f2e6.png)

---
## 기능
* START 버튼을 누르면 초시계가 동작하고, 파란색 START 버튼 대신 빨간색 STOP 버튼으로 변경됩니다.  
![스크린샷 2022-06-10 오후 4 43 48](https://user-images.githubusercontent.com/106981296/173396930-69993b41-a630-4959-b02a-25023eff6f6e.png)  

* STOP 버튼을 누르면 초시계가 동작을 멈추고, STOP 버튼이 초록색 START 버튼으로 변경됩니다.  
 ![스크린샷 2022-06-10 오후 4 44 00](https://user-images.githubusercontent.com/106981296/173397523-228a9fcc-40f7-4174-9fd8-1ebd5973a276.png)

* RESET 버튼을 누르면 Alert을 통해 "Timer를 Reset 하시겠습니까?" 라는 문구가 나옵니다.  
![스크린샷 2022-06-10 오후 4 44 09](https://user-images.githubusercontent.com/106981296/173397979-1761dfe1-e7c5-4eaf-b9d2-878968550314.png)  

* 예 버튼을 누르면 초시계가 초기 상태로 돌아갑니다.  

![스크린샷 2022-06-10 오후 4 43 39](https://user-images.githubusercontent.com/106981296/173398413-0ddcfcb7-ae45-4624-8b6e-66a2d2816df6.png)

---
## 전체 소스
![스크린샷 2022-06-10 오후 4 42 14](https://user-images.githubusercontent.com/106981296/173398523-179aa6f3-ccb8-4dcc-ac42-ffbefbb5b92f.png)
![스크린샷 2022-06-10 오후 4 42 24](https://user-images.githubusercontent.com/106981296/173398557-fba95fe0-b1df-4910-8e47-6f84c8bcdc42.png)

---

## 주요 코드 해석

```SWIFT
// 타이머가 설정한 간격대로 실행되는지 확인하기 위한 변수로. Int형으로 선언하고 0으로 초기화 하였습니다.
var count:Int = 0
```

```SWIFT
// START(STOP) 버튼의 색을 초록색으로 초기화합니다.
startStopButton.setTitleColor(UIColor.green, for: .normal)
```

```SWIFT
// timerCounting이 false(동작하지 않고 있다)면 버튼에 START가 초록색으로 표시됩니다. 
if(timerCounting)
{
     timerCounting = false
     timer.invalildate()
     startStopButton.setTitle("START", for: .normal)
     startStopButton.setTitleColor(UIColor.green, for: .normal)
 }
 
 // timerCounting이 true(동작하고 있다)면 버튼에 STOP이 빨간색으로 표시됩니다.
 else
 {
     timerCounting = true
     startStopButton.setTitle("STOP", for: .normal)
     startStopButton.setTitleColor(UIColor.red, for: .normal)
     timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
     }
  }
```

* Timer.scheduledTimer() 함수
```SWIFT
/* 
timeInterval : 타이머 실행 시간. 해당 시간 간격으로 메시지(selector)를 보냅니다.
target: 타이머가 실행될 때 메시지를 보낼 개체. 일반적으로 self를 사용합니다.
selector : 타이머 실행될 때 보낼 메시지 (func)
userInfo: 사용자 정보. 필요 없는 경우 nil을 사용합니다.
repeats: 타이머를 반복할 것인지에 대한 여부입니다. true - 반복, false - 1회
*/
scheduledTimer(timeInterval:, target:, selector:, userInfo:, repeats:)
```

시간, 분, 초를 표시합니다.
```SWIFT
// 아래와 같은 코드로 계산한 뒤
return((seconds / 3600), ((seconds % 3600) / 60), ((seconds % 3600) % 60))

// 시간, 분, 초로 나타냅니다.
{
var timeString = ""
timeString += String(format: "%02d", hours)
timeString += " : "
timeString += String(format: "%02d", minutes)
timeString += " : "
timeString += String(format: "%02d", seconds)
return timeString
}
```
Reset 버튼이 작동하도록 설정합니다.
```SWIFT
// 아래 함수를 사용해 Alert의 전체를 디자인합니다.
UIAlertController(title: "Timer를 Reset 하시겠습니까?", message:"타이머를 재설정 하시겠습니까?", preferredStyle: alert)

// 아래 함수를 사용해 Alert의 세부내용을 추가합니다.
alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { (_) in)}
alert.addAction(UIAlertAction(title: "예", style: .default, handler: { (_) in)}
```

아래 코드를 추가해 Alert의 '예' 버튼을 누르면 시간이 초기화 되도록 설정합니다.
```SWIFT
self.TimerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
```

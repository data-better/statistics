# 필요한 패키지 불러오기
library(shiny)
library(ggplot2)
library(dplyr)

# 타이타닉 데이터 불러오기
titanic <- read.csv("https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv")

# R shiny 앱 만들기
ui <- fluidPage(
  # 제목
  titlePanel("타이타닉 데이터 분석"),
  # 사이드바
  sidebarLayout(
    # 사이드바 패널
    sidebarPanel(
      # 슬라이더 인풋: 나이 범위 선택
      sliderInput("age", "나이 범위:", min = 0, max = 80, value = c(0, 80)),
      # 라디오 버튼: 성별 선택
      radioButtons("sex", "성별:", choices = c("전체", "남성", "여성"), selected = "전체"),
      # 체크박스: 생존 여부 선택
      checkboxGroupInput("survived", "생존 여부:", choices = c("생존", "사망"), selected = c("생존", "사망"))
    ),
    # 메인 패널
    mainPanel(
      # 플롯 출력: 그래프 출력
      plotOutput("plot")
    )
  )
)

server <- function(input, output) {
  # 필터링된 데이터 생성
  filtered_data <- reactive({
    data <- titanic
    data$Sex <- gsub("female", "여성", data$Sex)
    data$Sex <- gsub("male", "남성", data$Sex) 
    data$Survived <- gsub(0, "사망", data$Survived)
    data$Survived <- gsub(1, "생존", data$Survived)
    data$Pclass <- as.factor(data$Pclass)
    # 나이 범위에 따라 필터링
    data <- data %>% filter(Age >= input$age[1] & Age <= input$age[2])
    # 성별에 따라 필터링
    if (input$sex != "전체") {
      data <- data %>% filter(Sex == input$sex)
    }
    # 생존 여부에 따라 필터링
    data <- data %>% filter(Survived %in% input$survived)
    data
  })
  
  # 그래프 생성
  output$plot <- renderPlot({
    # 필터링된 데이터 사용
    data <- filtered_data()
    # ggplot 객체 생성
    p <- ggplot(data, aes(x = Pclass, y = Fare, color = Survived)) + geom_boxplot()
    # 그래프 제목 추가
    p <- p + labs(title = "타이타닉 데이터: 객실 등급과 운임에 따른 생존 여부")
    p
  })
}

# 앱 실행
shinyApp(ui = ui, server = server)
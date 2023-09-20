  observeEvent(input$submit, {
    # 回答を処理するコードを追加する
    # input$question1, input$question2などを使用して回答にアクセスできる
    # 例: 回答をデータフレームに保存する
    responses <- data.frame(
      Question1 = input$question1,
      Question2 = input$question2
    )
    # データフレームの保存など、必要な処理を追加する
    if(file.exists("responses.csv")){
      refile<-read.csv("responses.csv")
      cobin<-rbind(refile,responses)
write.csv(cobin,"responses.csv", row.names = FALSE)

    }else{
     write.csv(responses, "responses.csv", row.names = FALSE) 
    }
    

    # 送信後に表示するメッセージを表示する
    showModal(modalDialog(
      title = "send comp",
      "アンケートの回答を受け付けました。",
      easyClose = TRUE
    ))
    
  })
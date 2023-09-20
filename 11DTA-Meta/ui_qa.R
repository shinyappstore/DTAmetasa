
           tabPanel(
               "mo",
               radioButtons("question1", "質問1: 以下の選択肢から選んでください", 
                                  choices = c("選択肢1", "選択肢2", "選択肢3")),
               radioButtons("question2", "質問2: 以下の 選択肢から1つ選んでください",
                            choices = c("選択肢A", "選択肢B", "選択肢C")),
               actionButton("submit", "送信")
           )
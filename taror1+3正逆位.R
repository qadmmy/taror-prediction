library(shiny)
library(ggplot2)
library(ggimage)

# 在app.R顶部添加www文件路径
addResourcePath("www", "C:/Users/26223/Documents/www")

# Tarot database
tarot_db <- list(
  # 0 愚者
  list(
    name = "0",  
    title = "愚者", 
    desc = "愚者象征新的开始、冒险精神和对未知的渴望。它代表一种无忧无虑的心态，充满了可能性和潜力。愚者站在悬崖边，象征着他即将踏上一段未知的旅程，带着信念和勇气。",
    upright = "正位的愚者提醒我们要勇敢地拥抱未知，敢于冒险，尝试新事物。它象征着新的机会和潜在的成长。",
    reversed = "逆位的愚者暗示鲁莽行事或缺乏计划，可能会导致不必要的风险。它提醒我们在行动之前要三思而后行。",
    advice = list(
      学业 = "学习中要敢于尝试新的方法，不要害怕失败，因为失败是学习的一部分。",
      爱情 = "在感情中保持真诚和开放的心态，勇敢表达自己的感受。",
      事业 = "面对事业上的新机会时，要有冒险精神，但也要确保有一定的计划。",
      财运 = "在投资或财务决策时，要谨慎评估风险，避免冲动行事。"
    )
  ),
  
  # 1 魔术师
  list(
    name = "1",  
    title = "魔术师", 
    desc = "魔术师象征创造力、行动力以及整合资源的能力。他手握象征无限可能的工具，代表他拥有实现目标的一切条件。",
    upright = "正位的魔术师预示着你拥有实现目标的能力，只要善用手头的资源，行动起来，就能创造奇迹。",
    reversed = "逆位的魔术师可能暗示资源浪费或能量的分散，提醒我们不要浪费时间在无意义的事情上。",
    advice = list(
      学业 = "制定高效的学习计划，合理分配时间和精力，充分利用资源。",
      爱情 = "在感情中主动沟通，展现你的真诚和魅力。",
      事业 = "展现你的能力和创造力，勇敢地承担责任，提升自己的影响力。",
      财运 = "通过合理规划和创新思维，可以实现财务上的突破。"
    )
  ),
  
  # 2 女祭司
  list(
    name = "2",  
    title = "女祭司", 
    desc = "女祭司代表内在的智慧、直觉以及对神秘领域的探索。她象征着隐藏的知识和对内心世界的深入理解。",
    upright = "正位的女祭司提醒我们倾听内心的声音，信任自己的直觉，并深入探索未知的领域。",
    reversed = "逆位的女祭司可能暗示忽视内心的声音，或是被困于迷茫中，无法做出明确的决定。",
    advice = list(
      学业 = "相信你的直觉，在学习中找到适合自己的方法，不要盲目跟随他人。",
      爱情 = "保持一些神秘感，但也要学会倾听和理解对方的感受。",
      事业 = "在事业中，听从内心的指引，找到适合自己的方向。",
      财运 = "在投资或财务决策中，要谨慎行事，避免被表面的信息所迷惑。"
    )
  ),
  
  # 3 皇后
  list(
    name = "3",  
    title = "皇后", 
    desc = "皇后象征丰盈、滋养和创造力，她是自然的化身，代表着生命的孕育和成长。她充满了爱与关怀。",
    upright = "正位的皇后提醒我们要注重自我照顾，同时也要关爱他人，创造一个和谐的环境。",
    reversed = "逆位的皇后可能暗示过度依赖他人或懒散的态度，提醒我们要保持独立和自律。",
    advice = list(
      学业 = "在学习中注重平衡，既要努力，也要保证身心健康。",
      爱情 = "在感情中培养深厚的感情，注重与伴侣的沟通和理解。",
      事业 = "展现你的领导力和创造力，打造一个充满活力的团队。",
      财运 = "在理财方面要谨慎，不要过度依赖他人，学会独立决策。"
    )
  ),
  
  # 4 皇帝
  list(
    name = "4",  
    title = "皇帝", 
    desc = "皇帝象征权威、稳定和秩序。他是一个强大的领导者，代表着理性和结构化的思维。",
    upright = "正位的皇帝提醒我们要建立秩序，保持专注，并以坚定的决心去实现目标。",
    reversed = "逆位的皇帝可能暗示权力的滥用或过度控制，提醒我们要学会放手和信任他人。",
    advice = list(
      学业 = "坚定决心，保持专注，不要被外界干扰所影响。",
      爱情 = "在感情中保持理性，避免过度控制对方。",
      事业 = "展现你的领导力和决断力，带领团队走向成功。",
      财运 = "在财务规划中，要有长远的眼光，合理规划未来。"
    )
  ),
  
  # 5 教皇
  list(
    name = "5",  
    title = "教皇", 
    desc = "教皇象征传统、智慧和精神信仰。他是知识的守护者，代表着对规则和道德的遵守。",
    upright = "正位的教皇提醒我们要寻求智慧，遵循传统，并从中找到内心的平静。",
    reversed = "逆位的教皇可能暗示对规则的叛逆或缺乏信念，提醒我们要重新审视自己的价值观。",
    advice = list(
      学业 = "寻找导师的指导，学习经验，遵循有效的学习方法。",
      爱情 = "在感情中保持真诚与忠诚，建立信任的关系。",
      事业 = "遵循既有规则，同时也要保持开放的心态，适应变化。",
      财运 = "在财务方面，审视自己的信念与价值观，避免盲目跟随潮流。"
    )
  ),
  
  # 6 恋人
  list(
    name = "6",  
    title = "恋人", 
    desc = "恋人象征爱情、选择和和谐。它代表了人与人之间的深厚联系，也暗示着重要的选择。",
    upright = "正位的恋人提醒我们要真诚沟通，建立深厚的情感联系，同时也要做出符合内心的选择。",
    reversed = "逆位的恋人可能暗示错误的选择或感情中的不和谐，提醒我们要重新审视关系。",
    advice = list(
      学业 = "在学习中选择适合自己的方向，不要盲目跟风。",
      爱情 = "真诚沟通，表达自己的感受，避免误解。",
      事业 = "与他人合作共赢，建立和谐的团队关系。",
      财运 = "在财务决策中要慎重，避免感情用事。"
    )
  ),
  
  # 7 战车
  list(
    name = "7",  
    title = "战车", 
    desc = "战车象征自信、决心和胜利。它代表了克服障碍和掌控局面的能力。",
    upright = "正位的战车提醒我们要坚定信念，迎接挑战，最终取得胜利。",
    reversed = "逆位的战车可能暗示失控或自负，提醒我们要调整方向，重新掌控局势。",
    advice = list(
      学业 = "坚持目标，克服学习中的困难，最终会取得好成绩。",
      爱情 = "坚定信念，勇敢面对感情中的挑战。",
      事业 = "勇敢迎接事业中的挑战，展现你的领导力。",
      财运 = "在财务方面要注意调整方向，避免不必要的损失。"
    )
  ),
  
  # 8 力量
  list(
    name = "8",  
    title = "力量", 
    desc = "力量象征勇气、耐性和内在的力量。它代表了通过温和和信念来克服困难。",
    upright = "正位的力量提醒我们要掌控内心的恐惧，展现耐心和爱心，最终会获得成功。",
    reversed = "逆位的力量可能暗示恐惧和焦虑，提醒我们要重新找回内心的力量。",
    advice = list(
      学业 = "坚持到底，不要因为一时的挫折而放弃。",
      爱情 = "展现耐心和爱心，与伴侣共同面对问题。",
      事业 = "充满信心，勇敢面对工作中的挑战。",
      财运 = "保持冷静，理性面对财务上的问题。"
    )
  ),
  # 9 隐士
  list(
    name = "9",  
    title = "隐士", 
    desc = "隐士象征独立、深思和智慧。他代表了一种内向的力量，提醒我们通过内省和独处来寻找答案。",
    upright = "正位的隐士提醒我们要自我反思，远离外界干扰，找到内心的平静和智慧。",
    reversed = "逆位的隐士可能暗示孤立或逃避现实，提醒我们不要过度封闭自己。",
    advice = list(
      学业 = "独立思考，不要被外界的声音干扰，找到适合自己的学习方式。",
      爱情 = "在感情中需要一些独立的空间，重新审视自己内心的需求。",
      事业 = "保持冷静，独立分析问题，找到正确的解决方案。",
      财运 = "在财务方面要谨慎行事，避免盲目跟随他人的建议。"
    )
  ),
  
  # 10 命运之轮
  list(
    name = "10",  
    title = "命运之轮", 
    desc = "命运之轮象征着命运的转折和变化。它代表了人生的循环，提醒我们要接受变化并顺势而为。",
    upright = "正位的命运之轮预示好运的到来，提醒我们抓住机会，迎接人生的转折点。",
    reversed = "逆位的命运之轮可能暗示停滞或失控，提醒我们要保持灵活性，适应变化。",
    advice = list(
      学业 = "顺势而为，接受学习中的变化，找到新的学习方法。",
      爱情 = "在感情中学会适应变化，灵活应对新的挑战。",
      事业 = "事业中可能会面临一些变化，要保持开放的心态。",
      财运 = "财务方面的变化可能带来新的机会，要抓住时机。"
    )
  ),
  
  # 11 正义
  list(
    name = "11",  
    title = "正义", 
    desc = "正义象征公平、平衡和责任。它提醒我们要以理性和公正的态度对待生活中的问题。",
    upright = "正位的正义提醒我们要保持理性，做出公正的判断，并承担自己的责任。",
    reversed = "逆位的正义可能暗示偏见或不公，提醒我们要重新审视自己的行为和决定。",
    advice = list(
      学业 = "在学习中保持公平与公正，不要试图投机取巧。",
      爱情 = "理性处理感情问题，避免因情绪化而做出错误的决定。",
      事业 = "在工作中做到公正与诚信，赢得他人的信任。",
      财运 = "审视自己的财务状况，确保透明和合法。"
    )
  ),
  
  # 12 倒吊人
  list(
    name = "12",  
    title = "倒吊人", 
    desc = "倒吊人象征放弃、转变和牺牲。他提醒我们要从不同的角度看待问题，接受必要的牺牲以获得成长。",
    upright = "正位的倒吊人提醒我们要放下执念，接受改变，并从中获得新的启示。",
    reversed = "逆位的倒吊人可能暗示固执或拖延，提醒我们要打破僵局，采取行动。",
    advice = list(
      学业 = "不要害怕改变学习方法，尝试新的学习策略。",
      爱情 = "感情中需要妥协与让步，才能维持关系的平衡。",
      事业 = "从不同的视角看待问题，找到新的解决方案。",
      财运 = "暂停不必要的行动，重新审视财务目标。"
    )
  ),
  
  # 13 死神
  list(
    name = "13",  
    title = "死神", 
    desc = "死神象征结束、变革和新生。它并不代表死亡，而是提醒我们接受旧事物的结束，为新的开始做好准备。",
    upright = "正位的死神提醒我们要接受变化，放下过去，以迎接新的机会。",
    reversed = "逆位的死神可能暗示对改变的抗拒，提醒我们要勇敢面对不可避免的转变。",
    advice = list(
      学业 = "结束旧有的学习模式，接受新的学习挑战。",
      爱情 = "放下过去的感情，才能迎接新的爱情。",
      事业 = "转变和改变可能会带来新的机遇，勇敢面对。",
      财运 = "接受财务上的变化，适应新的环境。"
    )
  ),
  
  # 14 节制
  list(
    name = "14",  
    title = "节制", 
    desc = "节制象征平衡、调和和适度。它提醒我们要在生活中找到平衡点，避免走向极端。",
    upright = "正位的节制提醒我们要保持和谐，控制情绪，做出明智的选择。",
    reversed = "逆位的节制可能暗示失衡或极端行为，提醒我们要重新调整自己的状态。",
    advice = list(
      学业 = "在学习中注重平衡，合理安排时间，避免过度劳累。",
      爱情 = "保持和谐和理解，与伴侣共同面对问题。",
      事业 = "在工作中找到平衡点，避免过度投入或忽视其他方面。",
      财运 = "避免冲动消费，理性管理财务。"
    )
  ),
  
  # 15 魔鬼
  list(
    name = "15",  
    title = "魔鬼", 
    desc = "魔鬼象征诱惑、束缚和物质欲望。它提醒我们要警惕被负面情绪或物质所控制。",
    upright = "正位的魔鬼提醒我们要摆脱束缚，重新掌控自己的生活。",
    reversed = "逆位的魔鬼可能暗示解脱和自由，提醒我们要突破内心的限制。",
    advice = list(
      学业 = "警惕分心与诱惑，专注于真正重要的事情。",
      爱情 = "避免沉溺于不健康的关系，学会保护自己。",
      事业 = "不要被物质诱惑所困，保持清醒的头脑。",
      财运 = "审视自己的消费行为，避免陷入债务或过度消费。"
    )
  ),
  
  # 16 塔
  list(
    name = "16",  
    title = "塔", 
    desc = "塔象征突如其来的改变与毁灭。它提醒我们要接受变化，清理旧有的不稳定结构。",
    upright = "正位的塔提醒我们要直面挑战，勇于接受改变，并从中重建新的秩序。",
    reversed = "逆位的塔可能暗示避免彻底崩溃，提醒我们要提前预防危机。",
    advice = list(
      学业 = "面对学习中的挑战，勇敢接受改变，找到新的方向。",
      爱情 = "破除旧有束缚，重建新的感情基础。",
      事业 = "准备好迎接突发情况，保持灵活应对。",
      财运 = "审慎应对经济动荡，做好风险管理。"
    )
  ),
  
  # 17 星星
  list(
    name = "17",  
    title = "星星", 
    desc = "星星象征希望、灵感与祝福。它代表了光明的未来和对梦想的追求。",
    upright = "正位的星星提醒我们要保持乐观，展现创造力，并相信未来会更好。",
    reversed = "逆位的星星可能暗示失望或幻灭，提醒我们要重新点燃希望。",
    advice = list(
      学业 = "保持乐观，展现创造力，找到学习中的乐趣。",
      爱情 = "信任你的直觉和希望，感情会迎来新的转机。",
      事业 = "你正走在正确的道路上，坚持下去。",
      财运 = "保持乐观，机遇就在眼前，不要轻易放弃。"
    )
  ),
  
  # 18 月亮
  list(
    name = "18",  
    title = "月亮", 
    desc = "月亮象征迷惑、直觉和潜意识。它提醒我们要倾听内心的声音，警惕潜藏的风险。",
    upright = "正位的月亮提醒我们要倾听内心，信任直觉，并警惕迷惑。",
    reversed = "逆位的月亮可能暗示困惑或不确定，提醒我们要理清思路。",
    advice = list(
      学业 = "保持警觉，不要被困惑迷失方向。",
      爱情 = "直觉是你最好的指引，信任自己的感受。",
      事业 = "警惕潜藏的风险，避免被表象所迷惑。",
      财运 = "避免过度冒险，理性管理财务。"
    )
  ),
  
  # 19 太阳
  list(
    name = "19",  
    title = "太阳", 
    desc = "太阳象征成功、喜悦和清晰。它代表了光明、幸福和成就。",
    upright = "正位的太阳提醒我们要勇敢表现自己，迎接成功和幸福。",
    reversed = "逆位的太阳可能暗示虚伪或误导，提醒我们要保持真实。",
    advice = list(
      学业 = "勇敢表现自己，学习中会迎来成功。",
      爱情 = "真诚相待，感情会走向幸福。",
      事业 = "成功是你的目标，继续努力。",
      财运 = "财富到来，享受成果，但不要忘记规划未来。"
    )
  ),
  
  # 20 审判
  list(
    name = "20",  
    title = "审判", 
    desc = "审判象征觉醒、审视和重生。它提醒我们要重新审视自己的生活，迎接新的开始。",
    upright = "正位的审判提醒我们要觉醒并接受改变，走向新的阶段。",
    reversed = "逆位的审判可能暗示拒绝改变或逃避责任，提醒我们要直面现实。",
    advice = list(
      学业 = "是时候审视你的学习方式，找到更有效的途径。",
      爱情 = "重新审视你与伴侣的关系，找到问题的根源。",
      事业 = "准备迎接重生与突破，勇敢追求新的机会。",
      财运 = "关注财务状况，做出必要的调整。"
    )
  ),
  
  # 21 世界
  list(
    name = "21",  
    title = "世界", 
    desc = "世界象征圆满、完成与成就。它代表了一个阶段的结束和新的开始。",
    upright = "正位的世界提醒我们要庆祝成功，同时为新的目标做好准备。",
    reversed = "逆位的世界可能暗示停滞或未完成，提醒我们要坚持到底。",
    advice = list(
      学业 = "你正接近成功，继续努力，完成最后的目标。",
      爱情 = "感情会走向稳定与圆满，珍惜现在的幸福。",
      事业 = "达成目标后，向更高的层次迈进。",
      财运 = "享受成功的回报，同时继续保持良好的规划。"
    )
  )
)

# 塔罗牌数据库和图片路径配置
tarot_dir <- "C:/Users/26223/Documents/www/taror"
tarot_images <- c(sapply(0:21, function(i) {
  sprintf("%s/%02d_%s.jpg", tarot_dir, i, tarot_db[[i + 1]]$title)
}), back = paste0(tarot_dir, "/back.jpg"))

# UI界面
ui <- fluidPage(
  tags$style(HTML("
    .main-container { 
      background: linear-gradient(to bottom, #2c3e50, #3498db) !important;
      height: 100vh;
      padding: 20px;
      color: white;
    }
    .card-grid {
      display: grid;
      grid-template-columns: repeat(6, 1fr);
      gap: 15px;
      margin-bottom: 20px;
    }
   .tarot-card {
  width: 120px;  /* 卡牌容器宽度 */
  height: auto;  /* 高度自适应 */
  cursor: pointer;
  transition: transform 0.3s;
  border-radius: 10px;
  overflow: hidden;
  position: relative;
  aspect-ratio: 3 / 5; /* 设置宽高比为3:5 */
}

.tarot-card:hover {
  transform: translateY(-5px);
}

.card-label {
  position: absolute;
  bottom: 5px; /* 标签在图片底部 */
  left: 50%;
  transform: translateX(-50%);
  color: white;
  font-weight: bold;
  font-size: 14px;
  text-shadow: 1px 1px 2px black; /* 添加阴影 */
  background: rgba(0, 0, 0, 0.7); /* 半透明黑色背景 */
  padding: 5px 10px;
  border-radius: 5px;
  z-index: 10; /* 确保标签在图片上方 */
}
  ")),
  
  # 添加背景音乐
  tags$audio(
    src = "www/Sarah_Brightman.mp3",
    type = "audio/mp3",
    autoplay = TRUE,
    loop = TRUE,
    controls = TRUE,
    style = "display:none;"
  ),
  
  div(class = "main-container",
      fluidRow(
        column(8,
               div(class = "card-grid",
                   lapply(1:22, function(i) {
                     div(class = "tarot-card",
                         style = "position: relative;",
                         div(style = "position: absolute; width: 100%; height: 100%;",
                             imageOutput(paste0("card", i), click = paste0("card_click", i)),
                             uiOutput(paste0("card_label", i))  # 动态标签
                         )
                     )
                   })
               )
        ),
        column(4,
               selectInput("mode", "选择预测模式:", 
                           choices = c("三张塔罗预测", "每日塔罗预测")),
               selectInput("question", "选择询问事项:", 
                           choices = c("学业", "爱情", "事业", "财运")),
               uiOutput("suggestions")
        )
      )
  )
)

server <- function(input, output, session) {
  # 随机打乱卡牌顺序
  random_order <- sample(1:22)
  selected <- reactiveVal(character(0))
  orientations <- reactiveVal(list())  # 用于存储正逆位
  
  # 生成卡牌图片和标签
  lapply(1:22, function(i) {
    # 修改图片显示样式
    output[[paste0("card", i)]] <- renderImage({
      card_id <- as.character(random_order[i])
      is_selected <- card_id %in% selected()
      orientation <- orientations()[[card_id]]  # 获取正逆位信息
      
      # 图片路径和旋转角度
      img_src <- if (is_selected) tarot_images[random_order[i]] else tarot_images["back"]
      rotation <- if (is_selected && orientation == "逆位") "rotate(180deg)" else "none"
      
      list(
        src = img_src,
        contentType = "image/jpeg",
        style = paste0("width: 100%; height: auto; transform:", rotation, "; object-fit: contain;")  # 确保比例正确
      )
    }, deleteFile = FALSE)
    
    # 修改正逆位和名称显示样式
    output[[paste0("card_label", i)]] <- renderUI({
      card_id <- as.character(random_order[i])
      if (card_id %in% selected()) {
        card <- tarot_db[[as.numeric(card_id)]]
        orientation <- orientations()[[card_id]]
        div(class = "card-label", paste0(card$title, " (", orientation, ")"))
      } else {
        NULL
      }
    })
  })
  
  # 点击事件处理
  lapply(1:22, function(i) {
    observeEvent(input[[paste0("card_click", i)]], {
      card_id <- as.character(random_order[i])
      if (input$mode == "三张塔罗预测") {
        current <- selected()
        if (!card_id %in% current) {
          if (length(current) < 3) {
            # 随机生成正逆位
            orientation <- ifelse(runif(1) > 0.5, "正位", "逆位")
            orientations(modifyList(orientations(), setNames(list(orientation), card_id)))
            selected(c(current, card_id))
          }
        }
      } else if (input$mode == "每日塔罗预测") {
        if (length(selected()) == 0) {
          # 随机生成正逆位
          orientation <- ifelse(runif(1) > 0.5, "正位", "逆位")
          orientations(modifyList(orientations(), setNames(list(orientation), card_id)))
          selected(card_id)
        }
      }
    })
  })
  
  # 显示建议
  output$suggestions <- renderUI({
    if (input$mode == "三张塔罗预测") {
      if (length(selected()) == 3) {
        cards <- lapply(selected(), function(card_id) {
          card <- tarot_db[[as.numeric(card_id)]]
          orientation <- orientations()[[card_id]]
          
          div(style = "margin-bottom: 20px;",
              h4(paste(card$title, orientation)),
              p(strong("解释: "), card$desc),
              p(strong("建议: "), card$advice[[input$question]])
          )
        })
        
        tagList(
          h3("🔮 抽牌结果:"),
          cards,
          actionButton("reset", "重新抽牌", class = "btn-warning")
        )
      } else {
        h4("请选择3张塔罗牌...")
      }
    } else if (input$mode == "每日塔罗预测") {
      if (length(selected()) == 1) {
        card <- tarot_db[[as.numeric(selected())]]
        orientation <- orientations()[[selected()]]
        
        tagList(
          h3("🔮 每日塔罗预测:"),
          div(style = "margin-bottom: 20px;",
              h4(paste(card$title, orientation)),
              p(strong("解释: "), card$desc),
              p(strong("学业建议: "), card$advice$学业),
              p(strong("爱情建议: "), card$advice$爱情),
              p(strong("事业建议: "), card$advice$事业),
              p(strong("财运建议: "), card$advice$财运)
          ),
          actionButton("reset", "重新抽牌", class = "btn-warning")
        )
      } else {
        h4("请选择1张塔罗牌...")
      }
    }
  })
  
  # 重置功能
  observeEvent(input$reset, {
    selected(character(0))
    orientations(list())
  })
}

shinyApp(ui, server)
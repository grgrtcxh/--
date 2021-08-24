-- 引入游戏资源模块
Resource = UsingModule("Resource")

-- 引入相关模块
Graphic = UsingModule("Graphic")
Interactivity = UsingModule("Interactivity")
Window = UsingModule("Window")
Time = UsingModule("Time")
Algorithm = UsingModule("Algorithm")

-- 玩家得分
score = 0

-- 玩家速度
xSpeed, ySpeed = 0.75, 3

-- 玩家在世界坐标系下的水平坐标
-- 初始值设置为负值避免出生点附近有障碍物
globalXPlayer = -150

-- 根据当前时间初始化随机数种子
math.randomseed(os.time())

-- 定义障碍物位置表并初始化
obstacle_list = {}
for i = 1, 5 do
    obstacle_list[i] = {
        -- 世界坐标系下的水平坐标值
        global_x = i * 200 + math.random(-50, 50),
        -- 可通过缝隙距离屏幕顶端距离
        exit_y = math.random(190, 310)
    }
end

-- 定义窗口位置和尺寸
rectWindow = {
    x = Window.WINDOW_POSITION_DEFAULT,
    y = Window.WINDOW_POSITION_DEFAULT,
    w = 288, h = 512
}

-- 定义玩家在屏幕中的坐标和大小
rectPlayer = {
    x = 35, y = rectWindow.h / 2 - 24,
    w = 48, h = 48
}

-- 创建游戏窗口
Window.CreateWindow("Flappy Bird", rectWindow, {})

-- 定义获取图片尺寸的函数
function GetImageRect(image)
    local _width, _height = image:GetSize()
    return {w = _width, h = _height}
end

-- 定义表存储游戏素材的渲染数据
rendered_list = {
    Bird = {
        Graphic.CreateTexture(Resource.Bird_1),
        Graphic.CreateTexture(Resource.Bird_2),
        Graphic.CreateTexture(Resource.Bird_3),
    },
    Background = {
        Day = {
            texture = Graphic.CreateTexture(Resource.BackgroundDay),
            rect = GetImageRect(Resource.BackgroundDay)
        },
        Night = {
            texture = Graphic.CreateTexture(Resource.BackgroundNight),
            rect = GetImageRect(Resource.BackgroundNight)
        }
    },
    Pipe = {
        Down = {
            texture = Graphic.CreateTexture(Resource.PipeDown),
            rect = GetImageRect(Resource.PipeDown)
        },
        Up = {
            texture = Graphic.CreateTexture(Resource.PipeUp),
            rect = GetImageRect(Resource.PipeUp)
        }
    },
    Number = {
        ["0"] = Graphic.CreateTexture(Resource.Number[1]),
        ["1"] = Graphic.CreateTexture(Resource.Number[2]),
        ["2"] = Graphic.CreateTexture(Resource.Number[3]),
        ["3"] = Graphic.CreateTexture(Resource.Number[4]),
        ["4"] = Graphic.CreateTexture(Resource.Number[5]),
        ["5"] = Graphic.CreateTexture(Resource.Number[6]),
        ["6"] = Graphic.CreateTexture(Resource.Number[7]),
        ["7"] = Graphic.CreateTexture(Resource.Number[8]),
        ["8"] = Graphic.CreateTexture(Resource.Number[9]),
        ["9"] = Graphic.CreateTexture(Resource.Number[10])
    }
}

-- 游戏退出标志位
bIsQuit = false

-- 背景图片动画效果两张图片分界线水平坐标
nBackgroundSplitPosX = rectWindow.w

-- 玩家背景图片渲染数据索引
nIndexPlayerRD = 1

-- 背景图片切换定时器
nTimerSwitchBackground = 0

-- 当前背景图片渲染数据
rdCurrentBackground = rendered_list.Background.Day

-- 已进行加分的障碍物对象
obstacleScoreAdded = {}

while not bIsQuit do

    -- 获取当前帧开始时间
    local _nStartTime = Time.GetInitTime()

    -- 清空上一帧绘制内容
    Window.ClearWindow()
    
    -- 更新并获取游戏事件，根据事件类型做出响应
    while Interactivity.UpdateEvent() do

        -- 获取当前事件类型
        local _event = Interactivity.GetEventType()

        -- 如果为退出事件，则将游戏退出标志位置为真
        if _event == Interactivity.EVENT_QUIT then
            bIsQuit = true
        -- 如果为空格键按下
        elseif _event == Interactivity.EVENT_KEYDOWN_SPACE then
            ySpeed = 3
        end

    end

    -- 更新玩家速度
    xSpeed, ySpeed = xSpeed + 0.00015, ySpeed - 0.045

    -- 更新玩家（垂直）位置
    rectPlayer.y = rectPlayer.y - ySpeed
    if rectPlayer.y <= 0 then
        rectPlayer.y = 0
        ySpeed = 0
    end

    -- 更新玩家在世界坐标系下的（水平）位置
    globalXPlayer = globalXPlayer + xSpeed

    -- 判断玩家是否与障碍物相撞，并且判断是否通过障碍物进行加分
    for index, obstacle in ipairs(obstacle_list) do
        -- 如果障碍物的水平距离当前玩家坐标一定范围之内
        if math.abs(obstacle.global_x - globalXPlayer) <= 120 then
            -- 如果玩家与当前位置的两个障碍物中的任何一个碰撞，都将结束游戏
            local _global_rectPlayer = {
                x = globalXPlayer + 13, y = rectPlayer.y + 13,
                w = rectPlayer.w - 26, h = rectPlayer.h - 26
            }
            bIsQuit = Algorithm.CheckRectsOverlap(
                _global_rectPlayer,
                -- 上方障碍物位置和尺寸
                {
                    x = obstacle.global_x,
                    y = obstacle.exit_y - rendered_list.Pipe.Down.rect.h,
                    w = rendered_list.Pipe.Down.rect.w,
                    h = rendered_list.Pipe.Down.rect.h
                }
            ) or Algorithm.CheckRectsOverlap(
                _global_rectPlayer,
                -- 下方障碍物位置和尺寸
                {
                    x = obstacle.global_x,
                    y = obstacle.exit_y + 150,
                    w = rendered_list.Pipe.Up.rect.w,
                    h = rendered_list.Pipe.Up.rect.h 
                }
            )
            -- 如果游戏尚未结束且玩家通过了没有加分的障碍物，则进行加分
            if (not bIsQuit) and (obstacle ~= obstacleScoreAdded)
                and (globalXPlayer <= obstacle.global_x + rendered_list.Pipe.Up.rect.w
                    and globalXPlayer + rectPlayer.w >= obstacle.global_x + rendered_list.Pipe.Up.rect.w)
            then
                obstacleScoreAdded = obstacle
                score = score + 1
            end
        end
    end

    -- 如果列表第一个障碍物已经退出至屏幕外，则将其移除并添加新的障碍物到列表尾部
    if obstacle_list[1].global_x + rendered_list.Pipe.Up.rect.w 
        <= globalXPlayer - rectPlayer.x 
    then
        table.remove(obstacle_list, 1)
        table.insert(obstacle_list, {
            -- 世界坐标系下的水平坐标值
            global_x = obstacle_list[#obstacle_list].global_x
                + 200 + math.random(-75, 75),
            -- 可通过缝隙距离屏幕顶端距离
            exit_y = math.random(190, 310)
        })
    end

    -- 更新背景图片切换定时器
    nTimerSwitchBackground = (nTimerSwitchBackground + 1) % (144 * 30)
    if nTimerSwitchBackground == 0 then
        if rdCurrentBackground == rendered_list.Background.Day then
            rdCurrentBackground = rendered_list.Background.Night
        else
            rdCurrentBackground = rendered_list.Background.Day
        end
    end

    -- 更新背景图片分界线坐标
    nBackgroundSplitPosX = nBackgroundSplitPosX - xSpeed
    if nBackgroundSplitPosX <= 0 then
        nBackgroundSplitPosX = rectWindow.w
    end

    -- 更新玩家渲染数据索引
    nIndexPlayerRD = (nIndexPlayerRD + 1) % 3 + 1

    -- 绘制逐渐后退的背景
    Graphic.CopyTexture(rdCurrentBackground.texture, {
        x = nBackgroundSplitPosX - rectWindow.w,
        y = 0,
        w = rdCurrentBackground.rect.w,
        h = rdCurrentBackground.rect.h
    })
    Graphic.CopyTexture(rdCurrentBackground.texture, {
        x = nBackgroundSplitPosX,
        y = 0,
        w = rdCurrentBackground.rect.w,
        h = rdCurrentBackground.rect.h
    })

    -- 绘制障碍物
    for _, obstacle in ipairs(obstacle_list) do
        -- 绘制上方障碍物
        Graphic.CopyTexture(
            rendered_list.Pipe.Down.texture,
            {
                x = obstacle.global_x - (globalXPlayer - rectPlayer.x),
                y = obstacle.exit_y - rendered_list.Pipe.Down.rect.h,
                w = rendered_list.Pipe.Down.rect.w,
                h = rendered_list.Pipe.Down.rect.h
            }
        )
        -- 绘制下方障碍物
        Graphic.CopyTexture(
            rendered_list.Pipe.Up.texture,
            {
                x = obstacle.global_x - (globalXPlayer - rectPlayer.x),
                y = obstacle.exit_y + 150,
                w = rendered_list.Pipe.Up.rect.w,
                h = rendered_list.Pipe.Up.rect.h 
            }
        )
    end

    -- 绘制玩家图像
    Graphic.CopyTexture(rendered_list.Bird[nIndexPlayerRD], rectPlayer)

    -- 绘制玩家得分
    local strScore = tostring(score)
    for i = 1, #strScore do
        Graphic.CopyTexture(
            rendered_list.Number[string.sub(strScore, i, i)],
            {
                x = rectWindow.w - 45 - 24 * (#strScore - i),
                y = 25, w = 24, h = 44
            }
        )
    end

    -- 更新游戏窗口，将缓冲区图像数据冲刷到屏幕上
    Window.UpdateWindow()

    -- 判断游戏是否结束以及玩家是否触碰到地面，如果游戏结束则退出游戏
    if bIsQuit or rectPlayer.y + rectPlayer.h >= rectWindow.h then
        Window.ShowMessageBox(Window.MSGBOX_INFO, "游戏结束", "玩家得分："..score)
        bIsQuit = true
    end

    -- 动态延时，确保游戏帧率稳定在 144fps
    Time.DynamicSleep(1000 / 144, Time.GetInitTime() - _nStartTime)

end
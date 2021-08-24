
Window = UsingModule("Window")
Interact = UsingModule("Interactivity")
Graphic = UsingModule("Graphic")

RECT_WINDOW = {
    x = Window.WINDOW_POSITION_DEFAULT, 
    y = Window.WINDOW_POSITION_DEFAULT, 
    w = 1280, 
    h = 720
}
Window.CreateWindow("2048", RECT_WINDOW, {})
Gridnumberl = 4
Gridnumberr = 4
Radius = 2      -- 圆角半径改小
Number = {}
for i = 1,Gridnumberl do
    for j = 1,Gridnumberr do
        local _grid = {
            x = i*100,
            y = j*100,
            w = 80,
            h = 80
        }  
        table.insert(Number,_grid)
        Graphic.SetDrawColor({r = 125, g = 0, b = 0, a = 255})  -- 绘图前设置绘图颜色
        Graphic.FillRoundRectangle(_grid,Radius)
    end
end
color_window = {r = 255, g = 0, b = 0, a = 255}
Window.UpdateWindow()   -- 绘图后刷新窗口

-- Window.SetWindowMode(Window.WINDOW_MODE_WINDOWED)
isQuit = false

-- 设置当前是否开始放置标志位
isPlacing = false





score=""
rect_image={}
function drawnew(rect_image)
    color_window = {r = 255, g = 0, b = 0, a = 255}
    font = Graphic.LoadFontFromFile("./Inkfree.ttf",75)
    image = Graphic.CreateUTF8TextImageBlended(font,score,{r = 0,g = 255,b = 255, a = 0})
    texture = Graphic.CreateTexture(image)
    image_width, image_height = image:GetSize()
    Graphic.CopyTexture(texture,rect_image)
    Window.UpdateWindow()
end
function Init()
    Grid={}
    for i=1, 4 do --set up a array
        Grid[i]={}
        for j=1,4 do
            Grid[i][j]=0
        end
    end
    num = math.random(2,4) 
    

end

GAME_SIZE = 4
--temp = {}
Grid = {}  -- 存储2048格子数据，二维
function getRandomZeroPos()
    local nSpace = 0
    for i = 1 , GAME_SIZE do
        Grid[i]={}
        for j = 1 , GAME_SIZE do
            if Grid[i][j] == 0 then
                nSpace = nSpace + 1
            end
        end
    end
    if nSpace == 0 then
        return false
    end
    nRand = math.random(1,nSpace)
    for i = 1 , GAME_SIZE do
        for j = 1 , GAME_SIZE do
            if Grid[i][j] == 0 then
                if nRand == 1 then
                    Grid[i][j] = 2 * (math.random(1,10) < 8 and 1 or 2)
                    sorce = tostring(Grid[i][j])
                    --tostring() 将数字转换为字符串类型
                    --tonumber()可以把非数字的原始值转换成数字
                    Window.UpdateWindow()
                    rect_image = {
                        x = i*100,
                        y = j*100,
                        w = 80,
                        h = 80
                    }
                    drawnew(rect_image)
                    return true
                else
                    nRand = nRand - 1
                end
            end
        end
    end
    return false
end

function Move(nX , nY , tbGrids)
    local nStep = (nX + nY) * -1
    local nBegin = 1
    local nEnd = GAME_SIZE
    if nStep < 0 then
        nBegin = GAME_SIZE
        nEnd = 1
    end
    for i = nBegin , nEnd , nStep do
        for j = nBegin , nEnd , nStep do
            local x1 = i
            local y1 = j
            repeat
                x1 = x1 + nX
                y1 = y1 + nY
            until tbGrids[x1][y1]~= 0
            rect_image = {
                x = x1*100,
                y = y1*100,
                w = 80,
                h = 80
            }
            drawnew(rect_image)
            if tbGrids[x1][y1] == tbGrids[i][j] then
                tbGrids[x1][y1] = tbGrids[x1][y1] * -2 -- 防止 2 2 4 8 这种情况发生一次性合并
                nScore = nScore + tbGrids[x1][y1] * -1
                tbGrids[i][j] = 0
            else
                if x1 - nX ~= i or y1 - nY ~= j then
                    tbGrids[x1 - nX][y1 - nY] = tbGrids[i][j]
                    tbGrids[i][j] = 0
                end
            end
        end
    end
    for i = 1 , GAME_SIZE do
        for j = 1 , GAME_SIZE do
            if tbGrids[i][j] < 0 then
                tbGrids[i][j] = tbGrids[i][j] * -1
            end
        end
    end
end

-- 游戏主循环
while not isQuit do
    --Window.CreateWindow("2048", RECT_WINDOW, {})
    --Window.ClearWindow()
    Init()
    getRandomZeroPos(Grid)
    Graphic.SetDrawColor({r = 125, g = 1, b = 0, a = 255})  -- 绘图前设置绘图颜色
        Gridnumberl = 4
        Gridnumberr = 4
        Radius = 2      -- 圆角半径改小
        Number = {}
        for i = 1,Gridnumberl do
            for j = 1,Gridnumberr do
                local _grid = {
                    x = i*100,
                    y = j*100,
                    w = 80,
                    h = 80
                }  
                table.insert(Number,_grid)              
                Graphic.FillRoundRectangle(_grid,Radius)
            end
        end
    while Interact.UpdateEvent() do
    -- 获取当前事件类型
        local _event = Interact.GetEventType()
        -- 如果是退出事件，就将退出标志位置为 true
        if _event == Interact.EVENT_QUIT then
            isQuit = true
        -- 如果是 P 键按下，则将放置标志位设置为 true
        elseif _event == Interact.EVENT_KEYDOWN_P then
            isPlacing = true
        -- 如果其他方向键按下，则移动后并将标志位设置为 false
        elseif _event == Interact.EVENT_KEYDOWN_W then
            Move(-1,0,Grid)
            isPlacing = false
        elseif _event == Interact.EVENT_KEYDOWN_A then
            Move(0,-1,Grid)
            isPlacing = false
        elseif _event == Interact.EVENT_KEYDOWN_S then
            Move(1,0,Grid)
            isPlacing = false
        elseif _event == Interact.EVENT_KEYDOWN_D then
            Move(0,1,Grid)
            isPlacing = false
        end
    end
end

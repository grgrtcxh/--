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

GAME_SIZE = 4 -- 4*4 Grids
nScore = 0    -- 玩家分数
grid_list = {}
Row = 0
Line = 0
Row1 = 1
Line1 = 1
--随机数的创建
function  Init()
    for i =1,4 do--二维创建
        grid_list[i] = {}
    end
    for i = 1, 4 do--初始为0
        for j = 1, 4 do
            grid_list[i][j] =0
        end
    end
    Row = math.random(1,4)
    Line = math.random(1,4)
    grid_list[Row][Line] = 2
end
score ={}
line = {}
function moveUp()
    for i=1, 4 do
        for j=1,4 do
            if grid_list[j][i]~=0 then
                for k=j+1, 4 do
                    if grid_list[k][i]~=0 then
                        if(grid_list[j][i]==grid_list[k][i]) then
                            sorce = grid_list[i][j]*2
                            --line[1] = grid[j][i]
                            table.insert(score,line[i])
                            --grid[j][i] = 4 score*2
                            grid_list[k][i] = 0
                            k = 0
                            j = 0
                        end
                    end
                    --else break
                end
            end
        end
        t = 0
        temp = {}
        for j=1,4 do
            if 0~=grid_list[j][i] then
                t = t+1
                temp[t]=grid_list[j][i]
            end
        end
        if t~=4 then
            while t<4 do
                t=t+1
                temp[t]=0
            end
            for j=1,4 do
                grid_list[j][i] = temp[j]
        for i=1,4 do
            for j =1 ,4 do
                if grid_list[j][i]~=0 then
                    Row1 = j
                    Line1 = i
                end
            end
        end
               --text = temp[j]
                --print(grid[j][i])
            end

        end
    end
end

Init()
rect_image = {
    x = Row *100,
    y = Line*100,
    w = 80,
    h =80
}
color_window = {r = 255, g = 0, b = 0, a = 255}
font = Graphic.LoadFontFromFile("./Inkfree.ttf",75)
image = Graphic.CreateUTF8TextImageBlended(font,"2",{r = 0,g = 255,b = 255, a = 0})
texture = Graphic.CreateTexture(image)
image_width, image_height = image:GetSize()
Graphic.CopyTexture(texture,rect_image)
Window.UpdateWindow()
while not isQuit do
    Graphic.SetDrawColor({r = 125, g = 1, b = 0, a = 255})  -- 绘图前设置绘图颜色
        Gridnumberl = 4
        Gridnumberr = 4
        Radius = 2      
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
    Init()
    Window.UpdateWindow()
    rect_image = {
        x = Row*100,
        y = Line*100,
        w = 80,
        h = 80
    }
    color_window = {r = 255, g = 0, b = 0, a = 255}
    font = Graphic.LoadFontFromFile("./Inkfree.ttf",75)
    image = Graphic.CreateUTF8TextImageBlended(font,"2",{r = 0,g = 255,b = 255, a = 0})
    texture = Graphic.CreateTexture(image)
    image_width, image_height = image:GetSize()
    Graphic.CopyTexture(texture,rect_image)
    Window.UpdateWindow()
    while Interact.UpdateEvent() do
    -- 获取当前事件类型
    rect_image = {
        x = Row1*100,
        y = Line1*100,
        w = 80,
        h = 80
    }
    color_window = {r = 255, g = 0, b = 0, a = 255}
    font = Graphic.LoadFontFromFile("./Inkfree.ttf",75)
    image = Graphic.CreateUTF8TextImageBlended(font,sorce,{r = 0,g = 255,b = 255, a = 0})
    texture = Graphic.CreateTexture(image)
    image_width, image_height = image:GetSize()
    Graphic.CopyTexture(texture,rect_image)
    Window.UpdateWindow()
        local _event = Interact.GetEventType()
        -- 如果是退出事件，就将退出标志位置为 true
        if _event == Interact.EVENT_QUIT then
            isQuit = true
        -- 如果是 P 键按下，则将放置标志位设置为 true
        elseif _event == Interact.EVENT_KEYDOWN_P then
            isPlacing = true
        -- 如果其他方向键按下，则移动后并将标志位设置为 false
        elseif _event == Interact.EVENT_KEYDOWN_W then
            moveUp()
            isPlacing = false
        elseif _event == Interact.EVENT_KEYDOWN_A then
            --Move(0,-1,Grid)
            isPlacing = false
        elseif _event == Interact.EVENT_KEYDOWN_S then
            --Move(1,0,Grid)
            isPlacing = false
        elseif _event == Interact.EVENT_KEYDOWN_D then
            --Move(0,1,Grid)
            isPlacing = false
        end
    end
end

--[[rect_image = {x = Row * 100, y = Line * 100, w = 80, h = 80}
color_window = {r = 255, g = 0, b = 0, a = 255}
font = Graphic.LoadFontFromFile("./Inkfree.ttf", 75)
image = Graphic.CreateUTF8TextImageBlended(font, grid_list[Row][Line].value,{r = 0, g = 255, b = 255, a = 0})
texture = Graphic.CreateTexture(image)
image_width, image_height = image:GetSize()
Graphic.CopyTexture(texture, rect_image)
Window.UpdateWindow()]] -- 清空窗口内容
--[[for i = 1, 4 do
    local _t = {}
    for j = 1, 4 do
        table.insert(_t, {
            rect = {x = i * 100, y = j * 100, w = 80, h = 80},
            value = 0
        })
    end
    table.insert(grid_list, _t)
end]]
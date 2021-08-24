Window = UsingModule("Window")
Interactivity = UsingModule("Interactivity")
Graphic = UsingModule("Graphic")
Time = UsingModule("Time")

-- 创建游戏窗口
Window.CreateWindow("plane war", {
    x = Window.WINDOW_POSITION_DEFAULT,
    y = Window.WINDOW_POSITION_DEFAULT,
    w = 550,
    h = 700
}, {})
Window.UpdateWindow()
Window.SetWindowMode(Window.WINDOW_MODE_WINDOWED)
Window.UpdateWindow()
Image_backgroud = Graphic.LoadImageFromFile(".//图片//images//background.png")
Image_me1 = Graphic.LoadImageFromFile(".//图片//images//me1.png")
Image_enemy1 = Graphic.LoadImageFromFile(".//图片//images//enemy1.png")
Image_enemy2 = Graphic.LoadImageFromFile(".//图片//images//enemy2.png")
Image_enemy3 = Graphic.LoadImageFromFile(".//图片//images//enemy3_n1.png")
Image_enemy4 = Graphic.LoadImageFromFile(".//图片//images//enemy3_n2.png")
Image_bullet = Graphic.LoadImageFromFile(".//图片//images//bullet2.png")
Image_enemy1down1 = Graphic.LoadImageFromFile(
                        ".//图片//images//enemy1_down1.png")
Image_enemy1down2 = Graphic.LoadImageFromFile(
                        ".//图片//images//enemy1_down2.png")
Image_enemy1down3 = Graphic.LoadImageFromFile(
                        ".//图片//images//enemy1_down3.png")
Image_enemy2down1 = Graphic.LoadImageFromFile(
                        ".//图片//images//enemy2_down1.png")
Image_enemy2down2 = Graphic.LoadImageFromFile(
                        ".//图片//images//enemy2_down2.png")
Image_enemy2down3 = Graphic.LoadImageFromFile(
                        ".//图片//images//enemy2_down3.png")
Image_enemy3down1 = Graphic.LoadImageFromFile(
                        ".//图片//images//enemy3_down1.png")
Image_enemy3down2 = Graphic.LoadImageFromFile(
                        ".//图片//images//enemy3_down2.png")
Image_enemy3down3 = Graphic.LoadImageFromFile(
                        ".//图片//images//enemy3_down3.png")
function GetImageRect(image)
    local _width, _height = image:GetSize()
    return {w = _width, h = _height}
end
num = 5
scoerenemy1 = 10
scoerenemy2 = 10
scoerenemy3 = 10
enemyrect = {x = 100, y = 40}
speed = 15
speed1 = 1
speed2 = 4
speed3 = 2
count = 1
rect = {x = 250, y = 550}
enemyrectx1 = math.random(0,50)
enemyrectx2 = math.random(50,150)
enemyrectx3 = math.random(150,250)
enemyrectx4 = math.random(250,450)
enemyrectx5 = math.random(450,550)
enemyrecty1 = 10
enemy2 = 35 + math.random(1, 100)
enemy2y = 40 + math.random(1, 50)
backgroundrect = 0
backgroundrect1 = -2
bulletspeedl =  rect.y
bulletspeedr =  rect.y
bullet_list = {}
enemy3 =  math.random(0, 400)
enemy3y =  math.random(0, 10)
function Move(direction)
    if direction == "up" then -- 如果向上移动
        rect.y = rect.y - speed
    elseif direction == "down" then -- 如果向下移动
        rect.y = rect.y + speed
    elseif direction == "right" then -- 如果向右移动
        rect.x = rect.x + speed
    elseif direction == "left" then -- 如果向左移动
        rect.x = rect.x - speed
    end
end
function Drawbullett()
    local _nStartTime = Time.GetInitTime()
    local _width, _height = Image_bullet:GetSize()
    local _texture = Graphic.CreateTexture(Image_bullet)
        Graphic.CopyTexture(_texture, {
            x = rect.x + 15,
            y = bulletspeedl,
            w = _width * 1.5,
            h = _height *1.5
        })
        Graphic.CopyTexture(_texture, {
            x = rect.x + 80,
            y = bulletspeedr ,
            w = _width * 1.5,
            h = _height * 1.5
        })
end
function movebullet()
    bulletspeedl = bulletspeedl - 10
    if bulletspeedl <= 0 then
        bulletspeedl = rect.y -10
    end
    bulletspeedr = bulletspeedl - 10
    if bulletspeedr <= 0 then
        bulletspeedr = rect.y - 10
    end
end
function Drawenemy1()
    local _nStartTime = Time.GetInitTime()
    local _width, _height = Image_enemy1:GetSize()
    local _texture = Graphic.CreateTexture(Image_enemy1)
    if count == 1 then
        Graphic.CopyTexture(_texture, {
            x = enemyrectx1,
            y = enemyrecty1,
            w = _width,
            h = _height
        })
    end
    Graphic.CopyTexture(_texture, {
        x = enemyrectx2,
        y = enemyrecty1,
        w = _width,
        h = _height
    })
    Graphic.CopyTexture(_texture, {
        x = enemyrectx3,
        y = enemyrecty1,
        w = _width,
        h = _height
    })
    Graphic.CopyTexture(_texture, {
        x = enemyrectx4,
        y = enemyrecty1,
        w = _width,
        h = _height
    })
    Graphic.CopyTexture(_texture, {
        x = enemyrectx5,
        y = enemyrecty1,
        w = _width,
        h = _height
    })
end
function movespeed(enemyrectx1)
    enemyrectx1 = enemyrectx1 + speed1
    if enemyrectx1 > 520 or enemyrectx1 < 0 then
        speed1 = speed1 * -1
        enemyrecty1 = enemyrecty1 + 2
    end
    if enemyrecty1 > 660 then
        enemyrecty1 = 10
    end
    return enemyrectx1
end
function movespeed1()
    enemyrecty1 = enemyrecty1 + 2
    if enemyrecty1 > 660 then
        enemyrecty1 = 10
    end
end
function movespeedbackground()
    if backgroundrect < 750 then
        backgroundrect = backgroundrect + 2
    else
        backgroundrect = 0
    end
end
function movespeedbackground1()
    if backgroundrect1 < 748 then
        backgroundrect1 = backgroundrect1 + 2
    else
        backgroundrect1 = -2
    end
end
function Drawenemy2()
    local _nStartTime = Time.GetInitTime()
    local _width, _height = Image_enemy2:GetSize()
    local _texture = Graphic.CreateTexture(Image_enemy2)
    Graphic.CopyTexture(_texture, {
        x = enemy2,
        y = enemy2y,
        w = _width,
        h = _height
    })
    enemy2 = enemy2 + speed2
    if enemy2 > 520  or enemy2 < 0 then
        speed2 = speed2 * - 1
        enemy2y = enemy2y + 20
    end
    if enemy2y > 660 then
        enemy2y = 10
    end
end
function Drawenemy3()
    local _nStartTime = Time.GetInitTime()
    local _width, _height = Image_enemy3:GetSize()
    local _texture = Graphic.CreateTexture(Image_enemy3)
    Graphic.CopyTexture(_texture, {
        x = enemy3,
        y = enemy3y,
        w = _width,
        h = _height
    })
    enemy3 = enemy3 + speed3
    enemy3y = enemy3y + speed3
    if enemy3 < 0 or enemy3> 550 then
        speed3 = speed3 * -1
    end
    if enemy3y > 300 then
        speed3  = speed3 *-1
    end
end
function boomenemy1()
    if bulletspeedl >= enemyrecty1 - 10 and rect.x + 15  - enemyrectx1  < 10  then
        -- xiaohui
        count = 0
        local _image = Image_enemy1down1
        local _nStartTime = Time.GetInitTime()
        local _width, _height = _image:GetSize()
        local _texture = Graphic.CreateTexture(Image_enemy1down1)
        local _texture = Graphic.CreateTexture(Image_enemy1down2)
        local _texture = Graphic.CreateTexture(Image_enemy1down3)
        if count == 0 then
            Graphic.CopyTexture(_texture, {
                x = enemyrectx1,
                y = enemyrecty1,
                w = _width,
                h = _height
            })
        end
        count = 1
    end
end
function boomenemy2()
    if rect.y + 5 - random5 < enemyrect.y + random2 + 20 then
        -- xiaohui
        local _image = Image_enemy2down1
        local _nStartTime = Time.GetInitTime()
        local _width, _height = _image:GetSize()
        local _texture = Graphic.CreateTexture(_image)
        Graphic.CopyTexture(_texture, {
            x = enemyrect.x + random1 + 50,
            y = enemyrect.y + random2 + 20,
            w = _width,
            h = _height
        })
        local _image = Image_enemy2down2
        local _nStartTime = Time.GetInitTime()
        local _width, _height = _image:GetSize()
        local _texture = Graphic.CreateTexture(_image)
        Graphic.CopyTexture(_texture, {
            x = enemyrect.x + random1 + 50,
            y = enemyrect.y + random2 + 20,
            w = _width,
            h = _height
        })
        local _image = Image_enemy2down3
        local _nStartTime = Time.GetInitTime()
        local _width, _height = _image:GetSize()
        local _texture = Graphic.CreateTexture(_image)
        Graphic.CopyTexture(_texture, {
            x = enemyrect.x + random1 + 50,
            y = enemyrect.y + random2 + 20,
            w = _width,
            h = _height
        })
    end
end
function boomenemy3()
    if rect.y + 5 - random5 < enemyrect.y + random2 + 1 then
        -- xiaohui
        local _image = Image_enemy3down1
        local _nStartTime = Time.GetInitTime()
        local _width, _height = _image:GetSize()
        local _texture = Graphic.CreateTexture(_image)
        Graphic.CopyTexture(_texture, {
            x = enemyrect.x + random1 + 150,
            y = enemyrect.y + math.random(0, 1),
            w = _width,
            h = _height
        })
        local _image = Image_enemy3down2
        local _nStartTime = Time.GetInitTime()
        local _width, _height = _image:GetSize()
        local _texture = Graphic.CreateTexture(_image)
        Graphic.CopyTexture(_texture, {
            x = enemyrect.x + random1 + 150,
            y = enemyrect.y + math.random(0, 1),
            w = _width,
            h = _height
        })
        local _image = Image_enemy3down3
        local _nStartTime = Time.GetInitTime()
        local _width, _height = _image:GetSize()
        local _texture = Graphic.CreateTexture(_image)
        Graphic.CopyTexture(_texture, {
            x = enemyrect.x + random1 + 150,
            y = enemyrect.y + math.random(0, 1),
            w = _width,
            h = _height
        })
    end
end
function drawbackground()
    local _image = Image_backgroud
    local _texture = Graphic.CreateTexture(_image)
    Graphic.CopyTexture(_texture, {x = 0, y = backgroundrect, w = 550, h = 750})
end
function drawme()
    local _nStartTime = Time.GetInitTime()
    local _width, _height = Image_me1:GetSize()
    local _texture = Graphic.CreateTexture(Image_me1)
    Graphic.CopyTexture(_texture,
                        {x = rect.x, y = rect.y, w = _width, h = _height})
end
bIsQuit = false
while not bIsQuit do
    local number = 0
    for i = 1, 15 do
        bullet_list[i]= rect.y - 30 * i + 20
        print(bullet_list)
    end
    drawbackground()
    drawme()
    Drawenemy1()
    movespeed(enemyrectx1)
    movespeed1(enemyrecty1)
    Drawenemy2()
    Drawenemy3()
    Drawbullett()
    movebullet()
    boomenemy1()
    -- boomenemy2()
    -- boomenemy3()
    Window.UpdateWindow()
    while Interactivity.UpdateEvent() do
        local _nStartTime = Time.GetInitTime()
        -- 获取当前事件类型
        local _event = Interactivity.GetEventType()
        -- 如果是退出事件，就将退出标志位置为 true
        if _event == Interactivity.EVENT_QUIT then
            bIsQuit = true
            -- 如果为 ↑ 键抬起（本质为按键事件，为优化操作手感选择判定抬起事件，下同）
        elseif _event == Interactivity.EVENT_KEYUP_UP then
            Move("up")
        elseif _event == Interactivity.EVENT_KEYUP_DOWN then
            Move("down")
        elseif _event == Interactivity.EVENT_KEYUP_LEFT then
            Move("left")
        elseif _event == Interactivity.EVENT_KEYUP_RIGHT then
            Move("right")
        end
        -- 绘制窗口
        -- Graphic.LoadImageFromFile(".//图片//images//enemy1.png")

        Window.UpdateWindow()
    end
    -- Time.DynamicSleep(1000 / 20, Time.GetInitTime() - _nStartTime)
    Window.ClearWindow()
    --[[_nStartTime = 0
    local _nEndTime = Time.GetInitTime()
    if _nEndTime - _nStartTime < 144 then
        Time.Sleep(144 - (_nEndTime - _nStartTime))
    end]]
    Window.ClearWindow()
end


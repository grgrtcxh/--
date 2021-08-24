-- plane1
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
-- 字体信息
font_num = Graphic.LoadFontFromFile("./Inkfree.ttf", 125)
font_score = Graphic.LoadFontFromFile("./Inkfree.ttf", 30)
font_score:SetStyle({Graphic.FONT_STYLE_ITALIC, Graphic.FONT_STYLE_UNDERLINE})
-- 导入图片信息
Image_background =
    Graphic.LoadImageFromFile(".//图片//images//background.png")
Image_me1 = Graphic.LoadImageFromFile(".//图片//images//me1.png")
Image_enemy1 = Graphic.LoadImageFromFile(".//图片//images//enemy1.png")
Image_enemy2 = Graphic.LoadImageFromFile(".//图片//images//enemy2.png")
Image_enemy3 = Graphic.LoadImageFromFile(".//图片//images//enemy3_n1.png")
Image_enemy4 = Graphic.LoadImageFromFile(".//图片//images//enemy3_n2.png")
Image_bullet = Graphic.LoadImageFromFile(".//图片//images//bullet2.png")
Image_bullet1 = Graphic.LoadImageFromFile(".//图片//images//bullet1.png")
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
-- 数值
speed = 15
speed1 = 5
bulletnumber = 15
enemy1number = 10
enemy2number = 5
enemy3number = 2
blood = 10 -- 血量
boom = 0 -- 爆炸标志
count = 0 -- 得分
rect = {judge = true, x = 300, y = 550}
boomrect = {x = 0, y = 0, judge = false}
bullet_list = {
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}
}
enemy1_list = {
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false}
}
BoomEnemy1_list = {
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false}
}
enemy2_list = {
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false}
}
BoomEnemy2_list = {
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false}
}
enemy3_list = {x = 0, y = 0, judge = false}
BoomEnemy3_list = {x = 0, y = 0, judge = false}
enenmy_bullet = {
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false},
    {x = 0, y = 0, judge = false}, {x = 0, y = 0, judge = false}
}
_bnStartTime = Time.GetInitTime() -- 开机到现在的毫秒数
_bnEndTime = Time.GetInitTime()
_nStartTime = Time.GetInitTime()
_nEndTime = Time.GetInitTime()
_nStartTime1 = Time.GetInitTime()
_nEndTime1 = Time.GetInitTime()
_nStartTime2 = Time.GetInitTime()
_nEndTime2 = Time.GetInitTime()
-- 子弹的构建
function FireBullet()
    for i = 1, 15 do
        if bullet_list[i].judge == false then
            bullet_list[i].judge = true
            bullet_list[i].x = rect.x + 15
            bullet_list[i].y = rect.y - 10
            break
        end
    end
    for j = 1, 6 do
        if enenmy_bullet[j].judge == false then
            enenmy_bullet[j].judge = true
            enenmy_bullet[j].x = enemy3_list.x + 80
            enenmy_bullet[j].y = enemy3_list.y + 150
            break
        end
    end
end
-- 子弹的移动
function MoveBullet()
    for i = 1, 15 do
        if bullet_list[i].judge == true then
            bullet_list[i].y = bullet_list[i].y - 2
            if bullet_list[i].y < 0 then bullet_list[i].judge = false end
        end
    end
    for j = 1, 6 do
        if enenmy_bullet[j].judge == true then
            enenmy_bullet[j].y = enenmy_bullet[j].y + 3
            if enenmy_bullet[j].y >700 then
                enenmy_bullet[j].judge = false
            end
        end
    end
end
-- 敌机的构建
function SetEnemy()
    for i = 1, 10 do
        if enemy1_list[i].judge == false and _nEndTime - _nStartTime >= 80 then -- and _nEndTime - _nStartTime == 40
            enemy1_list[i].judge = true
            enemy1_list[i].x = math.random(0, 530)
            enemy1_list[i].y = math.random(0, 20)
            _nStartTime = _nEndTime
            break
        end
        _nEndTime = Time.GetInitTime()
    end
    for j = 1, 6 do
        if enemy2_list[j].judge == false and _nEndTime1 - _nStartTime1 >= 300 then -- and _nEndTime - _nStartTime == 40
            enemy2_list[j].judge = true
            enemy2_list[j].x = math.random(0, 530)
            enemy2_list[j].y = math.random(0, 300)
            _nStartTime1 = _nEndTime1
            break
        end
        _nEndTime1 = Time.GetInitTime()
    end
    if enemy3_list.judge == false and _nEndTime2 - _nStartTime2 >= 1000 then -- and _nEndTime - _nStartTime == 40
        enemy3_list.judge = true
        enemy3_list.x = math.random(0, 530)
        enemy3_list.y = math.random(0, 400)
        _nStartTime2 = _nEndTime2
    end
    _nEndTime2 = Time.GetInitTime()
end
-- 敌机的移动
function MoveEnemy()
    for i = 1, 10 do
        if enemy1_list[i].judge == true then
            enemy1_list[i].y = enemy1_list[i].y + 1
            if enemy1_list[i].y > 700 then
                enemy1_list[i].judge = false
            end
        end
    end
    for j = 1, 5 do
        if enemy1_list[j].judge == true then
            enemy1_list[j].x = enemy1_list[j].x + 1
            if enemy1_list[j].x > 550 then
                enemy1_list[j].judge = false
            end
        end
    end
    for j = 6, 10 do
        if enemy1_list[j].judge == true then
            enemy1_list[j].x = enemy1_list[j].x - 1
            if enemy1_list[j].x < 0 then enemy1_list[j].judge = false end
        end
    end
    for k = 1, 6 do
        if enemy2_list[k].judge == true then
            enemy2_list[k].x = enemy1_list[k].x + 1
            if enemy1_list[k].x > 700 then
                enemy1_list[k].judge = false
            end
        end
    end
    for k = 3, 6 do
        if enemy1_list[k].judge == true then
            enemy1_list[k].x = enemy1_list[k].x - 2
        end
        if enemy1_list[k].x < 0 then enemy1_list[k].judge = false end
    end
    if enemy3_list.judge == true then
        enemy3_list.y = enemy3_list.y - 0.3
        if enemy3_list.y < -300 then enemy3_list.judge = false end
    end
end
-- 销毁
function Boom()
    for i = 1, 10 do
        if math.random(0, 3) == 2 then BoomEnemy1_list[i].judge = false end
    end
    for j = 1, 6 do
        if math.random(0, 3) == 2 then BoomEnemy2_list[j].judge = false end
    end
    if math.random(0, 3) == 2 then BoomEnemy3_list.judge = false end
end
function Hit()
    for i = 1, 10 do
        if enemy1_list[i].judge == false then
            enemy1_list[i].judge = false
        end
        for j = 1, 15 do
            if bullet_list[j].judge == false then
                bullet_list[j].judge = false
            end
            if bullet_list[j].x < enemy1_list[i].x + 60 and bullet_list[j].x >
                enemy1_list[i].x and bullet_list[j].y < enemy1_list[i].y + 30 and
                bullet_list[j].y > enemy1_list[i].y then
                BoomEnemy1_list[i].judge = true
                BoomEnemy1_list[i].x = enemy1_list[i].x
                BoomEnemy1_list[i].y = enemy1_list[i].y
                bullet_list[j].judge = false
                enemy1_list[i].judge = false
                count = count + 1
            end
            if bullet_list[j].x + 65 < enemy1_list[i].x + 60 and
                bullet_list[j].x + 65 > enemy1_list[i].x and bullet_list[j].y <
                enemy1_list[i].y + 30 and bullet_list[j].y > enemy1_list[i].y then
                BoomEnemy1_list[i].judge = true
                BoomEnemy1_list[i].x = enemy1_list[i].x
                BoomEnemy1_list[i].y = enemy1_list[i].y
                bullet_list[j].judge = false
                enemy1_list[i].judge = false
                count = count + 1
            end
        end
    end
    for k = 1, 6 do
        if enemy2_list[k].judge == false then
            enemy2_list[k].judge = false
        end
        for h = 1, 15 do
            if bullet_list[h].judge == false then
                bullet_list[h].judge = false
            end
            if bullet_list[h].x < enemy2_list[k].x + 100 and bullet_list[h].x >
                enemy2_list[k].x and bullet_list[h].y < enemy2_list[k].y + 30 and
                bullet_list[h].y > enemy2_list[k].y then
                BoomEnemy2_list[k].judge = true
                BoomEnemy2_list[k].x = enemy2_list[k].x
                BoomEnemy2_list[k].y = enemy2_list[k].y
                bullet_list[h].judge = false
                enemy2_list[k].judge = false
                count = count + 2
            end
            if bullet_list[h].x + 65 < enemy2_list[k].x + 100 and
                bullet_list[h].x + 65 > enemy2_list[k].x and bullet_list[h].y <
                enemy2_list[k].y + 30 and bullet_list[h].y > enemy2_list[k].y then
                BoomEnemy2_list[k].judge = true
                BoomEnemy2_list[k].x = enemy2_list[k].x
                BoomEnemy2_list[k].y = enemy2_list[k].y
                bullet_list[h].judge = false
                enemy2_list[k].judge = false
                count = count + 2
            end
        end
    end
end
if enemy3_list.judge == false then enemy3_list.judge = false end
for m = 1, 15 do
    if bullet_list[m].judge == false then bullet_list[m].judge = false end
    if bullet_list[m].x < enemy3_list.x + 60 and bullet_list[m].x >
        enemy3_list.x and bullet_list[m].y < enemy3_list.y + 30 and
        bullet_list[m].y > enemy3_list.y then
        BoomEnemy3_list.judge = true
        BoomEnemy3_list.x = enemy3_list.x
        BoomEnemy3_list.y = enemy3_list.y
        bullet_list[m].judge = false
        enemy3_list.judge = false
        count = count + 10
    end
    if bullet_list[m].x + 65 < enemy3_list.x + 60 and bullet_list[m].x + 65 >
        enemy3_list.x and bullet_list[m].y < enemy3_list.y + 30 and
        bullet_list[m].y > enemy3_list.y then
        BoomEnemy3_list.judge = true
        BoomEnemy3_list.x = enemy3_list.x
        BoomEnemy3_list.y = enemy3_list.y
        bullet_list[m].judge = false
        enemy3_list.judge = false
        count = count + 10
    end
end
for n = 1, 6 do
    if enenmy_bullet[n].judge == false then enenmy_bullet[n].judge = false end
    if enenmy_bullet[n].x < rect.x + 60 and enenmy_bullet[n].x > rect.x and
        enenmy_bullet[n].y < rect.y + 30 and enenmy_bullet[n].y > rect.y then
        boomrect.judge = true
    end
end
function BoomTime()
    for i = 1, 10 do
        if math.random(0, 2) == 2 then BoomEnemy1_list[i].judge = false end
    end
    for j = 1, 6 do
        if math.random(0, 10) == 2 then BoomEnemy2_list[j].judge = false end
    end
    if math.random(0, 10) == 2 then BoomEnemy3_list.judge = false end
end
-- 战机移动
function Move(direction)
    if direction == "up" then -- 如果向上移动
        rect.y = rect.y - speed
    elseif direction == "down" then -- 如果向下移动
        rect.y = rect.y + speed
    elseif direction == "right" then -- 如果向右移动
        rect.x = rect.x + speed
    elseif direction == "left" then -- 如果向左移动
        rect.x = rect.x - speed
    elseif direction == "space" or _bnEndTime - _bnStartTime > 100 then
        FireBullet()
        _bnStartTime = _bnEndTime
    end
    _bnEndTime = Time.GetInitTime()
end
-- 画面呈现
function Show()
    -- 背景
    local _texture = Graphic.CreateTexture(Image_background)
    Graphic.CopyTexture(_texture, {x = 0, y = 0, w = 550, h = 750})
    -- 敌机
    -- local _nStartTime = Time.GetInitTime()
    local _width, _height = Image_enemy1:GetSize()
    local _texture4 = Graphic.CreateTexture(Image_enemy1)
    for i = 1, 10 do
        if enemy1_list[i].judge == true then
            Graphic.CopyTexture(_texture4, {
                x = enemy1_list[i].x,
                y = enemy1_list[i].y,
                w = _width,
                h = _height
            })
        end
    end
    local _widthen2, _heighten2 = Image_enemy2:GetSize()
    local _textureen2 = Graphic.CreateTexture(Image_enemy2)
    for h = 1, 6 do
        if enemy2_list[h].judge == true then
            Graphic.CopyTexture(_textureen2, {
                x = enemy2_list[h].x,
                y = enemy2_list[h].y,
                w = _widthen2,
                h = _heighten2
            })
        end
    end
    local _widthen3, _heighten3 = Image_enemy3:GetSize()
    local _textureen3 = Graphic.CreateTexture(Image_enemy3)
    if enemy3_list.judge == true then
        Graphic.CopyTexture(_textureen3, {
            x = enemy3_list.x,
            y = enemy3_list.y,
            w = _widthen3,
            h = _heighten3
        })
    end
    -- 敌机爆炸
    local _width2, _height2 = Image_enemy1down1:GetSize()
    local _texture1 = Graphic.CreateTexture(Image_enemy1down1)
    for k = 1, 10 do
        if BoomEnemy1_list[k].judge == true then
            Graphic.CopyTexture(_texture1, {
                x = BoomEnemy1_list[k].x,
                y = BoomEnemy1_list[k].y,
                w = _width2,
                h = _height2
            })
        end
    end
    local _widthbo2, _heightbo2 = Image_enemy2down1:GetSize()
    local _texturebo2 = Graphic.CreateTexture(Image_enemy2down1)
    for m = 1, 6 do
        if BoomEnemy2_list[m].judge == true then
            Graphic.CopyTexture(_texturebo2, {
                x = BoomEnemy2_list[m].x,
                y = BoomEnemy2_list[m].y,
                w = _width2,
                h = _height2
            })
        end
    end
    local _widthbo3, _heightbo3 = Image_enemy3down1:GetSize()
    local _texturebo3 = Graphic.CreateTexture(Image_enemy3down1)
    if BoomEnemy3_list.judge == true then
        Graphic.CopyTexture(_texturebo3, {
            x = enemy3_list.x,
            y = enemy3_list.y,
            w = _widthbo3,
            h = _heightbo3
        })
    end
    -- 子弹
    local _width1, _height1 = Image_bullet:GetSize()
    local _texture2 = Graphic.CreateTexture(Image_bullet)
    for j = 1, 15 do
        if bullet_list[j].judge == true then
            Graphic.CopyTexture(_texture2, {
                x = bullet_list[j].x,
                y = bullet_list[j].y,
                w = _width1 * 1.5,
                h = _height1 * 1.5
            })
            Graphic.CopyTexture(_texture2, {
                x = bullet_list[j].x + 65,
                y = bullet_list[j].y,
                w = _width1 * 1.5,
                h = _height1 * 1.5
            })
        end
    end
    local _width11, _height11 = Image_bullet1:GetSize()
    local _texture21 = Graphic.CreateTexture(Image_bullet1)
    for m = 1, 6 do
        if enenmy_bullet[m].judge == true then
            Graphic.CopyTexture(_texture21, {
                x = enenmy_bullet[m].x,
                y = enenmy_bullet[m].y,
                w = _width1 * 2,
                h = _height1 * 2
            })
        end
    end
    -- 战机
    local _width3, _height3 = Image_me1:GetSize()
    local _texture3 = Graphic.CreateTexture(Image_me1)
    Graphic.CopyTexture(_texture3,
                        {x = rect.x, y = rect.y, w = _width3, h = _height3})
    -- 玩家得分
    local _image = Graphic.CreateUTF8TextImageBlended(font_score,
                                                    "score"..count,
                                                      {
        r = 215,
        g = 115,
        b = 115,
        a = 255
    })
    local _widthfen, _heightfen = _image:GetSize()
    local _texturefen = Graphic.CreateTexture(_image)
    Graphic.CopyTexture(_texturefen,
                        {x = 0, y = 0, w = _widthfen, h = _heightfen})
end
bIsQuit = false
while not bIsQuit do
    Show()
    if boomrect == true then break end
    Move()
    MoveBullet()
    SetEnemy()
    MoveEnemy()
    Hit()
    BoomTime()
    Window.UpdateWindow()
    while Interactivity.UpdateEvent() do
        math.randomseed(os.time())
        -- local _nStartTime = Time.GetInitTime()
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
        elseif _event == Interactivity.EVENT_KEYDOWN_SPACE then
            Move("space")
        end
        Window.UpdateWindow()
    end
        --boomrect.judge = CheckGameOver()
    -- 如果 _status 存在（即 CheckGameOver 函数返回值不为空）则进入判断
    if boomrect.judge ==true then
            Window.ShowMessageBox(Window.MSGBOX_INFO, "游戏结束", "失败！")
    end
    Window.ClearWindow()
end


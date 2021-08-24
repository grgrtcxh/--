Graphic = UsingModule("Graphic")
Interactivity = UsingModule("Interactivity")
Window = UsingModule("Window")
Time = UsingModule("Time")

-- 加载字体文件
font = Graphic.LoadFontFromFile("./Inkfree.ttf", 125)

-- 不同数值网格底色对应颜色表
color_list = {}

-- 初始化颜色列表
color_list[0] = {r = 205, g = 193, b = 179, a = 255}
color_list[2] = {r = 238, g = 228, b = 218, a = 255}
color_list[4] = {r = 235, g = 220, b = 189, a = 255}
color_list[8] = {r = 243, g = 176, b = 121, a = 255}
color_list[16] = {r = 247, g = 146, b = 92, a = 255}
color_list[32] = {r = 245, g = 118, b = 86, a = 255}
color_list[64] = {r = 244, g = 82, b = 44, a = 255}
color_list[128] = {r = 237, g = 206, b = 113, a = 255}
color_list[256] = {r = 167, g = 150, b = 116, a = 255}
color_list[512] = {r = 184, g = 134, b = 11, a = 255}
color_list[1024] = {r = 188, g = 143, b = 143, a = 255}
color_list[2048] = {r = 186, g = 85, b = 211, a = 255}

-- 定义网格信息
grid_list = {}

-- 初始化网格信息
for i = 1, 4 do
    -- 将 grid_list 的一维索引对应的元素声明为表
    grid_list[i] = {}
    for j = 1, 4 do
        -- 初始化指定索引位置上的网格对象
        grid_list[i][j] = {
            -- rect 属性描述网格的位置和大小
            rect = {x = i * 100, y = j * 100, w = 90, h = 90},
            -- value 属性描述当前网格的数值
            value = 0
        }
    end
end

-- 根据当前时间初始化随机数种子
math.randomseed(os.time())

-- 定义初始化新网格数值的可选值列表
init_elements = {2, 4}

-- 在一个随机位置生成初始数字
grid_list[math.random(1, 4)][math.random(1, 4)].value =
    init_elements[math.random(1, #init_elements)]

-- 定义移动网格、合并方块的数据逻辑处理函数
-- 接受代表四个方向的字符串作为参数
function MoveGrids(direction)
    -- 如果向上移动
    if direction == "up" then
        moveUp()
        -- 如果向下移动
    elseif direction == "down" then
        movedown()
        -- 如果向左移动
    elseif direction == "right" then
        moveright()
        -- 如果向右移动
    else
        moveleft()
    end
end
-- 移动函数
function moveUp()
    for i = 1, 4 do
        for j = 1, 4 do
            if grid_list[i][j].value ~= 0 then
                for k = j + 1, 4 do
                    if grid_list[i][k].value ~= 0 then
                        if (grid_list[i][j].value == grid_list[i][k].value) then
                            grid_list[i][j].value = grid_list[i][j].value * 2
                            grid_list[i][k].value = 0
                        end
                    end
                end
            end
        end
        t = 0
        temp = {}
        for j = 1, 4 do
            if grid_list[i][j].value ~= 0 then
                t = t + 1
                temp[t] = grid_list[i][j].value
            end
        end
        if t ~= 4 then
            while t < 4 do
                t = t + 1
                temp[t] = 0
            end
            for j = 1, 4 do grid_list[i][j].value = temp[j] end
        end
    end
end
function movedown()
    for i = 1, 4 do
        for k = 4, 2, -1 do
            if grid_list[k][i].value ~= 0 then
                for j = #grid_list[i], 2, -1 do
                    if grid_list[i][j].value ~= 0 then
                        if grid_list[i][j].value == grid_list[i][j - 1].value then
                            grid_list[i][j].value = grid_list[i][j].value * 2
                            grid_list[i][j - 1].value = 0
                        end
                    end
                end
            end
        end
        for j = #grid_list[i], 1, -1 do
            if grid_list[i][j].value == 0 then
                table.remove(grid_list[i], j)
            end
        end
        if #grid_list[i] < 4 then
            for j = 1, 4 - #grid_list[i] do
                table.insert(grid_list[i], 1, {value = 0})
            end
        end
        for j = 1, 4 do
            grid_list[i][j].rect = {x = i * 100, y = j * 100, w = 90, h = 90}
        end
    end
end
function moveright()
    for j = 1, 4 do
        for k = 4, 2, -1 do
            if grid_list[k][j].value == 0 then
                for i = j - 1, 1, -1 do
                    if grid_list[i][j].value ~= 0 then
                        if (grid_list[i][j].value == grid_list[i][k].value) then
                            grid_list[i][j].value = grid_list[i][j].value -- * 2
                            -- grid_list[i][j].value = 0
                        end
                    end
                end
            end
        end
        for m = 1, 4 do
            local temp = {}
            for n = 1, 4 do temp[n] = grid_list[n][j] end
            for k = 4, 1, -1 do
                if temp[k].value == 0 then table.remove(temp, k) end
            end
            if #temp > 1 then
                for k = 1, #temp - 1 do
                    if temp[k].value == temp[k + 1].value then
                        temp[k].value = temp[k].value * 2
                        temp[k + 1].value = 0
                    end
                end
            end
            for k = #temp, 1, -1 do
                if temp[k].value == 0 then table.remove(temp, k) end
            end
            if #temp < 4 then
                for k = 1, 4 - #temp do
                    table.insert(temp, 1, {value = 0})
                end
                for k = 1, 4 do
                    temp[k].rect = {x = k * 100, y = j * 100, w = 90, h = 90}
                end
            end
            for i = 1, 4 do grid_list[i][j] = temp[i] end
        end
    end
end
function moveleft()
    for i = 1, 4 do
        for j = 1, 4 do
            if grid_list[j][i].value ~= 0 then
                for k = j + 1, 4 do
                    if grid_list[k][i].value ~= 0 then
                        if (grid_list[j][i].value == grid_list[k][i].value) then
                            grid_list[j][i].value = grid_list[j][i].value * 2
                            grid_list[k][i].value = 0
                        end
                    end
                end
            end
        end
        t = 0
        temp = {}
        for j = 1, 4 do
            if grid_list[j][i].value ~= 0 then
                t = t + 1
                temp[t] = grid_list[j][i].value
            end
        end
        if t ~= 4 then
            while t <= 4 do
                t = t + 1
                temp[t] = 0
            end
            for j = 1, 4 do grid_list[j][i].value = temp[j] end
        end
    end
end

-- 定义检查游戏是否结束函数，如果游戏结束会修改全局变量 bIsQuit 为 true
-- 返回值为 "win" 或 "fail" 字符串代表游戏胜利或失败
function CheckGameOver()
    -- 首先设置变量假定所有的单元格均满
    local _bIsGridsFull = true
    -- 遍历每个单元格
    for i = 1, 4 do
        for j = 1, 4 do
            -- 如果当前单元格数值为 2048，则直接返回 "win"
            if grid_list[i][j].value == 2048 then
                bIsQuit = true
                return "win"
                -- 如果当前单元格数值为 0，则将代表单元格均满的变量置为 false
            elseif grid_list[i][j].value == 0 then
                _bIsGridsFull = false
            end
        end
    end
    -- 如果现在代表单元格均满的变量仍为 true，则返回 "fail"
    if _bIsGridsFull then
        bIsQuit = true
        return "fail"
    end
    -- 其他情况不返回任何值（即返回值为 nil）
end

-- 尝试生成新的数字网格
function GenerateNewNum()
    -- 定义局部变量存储值为 0 的网格
    local _empty_grid = {}
    -- 遍历网格列表，检索值为 0 的网格添加到 _empty_grid 中
    for i = 1, 4 do
        for j = 1, 4 do
            if grid_list[i][j].value == 0 then
                table.insert(_empty_grid, grid_list[i][j])
            end
        end
    end
    -- 如果当前仍有 “空白” 网格，则随机一个网格将其数值初始化为 2 或 4
    if #_empty_grid ~= 0 then
        _empty_grid[math.random(1, #_empty_grid)].value =
            init_elements[math.random(1, #init_elements)]
    end
end

-- 创建游戏窗口
Window.CreateWindow("2048 - sample", {
    x = Window.WINDOW_POSITION_DEFAULT,
    y = Window.WINDOW_POSITION_DEFAULT,
    w = 600,
    h = 600
}, {})

-- 游戏退出标志位
bIsQuit = false

-- 游戏主循环
while not bIsQuit do

    -- 获取当前帧开始时间
    local _nStartTime = Time.GetInitTime()

    -- 重设绘图颜色并清空上一帧绘制内容
    Graphic.SetDrawColor({r = 50, g = 50, b = 50, a = 255})
    Window.ClearWindow()

    -- 更新并获取游戏事件，根据事件类型做出响应
    while Interactivity.UpdateEvent() do

        -- 获取当前事件类型
        local _event = Interactivity.GetEventType()
        -- 如果为退出事件，则将游戏退出标志位置为真
        if _event == Interactivity.EVENT_QUIT then
            bIsQuit = true
            -- 如果为 ↑ 键抬起（本质为按键事件，为优化操作手感选择判定抬起事件，下同）
        elseif _event == Interactivity.EVENT_KEYUP_UP then
            MoveGrids("up")
            -- 尝试生成新的数字
            GenerateNewNum()
            -- 如果为 ↓ 键抬起
        elseif _event == Interactivity.EVENT_KEYUP_DOWN then
            MoveGrids("down")
            -- 尝试生成新的数字
            GenerateNewNum()
            -- 如果为 ← 键抬起
        elseif _event == Interactivity.EVENT_KEYUP_LEFT then
            MoveGrids("left")
            -- 尝试生成新的数字
            GenerateNewNum()
            -- 如果为 → 键抬起
        elseif _event == Interactivity.EVENT_KEYUP_RIGHT then
            MoveGrids("right")
            -- 尝试生成新的数字
            GenerateNewNum()
        end

    end

    -- 根据当前网格数据绘制每个单元格图像
    for i = 1, 4 do
        for j = 1, 4 do
            -- 绘制单元格底色
            Graphic.SetDrawColor(color_list[grid_list[i][j].value])
            Graphic.FillRoundRectangle(grid_list[i][j].rect, 5)
            -- 如果当前单元格值不为 0 则绘制数字
            if grid_list[i][j].value ~= 0 then
                -- 创建文本图片
                local _image = Graphic.CreateUTF8TextImageBlended(font,
                                                                  grid_list[i][j]
                                                                      .value, {
                    r = 75,
                    g = 75,
                    b = 75,
                    a = 255
                })
                -- 获取文本图片尺寸
                local _width, _height = _image:GetSize()
                -- 创建图片纹理
                local _texture = Graphic.CreateTexture(_image)
                -- 将纹理拷贝到渲染缓冲区内
                Graphic.CopyTexture(_texture, grid_list[i][j].rect)
            end
        end
    end

    -- 更新游戏窗口，将缓冲区图像数据冲刷到屏幕上
    Window.UpdateWindow()

    -- 检查游戏是否结束，如果结束则弹出消息框
    local _status = CheckGameOver()
    -- 如果 _status 存在（即 CheckGameOver 函数返回值不为空）则进入判断
    if _status then
        if _status == "win" then
            Window.ShowMessageBox(Window.MSGBOX_INFO, "游戏结束",
                                  "胜利！")
        else
            Window.ShowMessageBox(Window.MSGBOX_INFO, "游戏结束",
                                  "失败！")
        end
    end

    -- 动态延时，确保游戏帧率稳定在 60fps
    Time.DynamicSleep(1000 / 60, Time.GetInitTime() - _nStartTime)
end

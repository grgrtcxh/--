-- 引入相关模块
Window = UsingModule("Window")
Interact = UsingModule("Interactivity")
Graphic = UsingModule("Graphic")

-- 窗口尺寸位置
RECT_WINDOW = {
    x = Window.WINDOW_POSITION_DEFAULT, 
    y = Window.WINDOW_POSITION_DEFAULT, 
    w = 640, 
    h = 360
}

-- 创建窗口
Window.CreateWindow("红绿灯", RECT_WINDOW, {})

-- 按钮区域
RECT_BUTTON = {
    x = RECT_WINDOW.w / 2 - 150 / 2,
    y = RECT_WINDOW.h - 100,
    w = 150,
    h = 50
}
-- 左右两个圆形区域位置和尺寸
CIRCLE_LEFT = {
    center = {
        x = RECT_WINDOW.w / 2 - 125,
        y = RECT_WINDOW.h / 2 - 50
    },
    radius = 50
}
CIRCLE_RIGHT = {
    center = {
        x = RECT_WINDOW.w / 2 + 125,
        y = RECT_WINDOW.h / 2 - 50
    },
    radius = 50
}

-- 左右两个圆形区域的颜色
color_left = {r = 255, g = 0, b = 0, a = 255}
color_right = {r = 0, g = 255, b = 0, a = 255}

-- 游戏是否退出标志
isQuit = false

-- 游戏主循环
while not isQuit do

    while Interact.UpdateEvent() do
        -- 获取当前事件类型
        local _event = Interact.GetEventType()
        -- 如果是退出事件，就将退出标志位置为 true
        if _event == Interact.EVENT_QUIT then
            isQuit = true
        -- 如果是鼠标左键抬起事件
        elseif _event == Interact.EVENT_MOUSEBTNUP_LEFT then
            -- 获取当前鼠标位置
            local _position = Interact.GetCursorPosition()
            -- 如果鼠标位置在按钮区域内便翻转左右圆形颜色
            if
                _position.x >= RECT_BUTTON.x and _position.x <= RECT_BUTTON.x + RECT_BUTTON.w
                and _position.y >= RECT_BUTTON.y and _position.y <= RECT_BUTTON.y + RECT_BUTTON.h 
            then
                local _temp = color_left
                color_left = color_right
                color_right = _temp
            end
        end
    end
    
    -- 绘制白色的按钮区域
    Graphic.SetDrawColor({r = 175, g = 175, b = 175, a = 255})
    Graphic.FillRectangle(RECT_BUTTON)

    -- 根据当前左右两个圆形的颜色分别绘制两个圆形
    Graphic.SetDrawColor(color_left)
    Graphic.FillCircle(CIRCLE_LEFT.center, CIRCLE_LEFT.radius)
    Graphic.SetDrawColor(color_right)
    Graphic.FillCircle(CIRCLE_RIGHT.center, CIRCLE_RIGHT.radius)

    -- 将渲染缓冲区的内容刷新到窗口上
    Window.UpdateWindow()
end--]]
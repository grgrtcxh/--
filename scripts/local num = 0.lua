Window = UsingModule("Window")
Interactivity = UsingModule("Interactivity")
Graphic = UsingModule("Graphic")
Time = UsingModule("Time")
Window.CreateWindow("plane war", {
    x = Window.WINDOW_POSITION_DEFAULT,
    y = Window.WINDOW_POSITION_DEFAULT,
    w = 550,
    h = 750
}, {})
bIsQuit = false
while not isQuit do
    local sum = 0
    local _nStartTime = Time.GetInitTime()
    for i = 0,1,1 do
    local _image = Graphic.LoadImageFromFile(".//图片//2.png")
    local _nStartTime = Time.GetInitTime()
    local _width, _height = _image:GetSize()
    local _texture = Graphic.CreateTexture(_image)
    Graphic.CopyTexture(_texture,
                        {x = 100, y = 200, w = _width, h = _height})
        --print(sum)
    end
    local _nEndTime = Time.GetInitTime()
    print(_nEndTime - _nStartTime)
end

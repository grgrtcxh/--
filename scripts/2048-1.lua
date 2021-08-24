
Window = UsingModule("Window")
Interact = UsingModule("Interactivity")
Graphic = UsingModule("Graphic")

RECT_WINDOW = {
    x = Window.WINDOW_POSITION_DEFAULT, 
    y = Window.WINDOW_POSITION_DEFAULT, 
    w = 1600, 
    h = 1600
}
Window.CreateWindow("2048", RECT_WINDOW, {})
Gridnumberl = 4
Gridnumberr = 4
Radius = 2
Number = {}
for i = 0,Gridnumberl do
    for j = 0,Gridnumberr do
        local _grid = {
            x = i*30,
            y = j*30,
            w = 25,
            h = 25
        }  
        table.insert(Number,_grid)
        Graphic.SetDrawColor({r = 255, g = 0, b = 0, a = 255})
        Graphic.FillRoundRectangle(_grid,Radius)
    end
end
color_window = {r = 255, g = 0, b = 0, a = 255}
Window.UpdateWindow()
Graphic.LoadFontFromFile("./Inkfree.ttf",10)



Window.SetWindowMode(Window.WINDOW_MODE_WINDOWED)
isQuit = false

-- 游戏主循环
while not isQuit do
        while Interact.UpdateEvent() do
        -- 获取当前事件类型
            local _event = Interact.GetEventType()
        -- 如果是退出事件，就将退出标志位置为 true
            if _event == Interact.EVENT_QUIT then
            isQuit = true
        -- 如果是input
            elseif _event == Interact.GetEventType() then
            -- 获取当前input
            local _text = Interact.GetInputText()
                while _event==Interact.EVENT_KEYDOWN_P do
                    if _event==Interact.EVENT_KEYDOWN_A or _event==Interact.EVENT_KEYDOWN_W or _event==Interact.EVENT_KEYDOWN_S or _event==Interact.EVENT_KEYDOWN_D then
                        if _event==Interact.EVENT_KEYDOWN_A then
                        moveLeft(grid)
                        elseif _event==Interact.EVENT_KEYDOWN_W then
                        moveUp(grid)
                        elseif _event==Interact.EVENT_KEYDOWN_S then
                        moveDown(grid)
                        elseif _event==Interact.EVENT_KEYDOWN_D then
                        moveRight(grid)
                        end
                        randomNum(grid)
                        printGrid(grid)
                   
                end
            end
        end
end
function initGrid (m,n)
    local grid = {}
    for i=1,m do
        if not grid[i] then
            grid[i] = {}
        end
        for j=1,n do
            grid[i][j] = 0
        end
    end
    return grid
end
 function randomGrid(grid)
    local m = #grid
    local n = #grid[1]
    for i=1,m do
        for j=1,n do
            local r = math.random(1,5)
            local num = 2^r
            grid[i][j] = num
        end
    end
end
 function getRandomZeroPos(grid)
    local m = #grid
    local n = #grid[1]
    local zeros = {}
    for i=1,m do
        for j=1,n do
            if grid[i][j]==0 then
                table.insert(zeros,{i=i,j=j})
            end
        end
    end
    if #zeros>0 then
        local r = math.random(1,#zeros)
        return zeros[r].i,zeros[r].j
    end
end
 function randomNum(grid)
    local i,j = getRandomZeroPos(grid)
    if i and j then
        local r = math.random()
        if r<0.9 then
            grid[i][j] = 2
        else
            grid[i][j] = 4
        end
        return i,j
    end
end

 function moveLeft(grid)
    print("moveLeft")
    local m = #grid
    local n = #grid[1]
    for i=1,m do
        local line = {}
        for j=1,n do
            if grid[i][j]~=0 then
                table.insert(line,grid[i][j])
            end
        end
        local k=#line
        for j=1,n do
            if j<=k then
                grid[i][j] = line[j]
            else
                grid[i][j] = 0
            end
        end
        for j=1,k-1 do
            if grid[i][j]==grid[i][j+1] then
                grid[i][j+1] = grid[i][j] + grid[i][j+1]
                for x=j,n-1 do
                    grid[i][x] = grid[i][x+1]
                end
                grid[i][n] = 0
            end           
        end
    end
end
function moveRight(grid)
    print("moveRight")
    local m = #grid
    local n = #grid[1]
    for i=1,m do
        local line = {}
        for j=n,1,-1 do
            if grid[i][j]~=0 then
                table.insert(line,grid[i][j])
            end
        end
        local k = #line
        for j=n,1,-1 do
            if n-j+1<=k then
                grid[i][j] = line[n-j+1]
            else
                grid[i][j] = 0
            end
        end
        for j=n,n-k+2,-1 do
            if grid[i][j]==grid[i][j-1] then
                grid[i][j-1] = grid[i][j] + grid[i][j-1]
                for x=j,2,-1 do
                    grid[i][x] = grid[i][x-1]
                end
                grid[i][1] = 0
            end
        end
    end
end
 function moveUp(grid)
    print("moveUp")
    local m = #grid
    local n = #grid[1]
    for j=1,n do
        local line = {}
        for i=1,m do
            if grid[i][j]~=0 then
                table.insert(line,grid[i][j])
            end
        end
        local k = #line
        for i=1,m do
            if i<=k then
                grid[i][j] = line[i]
            else
                grid[i][j] = 0
            end
        end
        for i=1,k-1 do
            if grid[i][j]==grid[i+1][j] then
                grid[i+1][j] = grid[i][j] + grid[i+1][j]
                for x=i,m-1 do
                    grid[x][j] = grid[x+1][j]
                end
                grid[m][j] = 0
            end           
        end
    end
end
 function moveDown(grid)
    print("moveDown")
    local m = #grid
    local n = #grid[1]
    for j=1,n do
        local line = {}
        for i=m,1,-1 do
            if grid[i][j]~=0 then
                table.insert(line,grid[i][j])
            end
        end
        local k = #line
        for i=m,1,-1 do
            if m-i+1<=k then
                grid[i][j] = line[m-i+1]
            else
                grid[i][j] = 0
            end
        end
        for i=m,m-k+2,-1 do
            if grid[i][j]==grid[i-1][j] then
                grid[i-1][j] = grid[i][j] + grid[i-1][j]
                for x=i,2,-1 do
                    grid[x][j] = grid[x-1][j]
                end
                grid[1][j] = 0
            end
        end
    end
end
 function canMove(grid)
    local m = #grid
    local n = #grid[1]
    for i=1,m do
        for j=1,n do
            if grid[i][j]==0 then
                return true
            end
            if (i<m and j<n)
            and (grid[i][j]==grid[i][j+1]
                or grid[i][j]==grid[i+1][j]) then
                return true
            end
        end
    end
    return false
end
end
--[[function main()
    local grid = initGrid(4,4)
    randomNum(grid)
    printGrid(grid)
    io.write("next step 'a'[left],'w'[up],'s'[down],'d'[right],'q'[exit] >> ")
    local input = io.read()
end--]]
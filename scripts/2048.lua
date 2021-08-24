--Intorducing relevant modules 
Window = UsingModule("Window")
Interact = UsingModule("Interactivity")
Graphic = UsingModule("Graphic")

--window size
RECT_WINDOW = {
    x = Window.WINDOW_POSITION_DEFAULT,
    y = Window.WINDOW_POSITION_DEFAULT,
    w = 1600,
    h = 1600,
}

--set up the window
Window.CreateWindow("2048",RECT_WINDOW,{})

--grid draw
--Graphic.Rectangle()
--Graphic.FillRectangle()

-- grid build
function initGrid(m,n)
    local grid = {}
    for i=1,m do
        if not grid[i] then
            grid[i] = {}
        end
        for j=1,n do
            grid[i][j] = 0
        end
    end
    randomNum(grid)          
    randomNum(grid)
    return grid
end

-- randomnumber bulid
local function randomNum(grid)
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

--get the position of the number
local function getRandomZeroPos(grid)   
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
-- main circulation
 Window.SetWindowMode()
    gridShow = {}
    for tmp=0,15 do
        local i,j = math.floor(tmp/4)+1,math.floor(tmp%4)+1
        Graphic.FillRectangle(i,j)
        local num = grid[i][j]
        local s = tostring(num)
        --s = s.."("..i..","..j..")"
        if s=='0' then
            s=''
        end
        if not gridShow[i] then
            gridShow[i] = {}
        end
        local cell = {
            backgroundsize = 140,
            background = cc.LayerColor:create(colors[-1], 140, 140),
            num = cc.ui.UILabel.new({
                text = s,
                size = 40,
                color = numcolors[0],
            }),
        }
        gridShow[i][j] = cell
        self:show(gridShow[i][j],i,j)
    end

function MainScene:show(cell,mx,my)
    local x,y = getPosFormIdx(mx,my)
    local bsz = cell.backgroundsize/2
    cell.background:setPosition(cc.p(x-bsz,y-bsz))
    self:addChild(cell.background)
    cell.num:align(display.CENTER,x,y):addTo(self)
end
 
function getPosFormIdx(mx,my)
    local cellsize=150   -- cell size
    local cdis = 2*cellsize-cellsize/2
    local origin = {x=display.cx-cdis,y=display.cy+cdis}
    local x = (my-1)*cellsize+origin.x
    local y = -(mx-1)*cellsize+origin.y - 100
    return x,y
end

local function moveLeft(grid)
    print("moveLeft")
    local score = 0
    local win = false
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
                if grid[i][j+1]==2048 then
                    win = true
                end
                score = score + grid[i][j+1]
                for x=j,n-1 do
                    grid[i][x] = grid[i][x+1]
                end
                grid[i][n] = 0
            end             
        end
    end
    return score,win
end
--recordscore   
function saveStatus()
    local gridstr = serialize(grid)
    local isOverstr = "false"
    if isOver then isOverstr = "true" end
   -- local str = string.format("do local grid,bestScore,totalScore,WINSTR,isOver \
                          --    =%s,%d,%d,\'%s\',%s return grid,bestScore,totalScore,WINSTR,isOver end",
                           --   gridstr,bestScore,totalScore,WINSTR,isOverstr)
    --io.writefile(configFile,str)
end
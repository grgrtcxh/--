GAME_SIZE = 4 -- 4*4 Grids
GRID_SIZE = 5 -- 格子大小
tbNums = {}   -- 存储2048格子数据，二维
nScore = 0    -- 玩家分数
function GetNumLines(nRows)
    local szDelimiter = "|"
    local szModel = "%"..(GRID_SIZE*2+1).."s"..szDelimiter
    local szRes = szDelimiter
    for i = 1 , GAME_SIZE do
        local szNumber = tostring(tbNums[nRows][i])
        if szNumber == '0' then
            szNumber = " "
        end
        while #szNumber  < GRID_SIZE * 2 do
            szNumber = " "..szNumber.." "
        end
        szRes = szRes..string.format(szModel,szNumber)
    end
    return szRes
end
 
function GetLines(szLeft, szMid, szRight, szSpace)
    local nSpaceLen = GRID_SIZE * 2 + 1
    local szTmp = ""
    for i = 1 , nSpaceLen do
        szTmp = szTmp..szSpace
    end
    local szRes = szLeft..szTmp
    for i = 2, GAME_SIZE do
        szRes = szRes..szMid..szTmp
    end
    return szRes..szRight
end
 
function PrintGame()
    szHeadLine = GetLines("┌", "┬", "┐", "─")
    szMidLine = GetLines("├", "┼", "┤", "─")
    szSpaceLine = GetLines("│", "│", "│", " ")
    szEndLine = GetLines("└", "┴", "┘", "─")
    print(szHeadLine)
    for j = 1 , GRID_SIZE do
        if j == math.modf(GRID_SIZE/2) + 1 then
            print(GetNumLines(1))
        else
            print(szSpaceLine)
        end
    end
    for i = 2 , GAME_SIZE do
        print(szMidLine)
        for j = 1 , GRID_SIZE do
            if j == math.modf(GRID_SIZE/2) + 1 then
                print(GetNumLines(i))
            else
                print(szSpaceLine)
            end
        end
    end
    print(szEndLine)
end
 
function SetRandomGrids( )
    local nSpace = 0
    for i = 1 , GAME_SIZE do
        for j = 1 , GAME_SIZE do
            if tbNums[i][j] == 0 then
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
            if tbNums[i][j] == 0 then
                if nRand == 1 then
                    tbNums[i][j] = 2 * (math.random(1,10) < 8 and 1 or 2)
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
            local x = i
            local y = j
            repeat
                x = x + nX
                y = y + nY
            until tbGrids[x][y]~= 0
            if tbGrids[x][y] == tbGrids[i][j] then
                tbGrids[x][y] = tbGrids[x][y] * -2 -- 防止 2 2 4 8 这种情况发生一次性合并
                nScore = nScore + tbGrids[x][y] * -1
                tbGrids[i][j] = 0
            else
                if x - nX ~= i or y - nY ~= j then
                    tbGrids[x - nX][y - nY] = tbGrids[i][j]
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
 
function ExeRound( )
    print("\n$Score:"..nScore)
    SetRandomGrids()
    PrintGame()
    local szOrder = io.read(1)
    if szOrder == "A" or szOrder == "a" then
        Move(0, -1, tbNums)
    elseif szOrder == "W" or szOrder == "w" then
        Move(-1, 0, tbNums)
    elseif szOrder == "D" or szOrder == "d" then
        Move(0, 1, tbNums)
    elseif szOrder == "S" or szOrder == "s" then
        Move(1, 0, tbNums)
    elseif szOrder == "Z" or szOrder == "z" then
        MachineTip()
    end
end
 
function Init()
    for i = 0 , GAME_SIZE + 1 do
        local tbTmp = {}
        for j = 0 , GAME_SIZE + 1 do
            if i == 0 or i == GAME_SIZE + 1 or j == 0 or j == GAME_SIZE + 1 then
                tbTmp[j] = -1
            else
                tbTmp[j] = 0
            end
        end
        tbNums[i] = tbTmp
    end
    nScore = 0
end
 
function Main()
    Init()
    while true do
        ExeRound()
    end
end
 
Main()

screenWidth=768		--屏幕高度
screenHeight=1024	--屏幕宽度
boxWidth=90			--方块高度
boxHeight=90		--方块宽度
topPadding=240+45	--标头+偏移值
leftPadding=72+45	--左边距+偏移值


--[[
*
*主入口
*
]]
function main()
	for i=1,200 do
		if isInGame() then
			matrix=getMatrix()
			boxes=getMoveBoxes(matrix)
			moveBoxes(boxes)
			mSleep(0)
		end
	end
end

--[[
*
*是否在游戏中
*
*
]]
function isInGame()
	return getColor(662, 60)==getColor(686, 60)--捕获暂停键的颜色
end

--[[
*
*加载区域
*
*
]]
function getMatrix()
	local matrix={}
	--local s=""
	--math.randomseed(tostring(os.time()):reverse():sub(1, 6))
	for i=0,6 do
			matrix[i]={}
			for j=0,6 do
			o={}
			o.x=leftPadding + (j)*boxWidth
			o.y=topPadding + (i)*boxHeight
			o.c=getColor(o.x, o.y)--获取颜色
			--o.c=math.random(1,7)
			o.i=i+1 --纵坐标
			o.j=j+1	--横坐标
			matrix[i][j]=o
			--s=s..o.c.." "
			end
			--s=s.."\n"
			--print(s)
		end
	return matrix
end

--[[
*
*获取可移动的Box
*
*
]]
function getMoveBoxes(matrix)
	local boxes={}
		--横向遍历
		for y=0,6 do
			for x=0,6 do
				--找到横向两个颜色相同的方块
				if x<6 and matrix[y][x].c==matrix[y][x+1].c then
					--左上方
					if y>0 and x>0 and matrix[y][x].c==matrix[y-1][x-1].c then
						matrix[y-1][x-1].d="down"
						boxes[#boxes+1]=matrix[y-1][x-1]
					end
					--左边
					if x>1 and matrix[y][x].c==matrix[y][x-2].c then
						matrix[y][x-2].d="right"
						boxes[#boxes+1]=matrix[y][x-2]
					end
					--左下方
					if y<6 and x>0 and matrix[y][x].c==matrix[y+1][x-1].c then
						matrix[y+1][x-1].d="up"
						boxes[#boxes+1]=matrix[y+1][x-1]
					end
				end
				if x<5 and matrix[y][x].c==matrix[y][x+1].c then
					--查找结束点的目标移动方块（3个点）
					--右上方
					if y>0 and matrix[y][x+1].c==matrix[y-1][x+2].c then
						matrix[y-1][x+2].d="down"
						boxes[#boxes+1]=matrix[y-1][x+2]
					end
					--右方
					if x<4 and matrix[y][x+1].c==matrix[y][x+3].c then
						matrix[y][x+3].d="left"
						boxes[#boxes+1]=matrix[y][x+3]
					end
					--右下方
					if y<6 and matrix[y][x].c==matrix[y+1][x+2].c then
						matrix[y+1][x+2].d="up"
						boxes[#boxes+1]=matrix[y+1][x+2]
					end
				end
				--查找中间两点
				if x<5 and matrix[y][x].c==matrix[y][x+2].c then
					--中间上
					if y>0 and matrix[y][x].c==matrix[y-1][x+1].c  then
						matrix[y-1][x+1].d="down"
						boxes[#boxes+1]=matrix[y-1][x+1]
					end
					--中间下
					if y<6 and matrix[y][x].c==matrix[y+1][x+1].c  then
						matrix[y+1][x+1].d="up"
						boxes[#boxes+1]=matrix[y+1][x+1]
					end
				end
			end
		end
		--纵向遍历
		for x=0,6 do
			for y=0,6 do
				--找到纵向两个颜色相同的方块
				if y<6 and matrix[y][x].c==matrix[y+1][x].c then
					--查找开始点的目标移动方块（3个点）
					--左上方
					if y>0 and x>0 and matrix[y][x].c==matrix[y-1][x-1].c then
						matrix[y-1][x-1].d="right"
						boxes[#boxes+1]=matrix[y-1][x-1]
					end
					--上边
					if y>1 and matrix[y][x].c==matrix[y-2][x].c then
						matrix[y-2][x].d="down"
						boxes[#boxes+1]=matrix[y-2][x]
					end
					--右上方
					if y>0 and x<6 and matrix[y][x].c==matrix[y-1][x+1].c then
						matrix[y-1][x+1].d="left"
						boxes[#boxes+1]=matrix[y-1][x+1]
					end
				end
				--查找结束点的目标移动方块（3个点）
				if y<5 and matrix[y][x].c==matrix[y+1][x].c then
					--左下方
					if x>0 and matrix[y][x].c==matrix[y+2][x-1].c then
						matrix[y+2][x-1].d="right"
						boxes[#boxes+1]=matrix[y+2][x-1]
					end
					--下方
					if y<4 and matrix[y][x].c==matrix[y+3][x].c then
						matrix[y+3][x].d="up"
						boxes[#boxes+1]=matrix[y+3][x]
					end
					--右下方
					if x<6 and matrix[y][x].c==matrix[y+2][x+1].c then
						matrix[y+2][x+1].d="left"
						boxes[#boxes+1]=matrix[y+2][x+1]
					end
				end
				--查找中间两点
				if y<5 and matrix[y][x].c==matrix[y+2][x].c then
					--中间右
					if x<6 and matrix[y][x].c==matrix[y+1][x+1].c  then
						matrix[y+1][x+1].d="left"
						boxes[#boxes+1]=matrix[y+1][x+1]
					end
					--中间左
					if x>0 and matrix[y][x].c==matrix[y+1][x-1].c  then
						matrix[y+1][x-1].d="right"
						boxes[#boxes+1]=matrix[y+1][x-1]
					end
				end
			end
		end
	return boxes
end

--[[
*
*调用按键精灵方法实现滑动
*@id int 手指id
*@startX int 起始x
*@startY int 结束y
*@endX int 结束x
*@endY int 结束y
]]
function move(id,startX,startY,endX,endY)
	touchDown(id, startX, startY) -- ID为0的手指在坐标为(100, 100)的点按下
	touchMove(id, endX, endY)	  -- ID为0的手指滑动到坐标为(200, 100)的点
	touchUp(id)             	  -- ID为0的手指抬起
end

--[[
*
*移动指定方块
*@boxes array 要移动的坐标序列
*
]]
function moveBoxes(boxes)
	for	i,box in ipairs(boxes) do
		if box.d=="up" then
			move(i,box.x,box.y,box.x,box.y-90)--向上移动
		elseif box.d=="right" then
			move(i,box.x,box.y,box.x+90,box.y)--向右移动
		elseif box.d=="down" then
			move(i,box.x,box.y,box.x,box.y+90)--向下移动
		else
			move(i,box.x,box.y,box.x-90,box.y)--向左移动
		end
		--print (i,box.x,box.y,box.j,box.i,box.c,box.d)
	end
end

main()
mSleep(0)

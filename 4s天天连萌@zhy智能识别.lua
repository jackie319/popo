--[[
作者：Zhy
日期:2013年8月23日
]]
screenWidth=960		--屏目宽度
screenHeight=640	--屏幕高度
boxWidth=76			--方块宽度
boxHeight=96		--方块高度
quickModePaddingTop=88 	--快速模式上边距
quickModePaddingLeft=178--快速模式左边距
classicPaddingTop=96	--经典模式上边距
classicPaddingLeft=100	--经典模式左边距


--[[
*
*主入口
*
]]
function main()
	rotateScreen(90)	--坐标旋转为横屏home在右边
	for i=1,10 do
		if isInGame() then
			if isInQuickMode() then
				paddingTop=quickModePaddingTop
				paddingLeft=quickModePaddingLeft
			else
				paddingTop=classicPaddingTop
				paddingLeft=classicPaddingLeft
			end
			boxes=getBoxes()
			boxes=sortBoxes(boxes)
			touchBoxes(boxes)
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
	local c=getColor(898,47)--捕获暂停键颜色
	if c==0xffff3d then
		return true
	end
	return false
end

--[[
*
*是否是快速模式
*
*
]]
function isInQuickMode()
	local c=getColor(478,614)--捕获V字颜色
	if c==0x693408 then
		return true
	end
	return false
end

--[[
*
*加载区域
*
*
]]
function getBoxes()
	local boxes={}
	--math.randomseed(tostring(os.time()):reverse():sub(1, 6))
		for i=0,4 do
			for j=0,9 do
				local BoxBackGroundColor = getColor(paddingLeft + (j)*boxWidth + 8, paddingTop + (i)*boxHeight + 8)
				if BoxBackGroundColor==0xf4fdfd or BoxBackGroundColor==0xbfe2fe or BoxBackGroundColor==0x7cfff8  then --判定方块背景为白色
					o={}
					o.x=paddingLeft + (j)*boxWidth+38
					o.y=paddingTop + (i)*boxHeight+48
					o.c=getColor(o.x+38, o.y+48)--获取颜色
					--o.c=math.random(1,7)
					o.i=i+1 --纵坐标
					o.j=j+1	--横坐标
					boxes[#boxes+1]=o
				end
			end
		end
	return boxes
end

--[[
*
*冒泡法降序排序Box
*
*
]]
function sortBoxes(boxes)
	print(#boxes)
	for i=1,#boxes-1 do
		for j=1,#boxes-1 do
			if boxes[j].c<boxes[j+1].c then
				local o=boxes[j]
				boxes[j]=boxes[j+1]
				boxes[j+1]=o
			end
		end
	end
	return boxes
end

--[[
*
*调用按键精灵方法实现点击
*@id int 手指id
*@x int x坐标
*@y int y坐标
*
]]
function touch(id,x,y)
	touchDown(id, x, y) 	  -- ID为0的手指在坐标为(100, 100)的点按下
	touchUp(id)            	  -- ID为0的手指抬起
end

--[[
*
*按下指定方块
*@boxes array 要按下的坐标序列
*
]]
function touchBoxes(boxes)
	for	i,box in ipairs(boxes) do
		touch(i,box.x,box.y)
		--notifyMessage(box.x..","..box.y..","..box.c)
		--print(box.x..","..box.y..","..box.c)
	end
	--notifyMessage(#boxes)
end

main()


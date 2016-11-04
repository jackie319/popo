--[[
���ߣ�Zhy
����:2013��8��23��
]]
screenWidth=960		--��Ŀ���
screenHeight=640	--��Ļ�߶�
boxWidth=76			--������
boxHeight=96		--����߶�
quickModePaddingTop=88 	--����ģʽ�ϱ߾�
quickModePaddingLeft=178--����ģʽ��߾�
classicPaddingTop=96	--����ģʽ�ϱ߾�
classicPaddingLeft=100	--����ģʽ��߾�


--[[
*
*�����
*
]]
function main()
	rotateScreen(90)	--������תΪ����home���ұ�
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
*�Ƿ�����Ϸ��
*
*
]]
function isInGame()
	local c=getColor(898,47)--������ͣ����ɫ
	if c==0xffff3d then
		return true
	end
	return false
end

--[[
*
*�Ƿ��ǿ���ģʽ
*
*
]]
function isInQuickMode()
	local c=getColor(478,614)--����V����ɫ
	if c==0x693408 then
		return true
	end
	return false
end

--[[
*
*��������
*
*
]]
function getBoxes()
	local boxes={}
	--math.randomseed(tostring(os.time()):reverse():sub(1, 6))
		for i=0,4 do
			for j=0,9 do
				local BoxBackGroundColor = getColor(paddingLeft + (j)*boxWidth + 8, paddingTop + (i)*boxHeight + 8)
				if BoxBackGroundColor==0xf4fdfd or BoxBackGroundColor==0xbfe2fe or BoxBackGroundColor==0x7cfff8  then --�ж����鱳��Ϊ��ɫ
					o={}
					o.x=paddingLeft + (j)*boxWidth+38
					o.y=paddingTop + (i)*boxHeight+48
					o.c=getColor(o.x+38, o.y+48)--��ȡ��ɫ
					--o.c=math.random(1,7)
					o.i=i+1 --������
					o.j=j+1	--������
					boxes[#boxes+1]=o
				end
			end
		end
	return boxes
end

--[[
*
*ð�ݷ���������Box
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
*���ð������鷽��ʵ�ֵ��
*@id int ��ָid
*@x int x����
*@y int y����
*
]]
function touch(id,x,y)
	touchDown(id, x, y) 	  -- IDΪ0����ָ������Ϊ(100, 100)�ĵ㰴��
	touchUp(id)            	  -- IDΪ0����ָ̧��
end

--[[
*
*����ָ������
*@boxes array Ҫ���µ���������
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


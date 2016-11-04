--[[
���ߣ�Zhy
����:2013��8��16��
]]
screenWidth=640		--��Ļ�߶�
screenHeight=960	--��Ļ���
boxWidth=90			--����߶�
boxHeight=90		--������
topPadding=208+45	--��ͷ+ƫ��ֵ
leftPadding=5+45	--��߾�+ƫ��ֵ


--[[
*
*�����
*
]]
function main()
	for i=1,200 do
		if isInGame() then
			matrix=getMatrix()
			boxes=getMoveBoxes(matrix)
			moveBoxes(boxes)
			mSleep(3)
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
	return getColor(549, 45)==getColor(568, 45)--������ͣ������ɫ
end

--[[
*
*��������
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
			o.c=getColor(o.x, o.y)--��ȡ��ɫ
			--o.c=math.random(1,7)
			o.i=i+1 --������
			o.j=j+1	--������
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
*��ȡ���ƶ���Box
*
*
]]
function getMoveBoxes(matrix)
	local boxes={}
		--�������
		for y=0,6 do
			for x=0,6 do
				--�ҵ�����������ɫ��ͬ�ķ���
				if x<6 and matrix[y][x].c==matrix[y][x+1].c then
					--���Ϸ�
					if y>0 and x>0 and matrix[y][x].c==matrix[y-1][x-1].c then
						matrix[y-1][x-1].d="down"
						boxes[#boxes+1]=matrix[y-1][x-1]
					end
					--���
					if x>1 and matrix[y][x].c==matrix[y][x-2].c then
						matrix[y][x-2].d="right"
						boxes[#boxes+1]=matrix[y][x-2]
					end
					--���·�
					if y<6 and x>0 and matrix[y][x].c==matrix[y+1][x-1].c then
						matrix[y+1][x-1].d="up"
						boxes[#boxes+1]=matrix[y+1][x-1]
					end
				end
				if x<5 and matrix[y][x].c==matrix[y][x+1].c then
					--���ҽ������Ŀ���ƶ����飨3���㣩
					--���Ϸ�
					if y>0 and matrix[y][x+1].c==matrix[y-1][x+2].c then
						matrix[y-1][x+2].d="down"
						boxes[#boxes+1]=matrix[y-1][x+2]
					end
					--�ҷ�
					if x<4 and matrix[y][x+1].c==matrix[y][x+3].c then
						matrix[y][x+3].d="left"
						boxes[#boxes+1]=matrix[y][x+3]
					end
					--���·�
					if y<6 and matrix[y][x].c==matrix[y+1][x+2].c then
						matrix[y+1][x+2].d="up"
						boxes[#boxes+1]=matrix[y+1][x+2]
					end
				end
				--�����м�����
				if x<5 and matrix[y][x].c==matrix[y][x+2].c then
					--�м���
					if y>0 and matrix[y][x].c==matrix[y-1][x+1].c  then
						matrix[y-1][x+1].d="down"
						boxes[#boxes+1]=matrix[y-1][x+1]
					end
					--�м���
					if y<6 and matrix[y][x].c==matrix[y+1][x+1].c  then
						matrix[y+1][x+1].d="up"
						boxes[#boxes+1]=matrix[y+1][x+1]
					end
				end
			end
		end
		--�������
		for x=0,6 do
			for y=0,6 do
				--�ҵ�����������ɫ��ͬ�ķ���
				if y<6 and matrix[y][x].c==matrix[y+1][x].c then
					--���ҿ�ʼ���Ŀ���ƶ����飨3���㣩
					--���Ϸ�
					if y>0 and x>0 and matrix[y][x].c==matrix[y-1][x-1].c then
						matrix[y-1][x-1].d="right"
						boxes[#boxes+1]=matrix[y-1][x-1]
					end
					--�ϱ�
					if y>1 and matrix[y][x].c==matrix[y-2][x].c then
						matrix[y-2][x].d="down"
						boxes[#boxes+1]=matrix[y-2][x]
					end
					--���Ϸ�
					if y>0 and x<6 and matrix[y][x].c==matrix[y-1][x+1].c then
						matrix[y-1][x+1].d="left"
						boxes[#boxes+1]=matrix[y-1][x+1]
					end
				end
				--���ҽ������Ŀ���ƶ����飨3���㣩
				if y<5 and matrix[y][x].c==matrix[y+1][x].c then
					--���·�
					if x>0 and matrix[y][x].c==matrix[y+2][x-1].c then
						matrix[y+2][x-1].d="right"
						boxes[#boxes+1]=matrix[y+2][x-1]
					end
					--�·�
					if y<4 and matrix[y][x].c==matrix[y+3][x].c then
						matrix[y+3][x].d="up"
						boxes[#boxes+1]=matrix[y+3][x]
					end
					--���·�
					if x<6 and matrix[y][x].c==matrix[y+2][x+1].c then
						matrix[y+2][x+1].d="left"
						boxes[#boxes+1]=matrix[y+2][x+1]
					end
				end
				--�����м�����
				if y<5 and matrix[y][x].c==matrix[y+2][x].c then
					--�м���
					if x<6 and matrix[y][x].c==matrix[y+1][x+1].c  then
						matrix[y+1][x+1].d="left"
						boxes[#boxes+1]=matrix[y+1][x+1]
					end
					--�м���
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
*���ð������鷽��ʵ�ֻ���
*@id int ��ָid
*@startX int ��ʼx
*@startY int ����y
*@endX int ����x
*@endY int ����y
]]
function move(id,startX,startY,endX,endY)
	touchDown(id, startX, startY) -- IDΪ0����ָ������Ϊ(100, 100)�ĵ㰴��
	touchMove(id, endX, endY)	  -- IDΪ0����ָ����������Ϊ(200, 100)�ĵ�
	touchUp(id)             	  -- IDΪ0����ָ̧��
end

--[[
*
*�ƶ�ָ������
*@boxes array Ҫ�ƶ�����������
*
]]
function moveBoxes(boxes)
	for	i,box in ipairs(boxes) do
		if box.d=="up" then
			move(i,box.x,box.y,box.x,box.y-90)--�����ƶ�
		elseif box.d=="right" then
			move(i,box.x,box.y,box.x+90,box.y)--�����ƶ�
		elseif box.d=="down" then
			move(i,box.x,box.y,box.x,box.y+90)--�����ƶ�
		else
			move(i,box.x,box.y,box.x-90,box.y)--�����ƶ�
		end
		--print (i,box.x,box.y,box.j,box.i,box.c,box.d)
	end
end

main()


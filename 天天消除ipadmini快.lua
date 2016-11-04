
SCREEN_RESOLUTION="768x1024";



function main()

		if isInGame() then
			move();
			mSleep(0)
		end
end

function isInGame()
	return getColor(662, 60)==getColor(686, 60)--捕获暂停键的颜色
end

function move()

   for i=0,6,1 do
    x=90*i;

	for u=0,6,1 do
	 xa=117+x; --左边距+二分之一矩形+x
	 ya=285+90*u;--上边距+二分之一矩形+边长*u
     sya=ya+90;
	 xya=ya-90;
     zxa=xa-90;
     yxa=xa+90;


    touchDown(i,xa,ya);
    touchMove(i,xa,sya);
    touchDown(i,xa,ya);
    touchMove(i,xa,xya);
    touchDown(i,xa,ya);
    touchMove(i,zxa,ya);
    touchDown(i,xa,ya);
    touchMove(i,yxa,ya);
    touchUp(i);

	end

   end

    mSleep(0);
end

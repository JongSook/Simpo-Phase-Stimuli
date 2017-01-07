function RefCB = openRefFlickerWindow(monitor)

RefCB1File = './figure/black_192.bmp';
RefCB2File = './figure/white_192.bmp';


RefCB1 = imread(RefCB1File);
RefCB2 = imread(RefCB2File);
RefCBInfo = imfinfo(RefCB1File);

RefCB1 = Screen('MakeTexture', monitor, RefCB1);
RefCB2 = Screen('MakeTexture', monitor, RefCB2);
RefCB.textures = [RefCB1 RefCB2];
RefCBCorner = floor([-abs([RefCBInfo.Width RefCBInfo.Height]) abs([RefCBInfo.Width RefCBInfo.Height])]/2);


RefCB.positions =  repmat([100 1000] ,1 ,2) + RefCBCorner;

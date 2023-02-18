num=4;
p=20;
x=cell(num,p);
for t=0:num-1
    Path = 'G:\模式识别课设\datespace2\';  
    filePath1 = [Path,int2str(t),'\'];  %拼接字符串
    
    Path2 = 'G:\模式识别课设\datespace2\原图局部\';   %原图中间部分
    filePath2 = [Path2,int2str(t),'\']; 
    
    Path3 = 'G:\模式识别课设\datespace2\hsv局部\';     %h通道下样本图片中间部分
    filePath3 = [Path3,int2str(t),'\'];
    
%      Path4 = 'G:\模式识别课设\datespace2\hsv局部\';    
%      filePath4 = [Path4,int2str(t),'\'];
    for k=1:p
        image = imread([filePath1,int2str(k),'.jpg']);
        image = imresize(image,[250 250]);  %图片样本归一化
%         image = rgb2hsv(image);       %将RGB图或颜色图转化为HSV
%         image = image(:,:,1);         %将H通道作为标准识别
        image=imcrop(image,[100 100 49 49]);    %%截取中间图像
        imwrite(image,[filePath2,int2str(k),'.jpg']);%中间图像样本保存
        
        image = rgb2hsv(image);       %将RGB图或颜色图转化为HSV
        image = image(:,:,1);         %将H通道作为标准识别
        imwrite(image,[filePath3,int2str(k),'.jpg']);   %保存h通道样本图片
        x{t+1,k} = image;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%求均值

sum={num,p};   %创建3*20的cell变量，用来存放总和
ave={num,p};   %创建3*20的cell变量，用来存放均值

for t=1:num
    for k=1:p
        sum{t,k}=0;    %初始化
        for a=1:50     %每一张50*50图片的像素值加和
            for b=1:50
                sum{t,k}=sum{t,k} + x{t,k}(a,b); 
            end
        end
        ave{t,k}=sum{t,k}/2500;   %均值
%         filePath4 = 'G:\模式识别课设\datespace2\均值\';
%        imwrite(ave{t,1},[filePath4,int2str(t-1),'.jpg']);%保存均值图片
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%匹配
image=imread('G:\模式识别课设\datespace2\2\21.jpg');

image = imresize(image,[250 250]);
image = rgb2hsv(image);       
image = image(:,:,1);
image=imcrop(image,[100 100 49 49]);

sum1=0;
for t=1:50
    for k=1:50
        sum1=sum1 + image(t,k);
    end
end
ave1=sum1/2500;

s={0;
   0;
   0;
   0};     %存放差值

for t=1:4
    s{t}=0;
    for k=1:20
        s{t}=s{t,1}+abs(ave{t,k}-ave1); %20张样本图均值与测试图均值求差绝对值化再求和
    end
end


m=cell2mat(s);%将m转化为普通数组类型
m=m';
m=double(m);
[minval,index] = min(m);%计算m中的最小值minval并且存放其下标index
if index==1
    fprintf('红烧肉');
else if index==2
    fprintf('荷兰豆');   
    else if index==3
    fprintf('紫薯');
        else fprintf("蒜苔");
    end
   end
end

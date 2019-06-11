clear all;clc;close all

% Find the RGB histogram values and concatenate them
path = dir('D:\bhaveshfiles\python\Color_Images\Color_Images\*.jpg');
for i=1:length(path)
    filename=strcat('D:\bhaveshfiles\python\Color_Images\Color_Images\',path(i).name);
    I{i}=imread(filename);
    temp=I{i};
    %temp=imresize(I{i}, [512, 512]);
    red=temp(:,:,1);
    green=temp(:,:,2);
    blue=temp(:,:,3);
    histogramR(i,:)=imhist(red);
    histogramG(i,:)=imhist(green);
    histogramB(i,:)=imhist(blue);
    comp_histo(i,:)=[histogramR(i,:),histogramG(i,:),histogramB(i,:)];
end

% Find the minimum value of individual histogram bin values to get closest
% match histogram
[l,n]=size(comp_histo);
reference=comp_histo(250,:);
for i=1:l
    for j=1:n
        min_hist(i,j)=min(reference(1,j),comp_histo(i,j));
    end
end

% Normalize the sum of minimum histogram to get percentage match
for i=1:l
    sum_hist(i)=sum(min_hist(i,:))/sum(reference);
end

% Get the closest image and its index value
[sorted,index] = sort(sum_hist,'descend');

% Plot
figure,imshow(I{index(1)}),title('Original Reference image')
figure,subplot(2,2,1),imshow(I{index(2)}),title('Fisrt match')
subplot(2,2,2),imshow(I{index(3)}),title('Second match')
subplot(2,2,3),imshow(I{index(4)}),title('Third match')
subplot(2,2,4),imshow(I{index(5)}),title('Fourth match')

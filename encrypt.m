function [IMG, time] = encrypt(img11_RGB, img22_RGB)

[m, n] = size(img11_RGB(:, :, 1));
size1 = m;

% Generate all permutations of [1,2,3,4,5,6]
permutations = perms(1:6);
numbers = 1:720;
selected_permutations = zeros(720, 6);

for i = 1:720
    index = numbers(i);
    selected_permutations(i, :) = permutations(index, :);
end


a = 1.5; 
b = 1.2; 
N0 = 1000; 
L1 = 6; 
L2 = m * n;
total_iterations = N0 + L1 + L2; 

x = zeros(1, total_iterations); 
y = zeros(1, total_iterations); 
xn = zeros(1, L1); 
q = zeros(1, L1); 

x(1) = 0.5; 
y(1) = 0.5; 

for i = 1:total_iterations - 1
    x(i + 1) = a * sin(exp(y(i)^2) + x(i));
    y(i + 1) = b * cos(exp(x(i)^2) + y(i));
    
    if i > N0
        xn(i - N0) = x(i + 1); 
        q(i - N0) = mod(floor(x(i + 1) * 10^15), L2) + 1; 
    end
end

% First round of scrambling
P11 = New_saomiao_suijiQidian(q(1), img11_RGB(:, :, 1), size1);
P22 = New_saomiao_suijiQidian(q(2), img11_RGB(:, :, 2), size1);
P33 = New_saomiao_suijiQidian(q(3), img11_RGB(:, :, 3), size1);
P44 = New_saomiao_suijiQidian(q(4), img22_RGB(:, :, 1), size1);
P55 = New_saomiao_suijiQidian(q(5), img22_RGB(:, :, 2), size1);
P66 = New_saomiao_suijiQidian(q(6), img22_RGB(:, :, 3), size1);

% Combine into a single array for reordering
Line_a = zeros(1, size1 * size1 * 6);
for i = 1:size1 * size1
    Line_a(6 * (i - 1) + selected_permutations(m(i), 1)) = P11(i);
    Line_a(6 * (i - 1) + selected_permutations(m(i), 2)) = P22(i);
    Line_a(6 * (i - 1) + selected_permutations(m(i), 3)) = P33(i);
    Line_a(6 * (i - 1) + selected_permutations(m(i), 4)) = P44(i);
    Line_a(6 * (i - 1) + selected_permutations(m(i), 5)) = P55(i);
    Line_a(6 * (i - 1) + selected_permutations(m(i), 6)) = P66(i);
end

% Split into six individual images
Line_img = reshape(Line_a, size1, size1 * 6);
Img_1_6 = Line_img(:, 1:size1);
Img_2_6 = Line_img(:, size1 + 1:2 * size1);
Img_3_6 = Line_img(:, 2 * size1 + 1:3 * size1);
Img_4_6 = Line_img(:, 3 * size1 + 1:4 * size1);
Img_5_6 = Line_img(:, 4 * size1 + 1:5 * size1);
Img_6_6 = Line_img(:, 5 * size1 + 1:6 * size1);

% Second round of scrambling
P1_1_2 = New_saomiao_suijiQidian(q(1), Img_1_6, size1);
P2_1_2 = New_saomiao_suijiQidian(q(2), Img_2_6, size1);
P3_1_2 = New_saomiao_suijiQidian(q(3), Img_3_6, size1);
P4_1_2 = New_saomiao_suijiQidian(q(4), Img_4_6, size1);
P5_1_2 = New_saomiao_suijiQidian(q(5), Img_5_6, size1);
P6_1_2 = New_saomiao_suijiQidian(q(6), Img_6_6, size1);

% Combine scrambled images into a single array
Line = zeros(1, size1 * size1 * 6);
for i = 1:size1 * size1
    Line(6 * (i - 1) + selected_permutations(m(i), 1)) = P1_1_2(i);
    Line(6 * (i - 1) + selected_permutations(m(i), 2)) = P2_1_2(i);
    Line(6 * (i - 1) + selected_permutations(m(i), 3)) = P3_1_2(i);
    Line(6 * (i - 1) + selected_permutations(m(i), 4)) = P4_1_2(i);
    Line(6 * (i - 1) + selected_permutations(m(i), 5)) = P5_1_2(i);
    Line(6 * (i - 1) + selected_permutations(m(i), 6)) = P6_1_2(i);
end

% Split scrambled data into six images
Line_img_1 = reshape(Line, size1, size1 * 6);
Img_1 = Line_img_1(:, 1:size1);
Img_2 = Line_img_1(:, size1 + 1:2 * size1);
Img_3 = Line_img_1(:, 2 * size1 + 1:3 * size1);
Img_4 = Line_img_1(:, 3 * size1 + 1:4 * size1);
Img_5 = Line_img_1(:, 4 * size1 + 1:5 * size1);
Img_6 = Line_img_1(:, 5 * size1 + 1:6 * size1);

% Combine images into a single 6-channel encrypted image
IMG = cat(6, Img_1, Img_2, Img_3, Img_4, Img_5, Img_6);

% Additional transformation
IMG1_before = horzcat(Img_1, Img_2, Img_3, Img_4, Img_5, Img_6);
IMG1_after = Function_anuode(IMG1_before);

IMG(:, :, 1) = IMG1_after(:, 1:size1);
IMG(:, :, 2) = IMG1_after(:, size1 + 1:2 * size1);
IMG(:, :, 3) = IMG1_after(:, 2 * size1 + 1:3 * size1);
IMG(:, :, 4) = IMG1_after(:, 3 * size1 + 1:4 * size1);
IMG(:, :, 5) = IMG1_after(:, 4 * size1 + 1:5 * size1);
IMG(:, :, 6) = IMG1_after(:, 5 * size1 + 1:6 * size1);

end

function Line = New_saomiao_suijiQidian(term2,img1,n)


Line1=zeros(1,(n*n-n)/2);

for i=1:(n-2)/2+1
for j=1:4*(i-1)+1

    x=(n-2*(i-1)+floor(j/2));
    y=2+floor((j-1)/4)*2-mod(j,2);
    Line1( (4*(i-1)-2)*(i-1)/2 +j)=img1(x,y);

end
end


    Line2=zeros(1,n);
    for i=1:n
        Line2(i)=img1(i,i);
    end





Line3 = zeros(1, (n*n-n)/2);
for i = (n-2)/2+1 : -1 : 1
    for j = 1 : 4*(i-1)+1
        
        y = (n-2*(i-1) + floor(j/2));
        x = 2 + floor((j-1)/4)*2 - mod(j, 2);

        Line3((4*(n-2)/2+1+4*i+1)*((n-2)/2+1-i)/2+j) = img1(x, y); 

    end
end





Line=horzcat(Line1,Line2,Line3);


line_s1 = fliplr(Line(1:term2));
line_s2 = Line(term2+1:n*n);


len1 = length(line_s1);   
len2 = length(line_s2);
Line_new = zeros(1, n*n) + NaN;

if len1 > len2
    for k = 1:len2
        Line_new(2*(k-1)+1) = line_s1(k);
        Line_new(2*(k-1)+2) = line_s2(k);
    end
    Line_new = horzcat(Line_new, line_s1(len1-(len1-len2)+1:len1));
else
    for k = 1:len1
        Line_new(2*(k-1)+1) = line_s1(k);
        Line_new(2*(k-1)+2) = line_s2(k);
    end
    Line_new = horzcat(Line_new, line_s2(len2-(len2-len1)+1:len2));
end

Line_new(isnan(Line_new)) = [];
Line = Line_new;

end








function [img11_RGB_b, img22_RGB_b] = decrypt(IMG)

[m, n] = size(IMG(:, :, 1));
size1 = m;

permutations = perms(1:6);
numbers = 1:720;
selected_permutations = zeros(720, 6);

for i = 1:720
    index = numbers(i);
    selected_permutations(i, :) = permutations(index, :);
end

L1 = 6;
N0 = 1000;
q = zeros(1, L1);
xn = zeros(1, L1);

x1 = -0.8;
r1 = 0.9;
for i = 1:N0 + L1
    x1 = cos(r1 / asin(x1));
    if i > N0
        xn(i - N0) = x1;
        q(i - N0) = mod(floor(x1 * 10^15), m * m) + 1;
    end
end

L2 = size1 * size1;
m_arr = zeros(1, L2);
N1 = 1000;
x2 = 0.8;
r2 = 1.2;
for i = 1:N1 + L2
    x2 = cos(r2 / asin(x2));
    if i > N1
        m_arr(i - N1) = mod(floor(x2 * 10^15), 719) + 1;
    end
end

IMG1_after(:, 1:size1) = IMG(:, :, 1);
IMG1_after(:, size1 + 1:2 * size1) = IMG(:, :, 2);
IMG1_after(:, 2 * size1 + 1:3 * size1) = IMG(:, :, 3);
IMG1_after(:, 3 * size1 + 1:4 * size1) = IMG(:, :, 4);
IMG1_after(:, 4 * size1 + 1:5 * size1) = IMG(:, :, 5);
IMG1_after(:, 5 * size1 + 1:6 * size1) = IMG(:, :, 6);

IMG1_before = Decrypt_Arnold_diffusion(IMG1_after);

Img_1 = IMG1_before(:, 1:size1);
Img_2 = IMG1_before(:, size1 + 1:2 * size1);
Img_3 = IMG1_before(:, 2 * size1 + 1:3 * size1);
Img_4 = IMG1_before(:, 3 * size1 + 1:4 * size1);
Img_5 = IMG1_before(:, 4 * size1 + 1:5 * size1);
Img_6 = IMG1_before(:, 5 * size1 + 1:6 * size1);

Line_img_1(:, 1:size1) = Img_1;
Line_img_1(:, size1 + 1:2 * size1) = Img_2;
Line_img_1(:, 2 * size1 + 1:3 * size1) = Img_3;
Line_img_1(:, 3 * size1 + 1:4 * size1) = Img_4;
Line_img_1(:, 4 * size1 + 1:5 * size1) = Img_5;
Line_img_1(:, 5 * size1 + 1:6 * size1) = Img_6;

Line = reshape(Line_img_1, 1, size1 * size1 * 6);

P1_1_2 = zeros(1, size1 * size1);
P2_1_2 = zeros(1, size1 * size1);
P3_1_2 = zeros(1, size1 * size1);
P4_1_2 = zeros(1, size1 * size1);
P5_1_2 = zeros(1, size1 * size1);
P6_1_2 = zeros(1, size1 * size1);

for i = 1:size1 * size1
    P1_1_2(i) = Line(6 * (i - 1) + selected_permutations(m_arr(i), 1));
    P2_1_2(i) = Line(6 * (i - 1) + selected_permutations(m_arr(i), 2));
    P3_1_2(i) = Line(6 * (i - 1) + selected_permutations(m_arr(i), 3));
    P4_1_2(i) = Line(6 * (i - 1) + selected_permutations(m_arr(i), 4));
    P5_1_2(i) = Line(6 * (i - 1) + selected_permutations(m_arr(i), 5));
    P6_1_2(i) = Line(6 * (i - 1) + selected_permutations(m_arr(i), 6));
end

Img_1_6 = New_saomiao_suijiQidian_Jiemi(q(1), P1_1_2, size1);
Img_2_6 = New_saomiao_suijiQidian_Jiemi(q(2), P2_1_2, size1);
Img_3_6 = New_saomiao_suijiQidian_Jiemi(q(3), P3_1_2, size1);
Img_4_6 = New_saomiao_suijiQidian_Jiemi(q(4), P4_1_2, size1);
Img_5_6 = New_saomiao_suijiQidian_Jiemi(q(5), P5_1_2, size1);
Img_6_6 = New_saomiao_suijiQidian_Jiemi(q(6), P6_1_2, size1);

Line_img(:, 1:size1) = Img_1_6;
Line_img(:, size1 + 1:2 * size1) = Img_2_6;
Line_img(:, 2 * size1 + 1:3 * size1) = Img_3_6;
Line_img(:, 3 * size1 + 1:4 * size1) = Img_4_6;
Line_img(:, 4 * size1 + 1:5 * size1) = Img_5_6;
Line_img(:, 5 * size1 + 1:6 * size1) = Img_6_6;

Line_a = reshape(Line_img, 1, size1 * size1 * 6);

P11 = zeros(1, size1 * size1);
P22 = zeros(1, size1 * size1);
P33 = zeros(1, size1 * size1);
P44 = zeros(1, size1 * size1);
P55 = zeros(1, size1 * size1);
P66 = zeros(1, size1 * size1);

for i = 1:size1 * size1
    P11(i) = Line_a(6 * (i - 1) + selected_permutations(m_arr(i), 1));
    P22(i) = Line_a(6 * (i - 1) + selected_permutations(m_arr(i), 2));
    P33(i) = Line_a(6 * (i - 1) + selected_permutations(m_arr(i), 3));
    P44(i) = Line_a(6 * (i - 1) + selected_permutations(m_arr(i), 4));
    P55(i) = Line_a(6 * (i - 1) + selected_permutations(m_arr(i), 5));
    P66(i) = Line_a(6 * (i - 1) + selected_permutations(m_arr(i), 6));
end

img11_RGB_b(:, :, 1) = New_saomiao_suijiQidian_Jiemi(q(1), P11, size1);
img11_RGB_b(:, :, 2) = New_saomiao_suijiQidian_Jiemi(q(2), P22, size1);
img11_RGB_b(:, :, 3) = New_saomiao_suijiQidian_Jiemi(q(3), P33, size1);
img22_RGB_b(:, :, 1) = New_saomiao_suijiQidian_Jiemi(q(4), P44, size1);
img22_RGB_b(:, :, 2) = New_saomiao_suijiQidian_Jiemi(q(5), P55, size1);
img22_RGB_b(:, :, 3) = New_saomiao_suijiQidian_Jiemi(q(6), P66, size1);

img11_RGB_b = uint8(img11_RGB_b);
img22_RGB_b = uint8(img22_RGB_b);

end

function img1 = New_saomiao_suijiQidian_Jiemi(term2, Line, n)
    Line1 = Zhongjiandian_Wangfan_Jiemi(term2, Line, n*n);
    img1 = New_Saomiao_Jiemi(Line1, n);
end

function Line1 = Zhongjiandian_Wangfan_Jiemi(zhongdian, Line, jieshu)
    line_s1 = zeros(1, zhongdian);   % term-1
    line_s2 = zeros(1, jieshu - zhongdian);   % size*size-term+1
    min_val = min(zhongdian, jieshu - zhongdian);

    for i = 1:min_val
        line_s1(i) = Line(2*(i-1)+1);
    end
    for i = 1:min_val
        line_s2(i) = Line(2*i);
    end

    if zhongdian > jieshu - zhongdian
        line_s1(min_val+1:zhongdian) = Line(2*min_val+1:jieshu);
    else
        line_s2(min_val+1:jieshu-zhongdian) = Line(2*min_val+1:jieshu);
    end

    line_s1 = fliplr(line_s1);
    Line1 = horzcat(line_s1, line_s2);
    Line1 = uint8(Line1);
end

function [img] = New_Saomiao_Jiemi(Line, n)
% Initialize img with zeros
img = zeros(n, n);

% Reconstruct Line1, Line2, and Line3 from Line
len_line1 = (n*n - n) / 2;
len_line2 = n;


Line1 = Line(1:len_line1);
Line2 = Line(len_line1 + 1:len_line1 + len_line2);
Line3 = Line(len_line1 + len_line2 + 1:end);

% Reconstruct Line1

for i = 1:(n-2)/2 + 1
    for j = 1:4*(i-1) + 1
        x = (n - 2*(i-1) + floor(j/2));
        y = 2 + floor((j-1)/4) * 2 - mod(j, 2);
        img(x, y) = Line1( (4*(i-1)-2)*(i-1)/2 +j);
    end
end

% Reconstruct Line2

for i = 1:n
    img(i,i) = Line2(i);

end

% Reconstruct Line3
k = 1;
for i = (n-2)/2 + 1:-1:1
    for j = 1:4*(i-1) + 1
        y = (n - 2*(i-1) + floor(j/2));
        x = 2 + floor((j-1)/4) * 2 - mod(j, 2);
        img(x, y) = Line3(k);
        k = k + 1;
    end
end

end

function y = Mod_4_xiangxia(j)
    y = floor((j-1)/4);
end

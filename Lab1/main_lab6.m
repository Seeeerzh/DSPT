clear all; clc; close all;
%% training images
A1 = imread('images/apple_04.jpg');
A2 = imread('images/apple_05.jpg');
A3 = imread('images/apple_06.jpg');
A4 = imread('images/apple_07.jpg');

P1 = imread('images/pear_01.jpg');
P2 = imread('images/pear_02.jpg');

E1 = imread('images/pepper_01.jpg');
E2 = imread('images/pepper_02.jpg');
E3 = imread('images/pepper_03.jpg');

%% testing images
A5 = imread('images/apple_11.jpg');
A6 = imread('images/apple_12.jpg');
A7 = imread('images/apple_13.jpg');
A8 = imread('images/apple_17.jpg');
A9 = imread('images/apple_19.jpg');

P3 = imread('images/pear_03.jpg');
P4 = imread('images/pear_09.jpg');

E4 = imread('images/pepper_04.jpg');
E5 = imread('images/pepper_05.jpg');
E6 = imread('images/pepper_06.jpg');
E7 = imread('images/pepper_07.jpg');
%% roundness 
threshold = 0.08; % threshold for image conversion to black/white image
% images for training
[roundness_1,bw_1]=apvalumas_roundness(A1,threshold);
[roundness_2,bw_2]=apvalumas_roundness(A2,threshold);
[roundness_3,bw_3]=apvalumas_roundness(A3,threshold);
[roundness_6,bw_6]=apvalumas_roundness(A4,threshold);

[roundness_4,bw_4]=apvalumas_roundness(P1,threshold);
[roundness_5,bw_5]=apvalumas_roundness(P2,threshold);

[roundness_14,bw_14]=apvalumas_roundness(E1,threshold);
[roundness_15,bw_15]=apvalumas_roundness(E2,threshold);
[roundness_16,bw_16]=apvalumas_roundness(E3,threshold);

% for testing
[roundness_7,bw_7]=apvalumas_roundness(A5,threshold);
[roundness_8,bw_8]=apvalumas_roundness(A6,threshold);
[roundness_9,bw_9]=apvalumas_roundness(A7,threshold);
[roundness_10,bw_10]=apvalumas_roundness(A8,threshold);
[roundness_11,bw_11]=apvalumas_roundness(A9,threshold);

[roundness_12,bw_12]=apvalumas_roundness(P3,threshold);
[roundness_13,bw_13]=apvalumas_roundness(P4,threshold);

[roundness_17,bw_17]=apvalumas_roundness(E4,threshold);
[roundness_18,bw_18]=apvalumas_roundness(E5,threshold);
[roundness_19,bw_19]=apvalumas_roundness(E6,threshold);
[roundness_20,bw_20]=apvalumas_roundness(E7,threshold);
%% color extraction
% training
hsv_value1=spalva_color(A1,bw_1);
hsv_value2=spalva_color(A2,bw_2);
hsv_value3=spalva_color(A3,bw_3);
hsv_value6=spalva_color(A4,bw_6);

hsv_value4=spalva_color(P1,bw_4);
hsv_value5=spalva_color(P2,bw_5);

hsv_value14=spalva_color(E1,bw_14);
hsv_value15=spalva_color(E2,bw_15);
hsv_value16=spalva_color(E3,bw_16);

% testing
hsv_value7=spalva_color(A5,bw_7);
hsv_value8=spalva_color(A6,bw_8);
hsv_value9=spalva_color(A7,bw_9);
hsv_value10=spalva_color(A8,bw_10);
hsv_value11=spalva_color(A9,bw_11);

hsv_value12=spalva_color(P3,bw_12);
hsv_value13=spalva_color(P4,bw_13);

hsv_value17=spalva_color(E4,bw_17);
hsv_value18=spalva_color(E5,bw_18);
hsv_value19=spalva_color(E6,bw_19);
hsv_value20=spalva_color(E7,bw_20);
%% features 2x5
% for training
x_1 = [roundness_1 roundness_2 roundness_3 roundness_6 roundness_4 roundness_5 roundness_14 roundness_15 roundness_16];
x_2 = [hsv_value1 hsv_value2 hsv_value3 hsv_value6 hsv_value4 hsv_value5 hsv_value14 hsv_value15 hsv_value16];
% for testing
z_1 = [ roundness_7 roundness_8 roundness_9 roundness_10 roundness_11 roundness_12 roundness_13 roundness_17 roundness_18 roundness_19 roundness_20];
z_2 = [ hsv_value7 hsv_value8 hsv_value9 hsv_value10 hsv_value11 hsv_value12 hsv_value13 hsv_value17 hsv_value18 hsv_value19 hsv_value20];

x12=cat(1,x_1,x_2); % for training
z12=cat(1,z_1,z_2); % for testing
% T = [0 0 0 0 1 1]; % target function, what we need to get on the output of perceptron
% T2= [0 0 0 0 0 1 1];
T = [1 1 1 1 0 0 0 0 0; 0 0 0 0 1 1 0 0 0; 0 0 0 0 0 0 1 1 1]; % target function, what we need to get on the output of perceptron
T2= [1 1 1 1 1 0 0 0 0 0 0; 0 0 0 0 0 1 1 0 0 0 0; 0 0 0 0 0 0 0 1 1 1 1];
%% initialization of perceptron
net = perceptron;
% net = newp([0 1; 0 1],1);
% net = init(net); % Initialisation of weight and bias values
net.trainParam.epochs = 1000;
net.trainParam.goal = 0.0001;
%% training
net = train(net, x12, T);
%% Network is tested on training examples
Y1 = sim(net, x12); % for trained net Y should be equal to T
%% Unknown examples are classified
Y2 = sim(net, z12);

%% Display features on 2D plot
figure(1);
plot(x_1(1:4),x_2(1:4),'*r'); grid on; xlim([0 1]); ylim([0 1]);
xlabel('Apvalumas'); ylabel('Spalva'); title('Požymių erdvė');
hold on;
plot(x_1(5:6),x_2(5:6),'sg');
plot(x_1(7:9),x_2(7:9),'sb'); %legend apples_t pears_t pepper_t

plot(z_1(1:5),z_2(1:5),'*k');
plot(z_1(6:7),z_2(6:7),'sk'); 
%plot(z_1(7:9),z_2(7:9),'sk'); 
legend({'apples_t','pears_t','pepper_t','apples_s','pears_s','pepper_s'},'Location','northwest')
% legend apples_t pears_t pepper_t apples_s pears_s pepper_s;




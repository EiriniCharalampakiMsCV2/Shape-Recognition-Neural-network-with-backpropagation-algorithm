%  preparation and simulation

Num_Inputs=10 ;% number of rows for one shape
P=zeros(Num_Inputs,9);% input matrix
T=zeros(3,9);

for h=1:9 % cases for 9 images
    switch h
        % the first three cases are rectangular,
       case 1
          Img = imread('t1.bmp');
          Target=[1;-1;-1] ;
       case 2 
          Img = imread('t2.bmp');
          Target=[1;-1;-1] ;
       case 3
           Img = imread('t3.bmp');
           Target=[1;-1;-1] ;
           %the second three cases are triangular,
       case 4
           Img = imread('r1.bmp');
           Target=[-1;1;-1] ;
       case 5
           Img = imread('r2.bmp');
           Target=[-1;1;-1];
       case 6
           Img = imread('r3.bmp');
           Target=[-1;1;-1];
           % the third three cases are circula
       case 7
           Img = imread('c1.bmp');
           Target=[-1;-1;1];
       case 8
           Img = imread('c2.bmp');
           Target=[-1;-1;1];
       case 9
           Img = imread('c3.bmp');
           Target=[-1;-1;1];
    end 
    
    T(:,h)=Target ; % filler matrix T

[Num_Row,Num_column] = size(Img) ;% define the size of the image
           for i=1:Num_Inputs
                     for j=(((Num_Row/Num_Inputs)*(i-1))+1) : ((Num_Row/Num_Inputs)*(i))
                          for k=1 : Num_column
                             if Img(j,k)==0
                             P(i,h)=P(i,h)+k ;
                             end
                           end
                     end
           end
end 



S=zeros(Num_Inputs,3);%matrix simulation

for h=1:3 % 3 cases for 3 images
    switch h
       case 1
          Img = imread('t4.bmp');
          
       case 2
           Img = imread('r4.bmp');
           
        case 3
           Img = imread('c4.bmp');
           
    end %fin switch 

[Num_Row,Num_column] = size(Img) ;
% initiation for input matrix
           for i=1:Num_Inputs
                     for j=(((Num_Row/Num_Inputs)*(i-1))+1) : ((Num_Row/Num_Inputs)*(i))
                          for k=1 : Num_column
                             if Img(j,k)==0
                             S(i,h)=S(i,h)+k ;
                             end
                           end
                     end
           end
end 

%Standardization of Matrices
A=[P,S] ;
maxi=max(max(A));
mini=min(min(A));
[a,b]=size(A);
for i=1:a
    for j=1:b
        AN(i,j)=2*(A(i,j)/(maxi-mini))-1;
    end
end

P=AN(:,1:9);
S=AN(:,10:12) ;

%the code of simulation

Num_Neuron_Hidden=20 ;% hidden layer contains 20
%create a feedforward backpropagation network
net = newff(P,T,Num_Neuron_Hidden,{},'traingd');% Num_Neuron_Hidden = 10
net=init(net); % rare the weight and the bias
net.trainparam.epochs=250;% muximum number iteration
net.trainparam.goal=0.0001; % error in respect
net=train(net,P,T); % launch of learning


 
% étape de Simulation 
y = sim(net,S);
% fin simulation

k=3;






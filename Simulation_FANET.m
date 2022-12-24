clc;
clear all;
close all;
%% Title: FANET Implementation with Code Optimization in MATLAB
% This algorithm is based on Routing Protocol AODV and DSR following IEEE
% 802.11a protocol communication standard.
%Routing is a process of establishing a path between sender and reciever
%nodes for transmitting the packets along the path.
% The function of Routing protocol is to find the optimum path for
% effective communication between nodes.
% In this algorithm I have created Image View for Mobile Ad-hoc Network
% Here I have created Image View with smart antenna and omni directional
% antenna. While running this algorithm , it will prompt the user for input
% armunrts window screen as given below:
% Enter Number of Nodes in Network => 
% Enter width of Area over which network should be employed =>
% Enter length of Area over which network should be employed =>
% Enter Effective Apperature of Antenna =>
% Enter Gain of Antenna =>
% Suitabble parameters are intitioally one should try with are as follow:
% number of nodes = 25 and for area width*length should be atleast 500*500
% Apperture of Antenna as 20 and Gain as 1000 as estimated values
% Antenna parameter may vary according to your requirement. Once you run
% This code after complete execution of the code you can do some
% calculations related to power of transmittion or reception. by using
% formulla 
%         A*G
% Pr = -------- Pt      .....(1)
%      4*pi*r^2
% Here  Pr = Receive power by receiver Antenna
%       Pt = Transmitted Power by Antenna
%       A = Effictive Apperature area of Antenna
%       G = Gain of Antenna
%       r = distance between transmitting and receiving antenna
% You can find that all these values are stored in varaible avalaible in
% work space as A for Effective Apperature, G for Gain, R for distance
% and for Pt you should make consideration for your scenario.
% this value for network will vary according to number of hop count you can
% find hop count as variable hop_count and for total power of network you
% can multiply hop_cout with Power, in case you have received power then 
%you can do analysis for transmitted power by using eq(1). One can also do
%analysis of network by varing range of antenna by changing the value of R.
%% Defining Mobile Ad-hoc Network  and Antenna Parameters
tic
num_node = input('Enter Number Of Nodes in Network =>'); 
Pt = input('Enter Transmitted Power of Antenna =>'); 
%Define Number of Nodes
x_len = input('Enter Width of Area Over which network should be employed =>');  %Define Width of Area
y_len = input('Enter Length of Area Over which network should be employed =>'); %Define Length of Area
A = input('Enter Effective Apperature of Antenna =>');
G = input('Enter gain of Antenna =>');
psize= input('Enter Packersize of Antenna =>');
chk = (~isnumeric(num_node)||~isnumeric(x_len)||~isnumeric(y_len));             %Checking Input values
if(chk == 1)
    eid = sprintf('Images:%s:wrongTypeOfInputArgument',mfilename);
    msg = 'Wrong Type of inputs for ''Number of Nodes';
    error(eid,'%s',msg);
end
f=60;
bw=2*pi*f;
fprintf('25 used:%d',bw);
% c=newline;
x_cord = fix(x_len*rand(1,num_node));                                           %Randomly Define Cordinate of X-axies of each Nodes
y_cord = fix(y_len*rand(1,num_node));                                           %Randomly Define Cordinate of X-axies of each Nodes
for m = 1:num_node
    if(x_cord(m)==0)
        x_cord(m)=1;
    end
    if(y_cord(m)==0)
        y_cord(m)=1;
    end
end
ground = ones(x_len,y_len);
figure
imshow(ground)
title('2-D view of Area over which FANET Network based on IEEE 802.11a')

%% Creating View of Network with nodes and with Omnidiractional Antenna
for k=1:num_node
    ground(x_cord(k):x_cord(k)+2,y_cord(k):y_cord(k)+2) = 0;
end
figure
imshow(ground)
title('Simulation area with FANET Nodes appers in black Color')
%% Introducing Beacon Node as a Reference in FANET 
BorderLength=100;
NodeAmount=50;
BeaconAmount=1;
UNAmount=NodeAmount-BeaconAmount;
R=100;
h=zeros(NodeAmount,NodeAmount);  %The initial number of hops is 0; BeaconAmount row, NodeAmount column
X=zeros(2,UNAmount);%Estimated initial node coordinate matrix
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Generating uniformly distributed random topology within the square area~~~~~~~~~~~~~~~~~~~~
C=BorderLength.*rand(2,NodeAmount);%Coordinate of all nodes
Sxy=[[1:NodeAmount];C];
Beacon=[Sxy(2,1:BeaconAmount);Sxy(3,1:BeaconAmount)];%Beacon nodes coordinate
UN=[Sxy(2,(BeaconAmount+1):NodeAmount);Sxy(3,(BeaconAmount+1):NodeAmount)];%Unknown node coordinates
%Draw node distribution
figure
plot(Sxy(2,1:BeaconAmount),Sxy(3,1:BeaconAmount),'r*',Sxy(2,(BeaconAmount+1):NodeAmount),Sxy(3,(BeaconAmount+1):NodeAmount),'k.');
xlim([0,BorderLength]);
ylim([0,BorderLength]);%Limitations of the area
title('* Red beacon nodes . Black FANET nodes')
R=50;
thita = linspace(0,2*pi,20);
figure
imshow(ground)
title('uniformly distributed random topology within the square area')
%creating network with omnidiractional antenna
for l = 1:num_node
    x_lcord = fix(x_cord(l)+(R*cos(thita)));
    y_lcord = fix(y_cord(l)+(R*sin(thita)));
    line(y_lcord,x_lcord)
end

%% Selection of transmitter and receiver and establising Communication
%randomly selection of Transmitter and Receiver
tr = fix(num_node*rand(1,1));
temp_tr = tr;
rx = fix(num_node*rand(1,1));
if (tr==rx);
    tr = tr+1;
end
figure
imshow(ground)
title('FANET Nodes With Omnidirection radiation Pattern (Flooding Case)')
XY = [x_cord',y_cord'];
hop_count = 0;
%Establising Communication Between Transmitter and Receiver 
hopstats1=[];
propDelay1=[];
trs1=[];
pr1=[];
lp1=[];
throughput1=[]
for k=1:numel(x_cord) 
    if(tr~=rx)
        indx = find(XY(:,1)==x_cord(tr));
        XY(indx,:)=[];
        tr_matrix = repmat([x_cord(tr),y_cord(tr)],size(XY,1),1);
        distance_matrix = sqrt((tr_matrix(:,1)-XY(:,1)).^2+(tr_matrix(:,2)-XY(:,2)).^2);
        min_distance_matrix = min(distance_matrix);
        index_for_mindist = find(distance_matrix==min_distance_matrix);
        index_for_next_tr_x = find(x_cord==XY(index_for_mindist,1));
        index_for_next_tr_y = find(y_cord==XY(index_for_mindist,2));
        if(index_for_next_tr_x==index_for_next_tr_y)
            line([y_cord(tr),y_cord(index_for_next_tr_y)],[x_cord(tr),x_cord(index_for_next_tr_x)]);
            x_lcord = fix(x_cord(tr)+(R*cos(thita)));
            y_lcord = fix(y_cord(tr)+(R*sin(thita)));
            line(y_lcord,x_lcord)
            temp=line(y_lcord,x_lcord)
            tr = index_for_next_tr_x;
            r=min_distance_matrix;
            Pr=calculatetransmissionpower(A,G,Pt,r)
            Lp = calculatepathloss(Pr,Pt);
            lp1(end+1) =Lp;
            pr1(end+1) =Pr;
            hopstats1(end+1) = hop_count;
            propDelay1(end+1) = r/ (3*10^8);
            TransmissionTime=psize/bw;
            PropagationTime = r /(3*10^8);
            QueuingTime=0.4;
            ProcessingDelay=0.4;
            Latency = PropagationTime + TransmissionTime + QueuingTime + ProcessingDelay;
            framesize=psize*8;
            rounttriptime=Latency+(framesize/1024000);
            throughput=(7*framesize)/rounttriptime;
            throughput1(end+1)=throughput;
            trs1(end+1)=Latency;
            hop_count=hop_count+1;
        end
    else
        break
    end
end
x_lcord = fix(x_cord(tr)+(R*cos(thita)));
y_lcord = fix(y_cord(tr)+(R*sin(thita)));
line(y_lcord,x_lcord)
if(hop_count==0)
    line([y_cord(tr),y_cord(rx)],[x_cord(tr),x_cord(rx)])
end
%% Creating Network With Smart Antenna
thita1 = linspace(0,pi/8,20);
thita2 = linspace((pi/8)+(pi/64),2*pi/8,20);
thita3 = linspace((2*pi/8)+(pi/64),4*pi/8,20);
thita4 = linspace((4*pi/8)+(pi/64),6*pi/8,20);
thita5 = linspace((6*pi/8)+(pi/64),8*pi/8,20);
thita6 = linspace((8*pi/8)+(pi/64),10*pi/8,20);
thita7 = linspace((10*pi/8)+(pi/64),12*pi/8,20);
thita8 = linspace((12*pi/8)+(pi/64),14*pi/8,20);
thita9 = linspace((14*pi/8)+(pi/64),16*pi/8,20);
figure
imshow(ground)
title('Active Communication establishing among FANET Nodes using AODV');
%creating network with omnidiractional antenna
for l = 1:num_node
    x_lcord1 = fix(x_cord(l)+(R*cos(thita1)));
    x_lcord2 = fix(x_cord(l)+(R*cos(thita2)));
    x_lcord3 = fix(x_cord(l)+(R*cos(thita3)));
    x_lcord4 = fix(x_cord(l)+(R*cos(thita4)));
    x_lcord5 = fix(x_cord(l)+(R*cos(thita5)));
    x_lcord6 = fix(x_cord(l)+(R*cos(thita6)));
    x_lcord7 = fix(x_cord(l)+(R*cos(thita7)));
    x_lcord8 = fix(x_cord(l)+(R*cos(thita8)));
    x_lcord9 = fix(x_cord(l)+(R*cos(thita9)));
    y_lcord1 = fix(y_cord(l)+(R*sin(thita1)));
    y_lcord2 = fix(y_cord(l)+(R*sin(thita2)));
    y_lcord3 = fix(y_cord(l)+(R*sin(thita3)));
    y_lcord4 = fix(y_cord(l)+(R*sin(thita4)));
    y_lcord5 = fix(y_cord(l)+(R*sin(thita5)));
    y_lcord6 = fix(y_cord(l)+(R*sin(thita6)));
    y_lcord7 = fix(y_cord(l)+(R*sin(thita7)));
    y_lcord8 = fix(y_cord(l)+(R*sin(thita8)));
    y_lcord9 = fix(y_cord(l)+(R*sin(thita9)));
    line([y_cord(l),y_lcord1,y_cord(l)],[x_cord(l),x_lcord1,x_cord(l)])
    line([y_cord(l),y_lcord2,y_cord(l)],[x_cord(l),x_lcord2,x_cord(l)])
    line([y_cord(l),y_lcord3,y_cord(l)],[x_cord(l),x_lcord3,x_cord(l)])
    line([y_cord(l),y_lcord4,y_cord(l)],[x_cord(l),x_lcord4,x_cord(l)])
    line([y_cord(l),y_lcord5,y_cord(l)],[x_cord(l),x_lcord5,x_cord(l)])
    line([y_cord(l),y_lcord6,y_cord(l)],[x_cord(l),x_lcord6,x_cord(l)])
    line([y_cord(l),y_lcord7,y_cord(l)],[x_cord(l),x_lcord7,x_cord(l)])
    line([y_cord(l),y_lcord8,y_cord(l)],[x_cord(l),x_lcord8,x_cord(l)])
    line([y_cord(l),y_lcord9,y_cord(l)],[x_cord(l),x_lcord9,x_cord(l)])
end
%% Establising Communication Between Transmitter and Receiver
tr = temp_tr;
figure
imshow(ground)
title('Active Communication established among FANET Nodes using AODV')
XY = [x_cord',y_cord'];
hopstats2=[];
propDelay2=[];
new_thita1=[];
pr2=[];
trs2=[];
lp2=[];
throughput2=[];
hop_count = 0; 
new_angle = 0;
for k=1:numel(x_cord) 
    if(tr~=rx)
        indx = find(XY(:,1)==x_cord(tr));
        XY(indx,:)=[];
        tr_matrix = repmat([x_cord(tr),y_cord(tr)],size(XY,1),1);
        distance_matrix = sqrt((tr_matrix(:,1)-XY(:,1)).^2+(tr_matrix(:,2)-XY(:,2)).^2);
        min_distance_matrix = min(distance_matrix);
        index_for_mindist = find(distance_matrix==min_distance_matrix);
        index_for_next_tr_x = find(x_cord==XY(index_for_mindist,1));
        index_for_next_tr_y = find(y_cord==XY(index_for_mindist,2));
        if(index_for_next_tr_x==index_for_next_tr_y)
            line([y_cord(tr),y_cord(index_for_next_tr_y)],[x_cord(tr),x_cord(index_for_next_tr_x)]);
            new_angle = atan((y_cord(index_for_next_tr_y)-y_cord(tr))/(x_cord(index_for_next_tr_x)-x_cord(tr)));
            new_thita = linspace((new_angle-(pi/16)),(new_angle+(pi/16)),20);
            x_lcord = fix(x_cord(tr)+(R*cos(new_thita)));
            y_lcord = fix(y_cord(tr)+(R*sin(new_thita)));
            line([y_cord(tr),y_lcord,y_cord(tr)],[x_cord(tr),x_lcord,x_cord(tr)])
            tr = index_for_next_tr_x;
            r=min_distance_matrix;
            Pr=calculatetransmissionpower(A,G,Pt,r)
            Lp = calculatepathloss(Pr,Pt);
            lp2(end+1) =Lp;
            pr2(end+1) =Pr;
            hopstats2(end+1) = hop_count;
            propDelay2(end+1) = min_distance_matrix / (3*10^8);
            %new_thita1(end+1)=new_thita;
            TransmissionTime=psize/bw;
            PropagationTime = r /(3*10^8);
            QueuingTime=0.3;
            ProcessingDelay=0.3;
            Latency = PropagationTime + TransmissionTime + QueuingTime + ProcessingDelay;
            framesize=psize*8;
            rounttriptime=Latency+(framesize/1024000);
            throughput=(7*framesize)/rounttriptime;
            throughput2(end+1)=throughput;
            trs2(end+1,:)=Latency;
            hop_count=hop_count+1;
        end
    else
        break
    end
end
if(hop_count==0)
    line([y_cord(tr),y_cord(rx)],[x_cord(tr),x_cord(rx)])
end
new_angle = pi-new_angle;
new_thita = linspace((new_angle-(pi/16)),(new_angle+(pi/16)),20);
x_lcord = fix(x_cord(tr)+(R*cos(new_thita)));
y_lcord = fix(y_cord(tr)+(R*sin(new_thita)));
line([y_cord(tr),y_lcord,y_cord(tr)],[x_cord(tr),x_lcord,x_cord(tr)])
%% Establising Communication Between Transmitter and Receiver

tr = temp_tr;
hopstats3=[];
propDelay3=[];
new_thita2=[];
pr3=[];
trs3=[];
lp3=[];
throughput3=[];
figure
imshow(ground)
title('Active Communication establishing among FANET Nodes Using DSR')
XY = [x_cord',y_cord'];
hop_count = 0; 
for k=1:numel(x_cord) 
    if(tr~=rx)
        indx = find(XY(:,1)==x_cord(tr));
        XY(indx,:)=[];
        tr_matrix = repmat([x_cord(tr),y_cord(tr)],size(XY,1),1);
        distance_matrix = sqrt((tr_matrix(:,1)-XY(:,1)).^2+(tr_matrix(:,2)-XY(:,2)).^2);
        min_distance_matrix = min(distance_matrix);
        index_for_mindist = find(distance_matrix==min_distance_matrix);
        index_for_next_tr_x = find(x_cord==XY(index_for_mindist,1));
        index_for_next_tr_y = find(y_cord==XY(index_for_mindist,2));
        if(index_for_next_tr_x==index_for_next_tr_y)
            line([y_cord(tr),y_cord(index_for_next_tr_y)],[x_cord(tr),x_cord(index_for_next_tr_x)]);
            new_angle = atan((y_cord(index_for_next_tr_y)-y_cord(tr))/(x_cord(index_for_next_tr_x)-x_cord(tr)));
            anti_new_angle = pi+new_angle;
            new_thita = linspace((new_angle-(pi/16)),(new_angle+(pi/16)),20);
            anti_new_thita = linspace((anti_new_angle-(pi/16)),(anti_new_angle+(pi/16)),20);
            x_lcord = fix(x_cord(tr)+(R*cos(new_thita)));
            anti_x_lcord = fix(x_cord(tr)+(R*cos(anti_new_thita)));
            y_lcord = fix(y_cord(tr)+(R*sin(new_thita)));
            anti_y_lcord = fix(y_cord(tr)+(R*sin(anti_new_thita)));
            line([y_cord(tr),y_lcord,y_cord(tr),y_cord(tr),anti_y_lcord,y_cord(tr)],[x_cord(tr),x_lcord,x_cord(tr),x_cord(tr),anti_x_lcord,x_cord(tr)])
            tr = index_for_next_tr_x;
            r=min_distance_matrix;
            Pr=calculatetransmissionpower(A,G,Pt,r);
            Lp = calculatepathloss(Pr,Pt);
            lp3(end+1) =Lp;
            pr3(end+1) =Pr;
            hopstats3(end+1) = hop_count;
            propDelay3(end+1) = min_distance_matrix / (3*10^8);
            %new_thita2(end+1)=new_thita;
            TransmissionTime=psize/bw;
            PropagationTime = r /(3*10^8);
            QueuingTime=0.2;
            ProcessingDelay=0.2;
            Latency = PropagationTime + TransmissionTime + QueuingTime + ProcessingDelay;
            framesize=psize*8;
            rounttriptime=Latency+(framesize/1024000);
            throughput=(7*framesize)/rounttriptime;
            throughput3(end+1)=throughput;
            trs3(end+1,:)=Latency;
            hop_count=hop_count+1;
        end
    else
        break
    end
end
if(hop_count==0)
    line([y_cord(tr),y_cord(rx)],[x_cord(tr),x_cord(rx)])
end
new_angle = pi-new_angle;
new_thita = linspace((new_angle-(pi/16)),(new_angle+(pi/16)),20);
x_lcord = fix(x_cord(tr)+(R*cos(new_thita)));
y_lcord = fix(y_cord(tr)+(R*sin(new_thita)));
line([y_cord(tr),y_lcord,y_cord(tr)],[x_cord(tr),x_lcord,x_cord(tr)])
plotHops(hopstats1)
plotPropDelay(propDelay1)
plotTransmissions(trs1,throughput1)
plotpower(pr1)
plotpathloss(lp1)
plotHops(hopstats2)
plotPropDelay(propDelay2)
plotTransmissions(trs2,throughput2)
plotpower(pr2)
plotpathloss(lp2)
plotHops(hopstats3)
plotPropDelay(propDelay3)
plotTransmissions(trs3,throughput3)
plotpower(pr3)
plotpathloss(lp3)
plotHopscomparison(hopstats1,hopstats2,hopstats3)
plotPropDelaycomparison(propDelay1,propDelay2,propDelay3)
plotTransmissionscomparison(trs1,trs2,trs3,throughput1,throughput2,throughput3)
plotpowercomparison(pr1,pr2,pr3)
plotpathlosscomparison(lp1,lp2,lp3)
toc



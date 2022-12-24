function plotTransmissionscomparison(Latency1,Latency2,Latency3,thr1,thr2,thr3)

    % Bring globals into scope
    global colors;
    
    % Close any old figures containing stats
    %openFigs = get(groot, 'Children');
    %a=openFigs.Name
    %idxs = find(strcmp(a,'Traffic Statistics'));
    %delete(openFigs(idxs));
    
    % Create new figure
    figure
    % Plot stats data
    %hold all
    %for field = fieldnames(stats.Latency)'
    %    field = char(field);
    myTimes1=minutes(1:length(transpose(Latency1));
myTimes2=minutes(1:length(Latency2));
myTimes3=minutes(1:length(Latency3));
    plot(myTimes1,Latency1,myTimes2,Latency2,myTimes3,Latency3)
    
    %end
    
    % Format graph
    %legend(fieldnames(stats),'Location','northwest')
    title('Traffic Statistics comparison')
    ylabel('Node-to-node Latency')
    xlabel('Latency')
    legend({'Latency before xoring','Latency after xoring with AODV'},'Latency after xoring with DSR')
% Create new figure
    figure
    % Plot stats data
    %hold all
    %for field = fieldnames(stats.Latency)'
    %    field = char(field);
myTimes1=minutes(1:length(thr1));
myTimes2=minutes(1:length(thr2));
myTimes3=minutes(1:length(thr3));
    plot(myTimes1,thr1,myTimes2,thr2,myTimes3,thr3)
    
    %end
    
    % Format graph
    %legend(fieldnames(stats),'Location','northwest')
    title('Traffic Statistics comparison')
    ylabel('Node-to-node Latency')
    xlabel('Throughput')
    legend({'Throughput before xoring','Throughput after xoring with AODV'},'Throughput after xoring with DSR')

end


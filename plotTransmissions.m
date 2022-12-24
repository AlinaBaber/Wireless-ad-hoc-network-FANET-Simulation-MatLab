function plotTransmissions(Latency,thr)

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
    %for field = fieldnames(stats.transmissions)'
    %    field = char(field);
    myTimes1=minutes(1:length(Latency));
    plot(myTimes1,Latency)
    %end
    
    % Format graph
    %legend(fieldnames(stats),'Location','northwest')
    title('Latency')
    ylabel('Node-to-node Transmissions')
    xlabel('Latency')
        % Create new figure
    myTimes1=minutes(1:length(thr));
    figure
    
    % Plot stats data
    %for field = fieldnames(stats.transmissions)'
    %    field = char(field);
    plot(myTimes1,thr)
    %end
    
    % Format graph
    %legend(fieldnames(stats),'Location','northwest')
    title('Throughput')
    ylabel('Node-to-node Transmissions')
    xlabel('Throughput')
end


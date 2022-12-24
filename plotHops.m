function plotHops(stats)

    % Bring globals into scope
    global colors;
    
    
    % Close any old figures containing stats
    %openFigs = get(groot, 'Children');
    %a=openFigs.Name
    %idxs = find(strcmp(a,'Number of Hops'));
    %delete(openFigs(idxs));
    
    % Create new figure
    values=[];      
    % Count occurrances
    %for i = 1:max(stats)
    %    values(i) = sum(stats == i);
        %print(str(i))
        %labels(i) = string(num2str(i) + 'Hops');
   % end
   % lim = length(values);           
    % Plot data
    %figure,title('Number of Hops during Establising Communication Between Transmitter and Receiver ');
    %values = values(1:lim);
    figure
     myTimes1=minutes(1:length(stats));
    plot(myTimes1,stats)
    title('Number of Hops during Establising Communication Between Transmitter and Receiver')
    %text(1:length(values),values,num2str(values'),'vert','bottom','horiz','center'); 
    
    % Format plot
    xlabel('Number of Hops in total')
    ylabel('Packets')
    
end
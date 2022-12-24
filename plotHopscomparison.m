function [fig] = plotHopscomparison(stats1,stats2,stats3)

    % Bring globals into scope
    global colors;
    
    
    % Close any old figures containing stats
    %openFigs = get(groot, 'Children');
    %a=openFigs.Name
    %idxs = find(strcmp(a,'Number of Hops'));
    %delete(openFigs(idxs));
    
    % Create new figure
    values1=[];      
    % Count occurrances
    for i = 1:max(stats1)
        values(i) = sum(stats1 == i);
        %print(str(i))
        %labels(i) = string(num2str(i) + 'Hops');
    end
    values2=[];      
    % Count occurrances
    for i = 1:max(stats2)
        values(i) = sum(stats2 == i);
        %print(str(i))
        %labels(i) = string(num2str(i) + 'Hops');
    end
    values3=[];      
    % Count occurrances
    for i = 1:max(stats3)
        values(i) = sum(stats3 == i);
        %print(str(i))
        %labels(i) = string(num2str(i) + 'Hops');
    end
    lim1 = length(values1);    
    lim2 = length(values2); 
    lim3 = length(values3); 
    % Plot data
    %figure,title('Number of Hops during Establising Communication Between Transmitter and Receiver ');
    values1 = values1(1:lim1);
    values2 = values2(1:lim2);
    values3 = values3(1:lim3);
    %plot(1:length(bhat),bhat,1:length(btilda),btilda)
    figure,
      myTimes1=minutes(1:length(stats1));
myTimes2=minutes(1:length(stats2));
myTimes3=minutes(1:length(stats3));  
    plot(myTimes1,stats1,myTimes2,stats2,myTimes3,stats3)
    %text(1:length(values),values,num2str(values'),'vert','bottom','horiz','center'); 
    
    % Format plot
    title('Number of Hops comparison')
    legend({'Hops before xoring','hops after xoring with AODV'},'Hops after xoring')
    xlabel('Number of Hops in total')
    ylabel('Packets')
    hold off
end
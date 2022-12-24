function plotPropDelaycomparison(propDelay1,propDelay2,propDelay3)

    % Bring globals into scope
    global colors;
    
    % Close any old figures containing stats
    %openFigs = get(groot, 'Children');
    %a=openFigs.Name
    %idxs = find(strcmp(a,'Propagation Delay'));
    %delete(openFigs(idxs));
    
    % Create new figure
    figure, title('Propagation Delay comparison')
             
    % Plot data
myTimes1=minutes(1:length(propDelay1));
myTimes2=minutes(1:length(propDelay2));
myTimes3=minutes(1:length(propDelay3));
    plot(myTimes1,propDelay1,myTimes2,propDelay2,myTimes3,propDelay3)
    
    % Format plot
    xlabel('Data Packet')
    %ylim([0,2.5])
    ylabel('Delay (in ns)')
    legend({'Propagation Delay before xoring','Propagation Delay after xoring with AODV'},'Propagation Delay after xoring with DSR')
    hold off
end
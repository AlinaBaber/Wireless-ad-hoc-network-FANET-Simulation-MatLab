function plotpathlosscomparison(lp1,lp2,lp3)

    % Bring globals into scope
    global colors;
    
    % Close any old figures containing stats
    %openFigs = get(groot, 'Children');
    %a=openFigs.Name
    %idxs = find(strcmp(a,'Propagation Delay'));
    %delete(openFigs(idxs));
    
    % Create new figure
    
             
    % Plot data
    myTimes1=minutes(1:length(lp1));
myTimes2=minutes(1:length(lp2));
myTimes3=minutes(1:length(lp3));
    figure
    plot(myTimes1,lp1,myTimes2,lp2,myTimes3,lp3);
    
    % Format plot
    xlabel('Time')
    %ylim([0,2.5])
    ylabel('Lp Path loss')
    title('Path loss comparison between Pr and Pt');
    legend({'Lp before xoring','Lp after xoring with AODV'},'Lp after xoring with DSR')

    hold off
end
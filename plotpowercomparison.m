function plotpowercomparison(pr1,pr2,pr3)

    % Bring globals into scope
    global colors;
    
    % Close any old figures containing stats
    %openFigs = get(groot, 'Children');
    %a=openFigs.Name
    %idxs = find(strcmp(a,'Propagation Delay'));
    %delete(openFigs(idxs));
    
    % Create new figure
    
             
    % Plot data
    myTimes1=minutes(1:length(pr1));
myTimes2=minutes(1:length(pr2));
myTimes3=minutes(1:length(pr3));
    figure
    plot(myTimes1,pr1,myTimes2,pr2,myTimes3,pr3);
    % Format plot
    xlabel('Time')
    %ylim([0,2.5])
    ylabel('Pr Recieved Power')
    title('Pr Recieved Power comparison');
    legend({'Pr before xoring','Pr after xoring with AODV'},'Pr after xoring with DSR')

    hold off
end
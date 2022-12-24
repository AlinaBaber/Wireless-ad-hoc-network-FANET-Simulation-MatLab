function plotpathloss(lp)

    % Bring globals into scope
    global colors;
    
    % Close any old figures containing stats
    %openFigs = get(groot, 'Children');
    %a=openFigs.Name
    %idxs = find(strcmp(a,'Propagation Delay'));
    %delete(openFigs(idxs));
    
    % Create new figure
    
             
    % Plot data
    figure
    myTimes1=minutes(1:length(lp));
    plot(myTimes1)
    % Format plot
    xlabel('Time')
    %ylim([0,2.5])
    ylabel('Lp Path loss')
    title('Path loss between Pr and Pt');
    hold off
end
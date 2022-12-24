function plotthitacomparison(thita1,thita2,thita3)

    % Bring globals into scope
    %global colors;
    
    % Close any old figures containing stats
    %openFigs = get(groot, 'Children');
    %a=openFigs.Name
    %idxs = find(strcmp(a,'Propagation Delay'));
    %delete(openFigs(idxs));
    
    % Create new figure
    
             
    % Plot data
    figure
    plot(thita1);
    hold on
    plot(thita2);
    hold on
    plot(thita3);
    
    % Format plot
    xlabel('Time')
    %ylim([0,2.5])
    ylabel('Thita')
    title('Thita comparison');
    legend({'Thita before xoring','Thita after xoring with AODV'},'Thita after xoring with DSR')

    hold off
end
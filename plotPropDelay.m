function plotPropDelay(propDelay)

    % Bring globals into scope
    global colors;
    
    % Close any old figures containing stats
    %openFigs = get(groot, 'Children');
    %a=openFigs.Name
    %idxs = find(strcmp(a,'Propagation Delay'));
    %delete(openFigs(idxs));
    
    % Create new figure
    figure  
    % Plot data4
    myTimes1=minutes(1:length(propDelay));
    plot(myTimes1,propDelay)
    title('Propagation Delay during Establising Communication Between Transmitter and Receiver')
    % Format plot
    xlabel('Data Packet')
    %ylim([0,2.5])
    ylabel('Delay (in ns)')
    
end
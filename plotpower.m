function plotpower(pr)
    % Create new figure
    figure 
    % Plot data
    myTimes1=minutes(1:length(pr));
    plot(myTimes1,pr)
    
    % Format plot
    xlabel('Time')
    title('Pr Recieved Power')
    ylabel('Pr Recieved Power')
    hold off
end
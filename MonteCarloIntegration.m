clear
close all
clc

syms x integratedFunction(x)  % Variable x and function is defined as symbol

prompt = 'Please enter the function you want to integrate. (y=f(x) x as variable) : ';


integratedFunction(x) = input(prompt); % User enters the function


prompt = 'Please enter a integration lower limit : ';

xLowerLimit = input(prompt);

prompt = 'Please enter a integration upper limit : ';

xHigherLimit = input(prompt); % Lower and higher limits of integration are entered by user


maxMinCalcInt=xLowerLimit:0.01:xHigherLimit; % Variable for saving function in an array
functionValues=integratedFunction(maxMinCalcInt); % Array of the function f(x)
hold on
plot(maxMinCalcInt,integratedFunction(maxMinCalcInt),'k') % Function is plotted


yHigherLimit = max(functionValues);

yLowerLimit = min(functionValues); % Max and min values of function for finding limits of y axis are calculated
title('Monte Carlo Simulation')
xlabel('x');
ylabel('f(x)');

%xlim([xLowerLimit*9/10 xHigherLimit*10/9])

line([xHigherLimit xHigherLimit],[yLowerLimit yHigherLimit])
line([xLowerLimit xLowerLimit], [yLowerLimit yHigherLimit]) 
line([xLowerLimit xHigherLimit],[yHigherLimit yHigherLimit]) % Higher limit
line([xLowerLimit xHigherLimit], [yLowerLimit yLowerLimit]) % Lower limit
% Rectangle is visualized
line([xLowerLimit xHigherLimit], [0 0]) % Zero line

prompt = 'Please enter the iteration number : ';

iterationNumber = input(prompt); % User enters iteration number

area=int(integratedFunction(x),x,xLowerLimit,xHigherLimit); % Real area is calculated for comparison of values

rectangleArea=(xHigherLimit-xLowerLimit)*(yHigherLimit-yLowerLimit); % Area of rectangle is measured
pointsUnder=0; % Total points and points under the function are determined
totalPoints=0;

fprintf("Red dots are in positive interval, blue dots are in negative interval and green dots are out of interval.\n")

for jj=1:1:iterationNumber % For loop
    generatedRandomY=rand*(yHigherLimit-yLowerLimit)+yLowerLimit;
    generatedRandomX=rand*(xHigherLimit-xLowerLimit)+xLowerLimit; % Two random x and y values are chosen
     
    if (generatedRandomY<=integratedFunction(generatedRandomX) && generatedRandomY>0)
        pointsUnder = pointsUnder+1;  % If random value is in the interval points under function increases
        plot(generatedRandomX,generatedRandomY,'r.','MarkerSize',8); % Point is plotted
    

    elseif (generatedRandomY>=integratedFunction(generatedRandomX) && generatedRandomY<0)
        pointsUnder = pointsUnder-1; % If random value is in the negative interval points under function decreases
        plot(generatedRandomX,generatedRandomY,'b.','MarkerSize',8);
    
    else
        plot(generatedRandomX,generatedRandomY,'g.','MarkerSize',8); % Else point is not in the interval
    end
    pause(0.00001) % For visualization of points being placed
    totalPoints=totalPoints+1; % Number of total dots increase
    % Difference of calculated and measured values are saved in an array
    differenceOfValues(jj)=area-((pointsUnder/totalPoints)*rectangleArea);
    valuesOfMonteCarlo(jj)=(pointsUnder/totalPoints)*rectangleArea;
end
answerOfMonteCarlo=(pointsUnder/totalPoints)*rectangleArea; % Monte carlo method is applied
%disp("------------------------------------------------------------------------")
fprintf('The answer of integration with using Monte Carlo Method is %.4f \n',answerOfMonteCarlo) % Answer is printed in a user friendly way
%disp("------------------------------------------------------------------------")
hold off % Holding off for new plot
prompt = 'Press 1 to see difference over time : '; % Lets user observe previous output until they decide to move on

seeTheDifference = input(prompt);

if seeTheDifference == 1
    
    plottingArray=1:1:iterationNumber; 
    plot(plottingArray,differenceOfValues,'r') % Difference of real and measured values per iteration is plotted
    title('Difference over iteration');
    xlim([-5 iterationNumber*10/9])
    line([0 iterationNumber*10/9],[0 0])
    ylabel('Difference between areas (calculated-measured)');
    xlabel('Iterations');
    hold off
end
fprintf('Final difference is: %.3f\n',differenceOfValues(iterationNumber)) % Final difference is printed
fprintf('Error percentage is: %.3f\n',(differenceOfValues(iterationNumber)/area)*100) % % Difference of final

seeTheDifference = 0;  % Setting value back to zero to ask the user again

prompt = 'Press 1 to see the histogram of difference over time : ';
seeTheDifference = input(prompt);

if seeTheDifference == 1
    
    plottingArray=1:1:iterationNumber; 
    histogram(double(valuesOfMonteCarlo));
    %histogram(double(functionValues)) % Histogram of difference of real and measured values per iteration is plotted
    
end



seeTheDifference = 0; % Setting value back to zero to ask the user again

prompt = 'Press 1 to see the histogram function value : ';
seeTheDifference = input(prompt);

if seeTheDifference == 1
    
    plottingArray=1:1:iterationNumber; 
    histogram(double(differenceOfValues)) % Histogram of integral over time is plotted
    
end




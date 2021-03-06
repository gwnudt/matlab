function [out, cf, x, yOut, xOut] = CTFanalysis3

tic
dataPath = '/home/jmoosmann/data/QP/Steffen/2015-05-25';
load(sprintf('%s/data.mat', dataPath));
xOut = xOut(:) /pi;
numS = size(yOut,2);
Srange = 1:10:numS;

for nn = numel(Srange):-1:1
    SS = Srange(nn);
    cf{nn} = FitLine(xOut, yOut(:,SS));
end

numcf = numel(cf);
x = xOut(xOut < 1.4);
for kk = numcf:-1:1
    [out.cfMaxVal(kk), out.cfMaxPos(kk)] = max(cf{kk}(x));
    [out.cfMinVal(kk), out.cfMinPos(kk)] = min(cf{kk}(x));
end

for kk = 1:numcf
    SS = Srange(kk);
    %plot( xOut, yOut(:,SS) ,'.', xOut, cf{kk}(xOut), '-' )
    plot( xOut, yOut(:,SS) ,'.', xOut, cf{kk}(xOut), '-' , xOut(out.cfMinPos(kk)), out.cfMinVal(kk),'o');
    axis tight equal,
    pause(0.01)
    saveas(gcf,sprintf('%s/Julian/plots/plot_%03u.png', dataPath, SS),'png')
end

plot(Srange,out.cfMinPos)
saveas( gcf, sprintf( '%s/Julian/MinPos.png', dataPath), 'png' )
fprintf('Time elapsed: %g s',toc)

function [fitresult, gof] = FitLine(x, y)
%CREATEFIT(XOUT,Y)
%  Create a fit.
%
%  Data for 'untitled fit 2' fit:
%      X Input : xOut
%      Y Output: y
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 25-May-2015 10:45:08

[xData, yData] = prepareCurveData( x, y );

% Set up fittype and options.
ft = fittype( 'a1 * exp( -a2 * pi*x  ) * ( abs( sin(c0*pi*x) )  + b0 + b1 * sqrt(pi*x) + b2 * pi*x + b3 * sqrt(pi*x)^3 + b4 * (pi*x)^2 + b5  * sqrt(pi*x)^5 )', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf -Inf -Inf -Inf -Inf -Inf -Inf 0];
opts.StartPoint = [0.223811939491137 0.751267059305653 0.255095115459269 0.505957051665142 0.699076722656686 0.890903252535798 0.959291425205444 0.547215529963803 1];
opts.Upper = [Inf Inf Inf Inf Inf Inf Inf Inf 1];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

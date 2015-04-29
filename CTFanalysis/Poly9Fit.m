function cf_ = Poly9Fit(x,y)
%CREATEFIT Create plot of data sets and fits
%   CREATEFIT(X,Y)
%   Creates a plot, similar to the plot in the main Curve Fitting Tool,
%   using the data that you provide as input.  You can
%   use this function with the same data you used with CFTOOL
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of data sets:  1
%   Number of fits:  1

% Data from data set "y vs. x":
%     X = x:
%     Y = y:
%     Unweighted

% Auto-generated by MATLAB on 21-Jun-2011 09:36:56

% Set up figure to receive data sets and fits
f_ = clf;
figure(f_);
set(f_,'Units','Pixels','Position',[578 255 688 481]);
% Line handles and text for the legend.
legh_ = [];
legt_ = {};
% Limits of the x-axis.
xlim_ = [Inf -Inf];
% Axes for the plot.
ax_ = axes;
set(ax_,'Units','normalized','OuterPosition',[0 0 1 1]);
set(ax_,'Box','on');
axes(ax_);
hold on;

% --- Plot data that was originally in data set "y vs. x"
x = x(:);
y = y(:);
h_ = line(x,y,'Parent',ax_,'Color',[0.333333 0 0.666667],...
    'LineStyle','none', 'LineWidth',1,...
    'Marker','.', 'MarkerSize',12);
xlim_(1) = min(xlim_(1),min(x));
xlim_(2) = max(xlim_(2),max(x));
legh_(end+1) = h_;
legt_{end+1} = 'y vs. x';

% Nudge axis limits beyond data limits
if all(isfinite(xlim_))
    xlim_ = xlim_ + [-1 1] * 0.01 * diff(xlim_);
    set(ax_,'XLim',xlim_)
else
    set(ax_, 'XLim',[-8.9900000000000002132, 1009.9900000000000091]);
end

% --- Create fit "Poynomial fit of maximum position"
fo_ = fitoptions('method','LinearLeastSquares','Normalize','on');
ok_ = isfinite(x) & isfinite(y);
if ~all( ok_ )
    warning( 'GenerateMFile:IgnoringNansAndInfs',...
        'Ignoring NaNs and Infs in data.' );
end
ft_ = fittype('poly9');

% Fit this model using new data
cf_ = fit(x(ok_),y(ok_),ft_,fo_);
% Alternatively uncomment the following lines to use coefficients from the
% original fit. You can use this choice to plot the original fit against new
% data.
%    cv_ = { -2.5420851766937326843, -3.7513457793171345322, 15.689232928761901675, 24.555042931711280829, -31.240388756113013358, -46.960890777746307378, 29.428879537173088465, -60.553544633256869645, 301.29912756591522793, 811.25441038629594459};
%    cf_ = cfit(ft_,cv_{:});

% Plot this fit
h_ = plot(cf_,'fit',0.95);
set(h_(1),'Color',[1 0 0],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
% Turn off legend created by plot method.
legend off;
% Store line handle and fit name for legend.
legh_(end+1) = h_(1);
legt_{end+1} = 'Poynomial fit';

% --- Finished fitting and plotting data. Clean up.
hold off;
% Display legend
leginfo_ = {'Orientation', 'vertical'};
h_ = legend(ax_,legh_,legt_,leginfo_{:});
set(h_,'Units','normalized');
t_ = get(h_,'Position');
t_(1:2) = [0.548328,0.116148];
set(h_,'Interpreter','none','Position',t_);
% Remove labels from x- and y-axes.
xlabel(ax_,'');
ylabel(ax_,'');
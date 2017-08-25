function mylife(action)

% Possible actions:
% initialize
% start

play =  1;
stop = -1;

if nargin<1,
   action = 'initialize';
end;

if strcmp(action,'initialize'),
   figNumber = figure( ...
      'Name',getString(message('MATLAB:demos:life:TitleConwaysGameOfLife')), ...
      'NumberTitle','off', ...
      'Visible','off', ...
      'Color','white');
   axes( ...
      'Units','normalized', ...
      'Position',[0.05 0.05 0.75 0.90], ...
      'Visible','off', ...
      'SortMethod','childorder', ...
      'NextPlot','add');
   
   text(0,0,getString(message('MATLAB:demos:life:LabelPressTheStartButton')), ...
      'HorizontalAlignment','center');
   axis([-1 1 -1 1]);
 
   % ===================================
   % Information for all buttons
   labelColor = [0.8 0.8 0.8];
   yInitPos = 0.90;
   xPos = 0.85;
   btnLen = 0.10;
   btnWid = 0.10;
   % Spacing between the button and the next command's label
   spacing = 0.05;
   
   % ====================================
   % The CONSOLE frame
   frmBorder = 0.02;
   yPos = 0.05-frmBorder;
   frmPos = [xPos-frmBorder yPos btnLen+2*frmBorder 0.9+2*frmBorder];
   h = uicontrol( ...
      'Style','frame', ...
      'Units','normalized', ...
      'Position',frmPos, ...
      'BackgroundColor',[0.50 0.50 0.50]);
   
   % ====================================
   % The START button
   btnNumber = 1;
   yPos = 0.90-(btnNumber-1)*(btnWid+spacing);
   labelStr = getString(message('MATLAB:demos:shared:LabelStart'));
   cmdStr = 'start';
   callbackStr = 'mylife(''start'');';
   
   % Generic button information
   btnPos = [xPos yPos-spacing btnLen btnWid];
   startHndl = uicontrol( ...
      'Style','pushbutton', ...
      'Units','normalized', ...
      'Position',btnPos, ...
      'String',labelStr, ...
      'Interruptible','on', ...
      'Callback',callbackStr);
   
   % ====================================
   % The STOP button
   btnNumber = 2;
   yPos = 0.90-(btnNumber-1)*(btnWid+spacing);
   labelStr = getString(message('MATLAB:demos:shared:LabelStop'));
   % Setting userdata to -1 (= stop) will stop the demo.
   callbackStr = 'set(gca,''Userdata'',-1)';
   
   % Generic button information
   btnPos = [xPos yPos-spacing btnLen btnWid];
   stopHndl = uicontrol( ...
      'Style','pushbutton', ...
      'Units','normalized', ...
      'Position',btnPos, ...
      'Enable','off', ...
      'String',labelStr, ...
      'Callback',callbackStr);
   
   % ====================================
   % The INFO button
   labelStr = getString(message('MATLAB:demos:shared:LabelInfo'));
   callbackStr = 'mylife(''info'')';
   infoHndl = uicontrol( ...
      'Style','push', ...
      'Units','normalized', ...
      'Position',[xPos 0.20 btnLen 0.10], ...
      'String',labelStr, ...
      'Callback',callbackStr);
   
   % ====================================
   % The CLOSE button
   labelStr = getString(message('MATLAB:demos:shared:LabelClose'));
   callbackStr = 'close(gcf)';
   closeHndl = uicontrol( ...
      'Style','push', ...
      'Units','normalized', ...
      'Position',[xPos 0.05 btnLen 0.10], ...
      'String',labelStr, ...
      'Callback',callbackStr);
   
   % Uncover the figure
   hndlList = [startHndl stopHndl infoHndl closeHndl];
   set(figNumber,'Visible','on', ...
      'UserData',hndlList);
   
elseif strcmp(action,'start'),
   cla;
   axHndl = gca;
   figNumber = gcf;
   hndlList = get(figNumber,'Userdata');
   startHndl = hndlList(1);
   stopHndl = hndlList(2);
   infoHndl = hndlList(3);
   closeHndl = hndlList(4);
   set([startHndl closeHndl infoHndl],'Enable','off');
   set(stopHndl,'Enable','on');
   
   % ====== Start of Demo
   set(axHndl, ...
      'UserData',play, ...
      'SortMethod','childorder', ...
      'Visible','off');
   m = 101;
   mm=101;
   X = sparse(m,m);
   Y = sparse(mm,mm);

   p = -1:1;
   for count = 1:15,
      kx = floor(rand*(m-4))+2;
      ky = floor(rand*(m-4))+2;
      X(kx+p,ky+p) = (rand(3)>0.5);
      Y(kx+p,ky+p) = (rand(3)>0.5);
   end;
   
   % The following statements plot the initial configuration.
   % The "find" function returns the indices of the nonzero elements.
   [i,j] = find(X);
   figure(gcf);
   plothandle = plot(i,j,'o', ...
      'Color','black', ...
      'MarkerSize',8);
   axis([0 m+1 0 m+1]);
   
      [k,l] = find(Y);
   figure(gcf);
   plothandle = plot(k,l,'o', ...
      'Color','red', ...
      'MarkerSize',8);
   axis([0 mm+1 0 mm+1]);
   
   % Whether cells stay alive, die, or generate new cells depends
   % upon how many of their eight possible neighbors are alive.
   % Here we generate index vectors for four of the eight neighbors.
   % We use periodic (torus) boundary conditions at the edges of the universe.
   
   n = [m 1:m-1];
   e = [2:m 1];
   s = [2:m 1];
   w = [m 1:m-1];
   nn = [mm 1:mm-1];
   ee = [2:mm 1];
   ss = [2:mm 1];
   ww = [mm 1:mm-1];
   
   while get(axHndl,'UserData') == play,
      % How many of eight neighbors are alive.
      N = X(n,:) + X(s,:) + X(:,e) + X(:,w) + ...
         X(n,e) + X(n,w) + X(s,e) + X(s,w);
      M = Y(nn,:) + Y(ss,:) + Y(:,ee) + Y(:,ww) + ...
         Y(nn,e) + Y(nn,ww) + Y(ss,ee) + Y(ss,ww);
      % A live cell with two live neighbors, or any cell with three
      % neigbhors, is alive at the next time step.
      X = (X & (N == 2)) | (N == 3);
      Y =  (Y & (M == 2)) | (M == 3);
      % Update plot.
      [i,j] = find(X);
      set(plothandle,'xdata',i,'ydata',j)
      drawnow
      
      [k,l] = find(Y);
      set(plothandle,'xdata',k,'ydata',l)
      drawnow
      
      % Bail out if the user closed the figure.
      if ~ishandle(startHndl)
         return
      end
      
   end
   
   % ====== End of Demo
   set([startHndl closeHndl infoHndl],'Enable','on');
   set(stopHndl,'Enable','off');
   
elseif strcmp(action,'info');
   helpwin(mfilename);
   
end;    % if strcmp(action, ...

% Plot a line and points
G = tf([1 2],[1 3 9]);
[p,z] = pzmap(G);
%%
figure
plot(real(p),imag(p),'xr','buttondownfcn',{@Mouse_Callback,'down'});
hold on
plot(real(z),imag(z),'ob','buttondownfcn',{@Mouse_Callback,'down'});
hold on
plot([-10 10],[0 0],'k','linewidth',1)
hold on
plot([0 0],[-10 10],'k','linewidth',1)
grid minor

% Callback function for each point
function Mouse_Callback(hObj,~,action)
clc
persistent curobj xdata ydata ind
pos = get(gca,'CurrentPoint');
switch action
  case 'down'
      curobj = hObj;
      xdata = get(hObj,'xdata');
      ydata = get(hObj,'ydata');
      [~,ind] = min(sum((xdata-pos(1)).^2+(ydata-pos(3)).^2,1));
      set(gcf,...
          'WindowButtonMotionFcn',  {@Mouse_Callback,'move'},...
          'WindowButtonUpFcn',      {@Mouse_Callback,'up'});
  case 'move'
      % vertical move
      ydata(ind) = pos(3);
      set(curobj,'ydata',ydata)
  case 'up'
      set(gcf,...
          'WindowButtonMotionFcn',  '',...
          'WindowButtonUpFcn',      '');
      assignin('base','changedPole',ydata)
end
end
model = 'ClosedLoopBLDC';
Ts = 1e-6;
stop_time = 0.7;
Tlog = 1;
load_system(model);

set_param(strcat(model,'/Solver Configuration'),'LocalSolverSampleTime', num2str(Ts));


t = timer;
t.Period = Tlog;
t.ExecutionMode = 'fixedRate';
t.TimerFcn = @(myTimerObj, thisEvent)bomba(model);

start(t)
sim(model, 'StopTime', num2str(stop_time));
stop(t); delete(t);


function bomba(model)
    progress = get_param(model, 'SimulationTime') / str2double(get_param(model,'StopTime'));
    fprintf('Simulation progress: %.2f %%\n',progress);
end
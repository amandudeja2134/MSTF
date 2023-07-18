% Frequency Estimator Model

% Input AC Voltage
acVoltage = Inport;
acVoltage.Name = 'Voltage';

% Block to calculate square of input
sqr = S-Function;
sqr.FunctionName = 'square'; % Defines function (see code below)

% Lowpass Filter 
lpf = Lowpass('butter');
lpf.CutoffFrequency = 10;

% To workspace block to view filtered output
toWs = ToWorkspace('time');

% D-type Flip Flop
dff = DFlipFlop('dg2');
dff.Timer = 0.01; % Sampling rate

% Zero-crossing Detector
zc = ZeroCrossingDetector('both');

% Timer
counter = Timer;
counter.InitialCondition = 0;
counter.Period = 0.01; % Sampling period
counter.CounterDirection = Down; % Decrements counter

% Divide by constant  
constDiv = Constant / Divide;
constDiv.Constant =  counter.Period;   

% Frequency display
f = Outport;
f.Name = 'Frequency';

% Connect blocks
connect(acVoltage, sqr);
connect(sqr, lpf);  
connect(lpf, dff);
connect(dff, zc);
connect(zc, counter);
connect(counter,constDiv);
connect(constDiv, f);
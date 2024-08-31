%% time and space setups
param.L = 10;
param.N = 1001; 
param.tmax = 20; 
param.dt = 0.025; 
param.L_pam = 5; % critical length scale

% Load the parameters from the text file 
all_sampled_params = readmatrix(strcat(data_dir, 'augment_params.txt'), 'Delimiter', ',');
raw_params = all_sampled_params(taskID, :);
param.DC = raw_params(1);
param.DN = 0.6;
param.DA = 0.6;
param.DB = 0.6;
param.aC = raw_params(2);
param.aA = raw_params(3);
param.aB = 100;
param.aT = raw_params(4);
param.aL = raw_params(5);
param.bN = 155;
param.dA = raw_params(6);
param.dB = param.dA;
param.dT = raw_params(7);
param.dL = raw_params(8);
param.k1 = 0.4;
param.k2 = 10.800;
param.KN = 20000;
param.KP = 40;
param.KT = 12;
param.KA = 10;
param.KB = 200;
param.alpha = raw_params(9);
param.beta = raw_params(10);
param.Cmax = 3e5;
param.a = 5;
param.b = 5;
param.m = 2;
param.n = 2;
param.Kphi = raw_params(11);
param.l = 2; 
param.N0 = raw_params(12);
param.taskID = taskID;

opt_list =  ["exp","linear","exp","exp","exp","exp","exp","exp","linear","exp","linear","linear" ];

% (upper lim - lower lim) for each parameter
perturbationScale_list = [0.1245,0.9, 99900, 7990, 495, 0.099, 297, 14.256, 4, 1998, 9, 4800000 ];
param_name_list = ["DC", "aC", "aA", "aT", "aL", "dA", "dT", "dL", "alpha", "beta", "Kphi", "N0"] ;
min_values = [0.5e-3, 0.1, 100, 10, 5, 0.001, 3, 0.144, 1, 2, 1, 200000] 
max_values = [12.5e-2, 1, 100000, 8000, 500, 0.1, 300, 14.4, 5, 2000, 10, 5000000]            

for i = 1:12
    param_name = param_name_list(i);
    perturbationScale = perturbationScale_list(i);
    opt =  opt_list(i)
    new = perturbParam(param, param_name, perturbationScale, opt);
    
    min_val = min_values(i);
    max_val = max_values(i);
    
    % Clamp the value within the min and max bounds
    if new < min_val
        new = min_val;
    elseif new > max_val
        new = max_val;
    end
    
    param.(param_name) = new;
end



% Calculate nondimensional parameters
param.G1 = param.DC / param.aC / param.L_pam^2;
param.G2 = param.KN / param.N0;
param.G3 = param.DN / param.aC / param.L_pam^2;
param.G4 = param.bN * param.Cmax / param.N0;
param.G5 = param.DA / param.aC / param.L_pam^2;
param.G6 = param.aA * param.Cmax / param.aC / param.KA;
param.G7 = param.KT * param.dT / param.aT;
param.G8 = param.dA / param.aC;
param.G9 = param.DB / param.aC / param.L_pam^2;
param.G10 = param.aB * param.Cmax / param.aC / param.KB;
param.G11 = param.dB / param.aC;
param.G12 = param.dT / param.aC;
param.G13 = param.k1 * param.aL / param.aC / param.dL;
param.G14 = param.k2 * param.KP * param.dT / param.aC / param.aT;
param.G15 = param.dL / param.aC;
param.G16 = param.k1 * param.aT / param.aC / param.dT;
param.G17 = param.k2 * param.KP * param.dL / param.aC / param.aL;
param.G18 = param.k1 * param.aT * param.aL / param.KP / param.aC / param.dT / param.dL;
param.G19 = param.k2 / param.aC;


param.alpha_p = param.alpha * param.aT / param.dT;
param.beta_p = param.beta * param.aL / param.dL;

% Set initial values 
param.Ce0 = get_C0_scale(param, "donut")';
param.Nu0 = ones(param.N, 1);
param.A0  = zeros(param.N, 1); 
param.B0  = zeros(param.N, 1); 
param.Ly0 = zeros(param.N, 1); 
param.T0  = 0.1 * param.Ce0; 
param.P0  = zeros(param.N, 1); 
param.CFP0  = zeros(param.N, 1); 
param.RFP0  = zeros(param.N, 1); 

function Results = Run_Quasi_Sim(Car,Environment,Track,Options)

%% Create tyre inputs for each point on track for G-G diagram
Tyre.z.FL = Car.m_cF * (Car.e_F/(Car.d_F + Car.e_F));
Tyre.z.FR = Car.m_cF * (Car.d_F/(Car.d_F + Car.e_F));
Tyre.z.RL = Car.m_cR * (Car.e_R/(Car.d_R + Car.e_R));
Tyre.z.RR = Car.m_cR * (Car.d_R/(Car.d_R + Car.e_R));
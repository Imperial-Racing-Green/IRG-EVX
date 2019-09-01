function Initial = Dynamic_Sim_Initial(Car,Track,Environment)

Base = Track_z(Car,Track);

Forces = Car_Forces(Car,Environment,Velocity,Acceleration);

Initial.Vibrations = Vibration_SS(Car,Forces,Base);
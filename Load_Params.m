function [Car,Environment] = Load_Params()

Car.Mass.Chassis = 200;
Car.Mass.WheelFL = 10;
Car.Mass.WheelFR = 10;
Car.Mass.WheelRL = 10;
Car.Mass.WheelRR = 10;

Car.Stifness.Chassis = 50000;

Environment.Gravity = -9.81;

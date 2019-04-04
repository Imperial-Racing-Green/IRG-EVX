function [Car,Environment] = Load_Params()

Car.Mass.Chassis = 200;
Car.Mass.WheelFL = 10;
Car.Mass.WheelFR = 10;
Car.Mass.WheelRL = 10;
Car.Mass.WheelRR = 10;

Car.Stifness.Chassis = 50000;

Environment.Gravity = -9.81;

load([pwd,'\kinematics\geometries\EV3 Front Hardpoints 13.01.19.mat']);
Car.Sus.Front.Hardpoints = hardpoints_front;
load([pwd,'\kinematics\geometries\Final rear Outboard 01.02.19.mat']);
Car.Sus.Rear.Hardpoints = hardpoints_front;
function Initial = Vibration_SS(Car,Forces,Base)

kt = [Car.k_tFL;Car.k_tFR;Car.k_tRL;Car.k_tRR];
ks = [Car.k_sFL;Car.k_sFR;Car.k_sRL;Car.k_sRR];
kb = [Car.k_Frb;Car.k_Rrb;Car.k_Lpb;Car.k_Rpb;Car.k_FLRRwb;Car.k_FRRLwb];
kc = Car.k_c;
w = [Car.a;Car.b;Car.d_F;Car.e_F;Car.d_R;Car.e_R];

if kc > 0
    
    K = [kt(1)+ks(1)+kb(1)+kb(3)+kb(5),-kb(1),-kb(3),-kb(5),-ks(1),w(1)*ks(1),-w(3)*ks(1),0;...
        -kb(1),kt(2)+ks(2)+kb(1)+kb(4)+kb(6),-kb(6),-kb(4),-ks(2),w(1)*ks(2),w(4)*ks(2),0;...
        -kb(3),-kb(6),kt(3)+ks(3)+kb(2)+kb(3)+kb(6),-kb(2),-ks(3),-w(2)*ks(3),0,-w(5)*ks(3);...
        -kb(5),-kb(4),-kb(2),kt(4)+ks(4)+kb(2)+kb(4)+kb(5),-ks(4),-w(2)*ks(4),0,w(6)*ks(4);...
        -ks(1),-ks(2),-ks(3),-ks(4),ks(1)+ks(2)+ks(3)+ks(4),-w(1)*ks(1)-w(1)*ks(2)+w(2)*ks(3)+w(2)*ks(4),w(3)*ks(1)-w(4)*ks(2),w(5)*ks(3)-w(6)*ks(4);...
        w(1)*ks(1),w(1)*ks(2),-w(2)*ks(3),-w(2)*ks(4),-w(1)*ks(1)-w(1)*ks(2)+w(2)*ks(3)+w(2)*ks(4),w(1)^2*ks(1)+w(1)^2*ks(2)+w(2)^2*ks(3)+w(2)^2*ks(4),-w(1)*w(3)*ks(1)+w(1)*w(4)*ks(2),w(2)*w(5)*ks(3)-w(2)*w(6)*ks(4);...
        -w(3)*ks(1),w(4)*ks(2),0,0,w(3)*ks(1)-w(4)*ks(2),-w(1)*w(3)*ks(1)+w(1)*w(4)*ks(2),w(3)^2*ks(1)+w(4)^2*ks(2)+kc(1),-kc(1);...
        0,0,-w(5)*ks(3),w(6)*ks(4),w(5)*ks(3)-w(6)*ks(4),w(2)*w(5)*ks(3)-w(2)*w(6)*ks(4),-kc(1),w(5)^2*ks(3)+w(6)^2*ks(4)+kc(1)];
    
    B = [diag([kt(1),kt(2),kt(3),kt(4)]),zeros(4,4);zeros(4,8)];
    
    Z = [Base;zeros(4,1)];
    
    Initial.x = K \ (Forces + B * Z);
    % Get Correct Non-linear Output
    Initial.x(6:8) = 0.5 .* asin(2 * Initial.x(6:8));
    Initial.x_dot = zeros(8,1);
    
elseif kc == 0
    
    K = [kt(1)+ks(1)+kb(1)+kb(3)+kb(5),-kb(1),-kb(3),-kb(5),-ks(1),w(1)*ks(1),-w(3)*ks(1);...
        -kb(1),kt(2)+ks(2)+kb(1)+kb(4)+kb(6),-kb(6),-kb(4),-ks(2),w(1)*ks(2),w(4)*ks(2);...
        -kb(3),-kb(6),kt(3)+ks(3)+kb(2)+kb(3)+kb(6),-kb(2),-ks(3),-w(2)*ks(3),-w(5)*ks(3);...
        -kb(5),-kb(4),-kb(2),kt(4)+ks(4)+kb(2)+kb(4)+kb(5),-ks(4),-w(2)*ks(4),w(6)*ks(4);...
        -ks(1),-ks(2),-ks(3),-ks(4),ks(1)+ks(2)+ks(3)+ks(4),-w(1)*ks(1)-w(1)*ks(2)+w(2)*ks(3)+w(2)*ks(4),w(3)*ks(1)-w(4)*ks(2)+w(5)*ks(3)-w(6)*ks(4);...
        w(1)*ks(1),w(1)*ks(2),-w(2)*ks(3),-w(2)*ks(4),-w(1)*ks(1)-w(1)*ks(2)+w(2)*ks(3)+w(2)*ks(4),w(1)^2*ks(1)+w(1)^2*ks(2)+w(2)^2*ks(3)+w(2)^2*ks(4),-w(1)*w(3)*ks(1)+w(1)*w(4)*ks(2)+w(2)*w(5)*ks(3)-w(2)*w(6)*ks(4);...
        -w(3)*ks(1),w(4)*ks(2),-w(5)*ks(3),w(6)*ks(4),w(3)*ks(1)-w(4)*ks(2)+w(5)*ks(3)-w(6)*ks(4),-w(1)*w(3)*ks(1)+w(1)*w(4)*ks(2)+w(2)*w(5)*ks(3)-w(2)*w(6)*ks(4),w(3)^2*ks(1)+w(4)^2*ks(2)+w(5)^2*ks(3)+w(6)^2*ks(4)];
    
    B = [diag([kt(1),kt(2),kt(3),kt(4)]),zeros(4,4);zeros(4,8)];
    
    Z = [Base;zeros(4,1)];
    
    Forces(7) = Forces(7) + Forces(8);
    
    Initial.x = K \ (Forces(1:7) + B * Z);
    Initial.x = [Initial.x;Initial.x(7)];
    % Get Correct Non-linear Output
    Initial.x(6:8) = 0.5 .* asin(2 * Initial.x(6:8));
    
    Initial.x_dot = zeros(8,1);
    
else
    disp('Error - Car chassis stiffness k_c cannot be negative.')
    
    return
end
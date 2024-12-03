% Parameter sistem
J = 0.01;      % Momen inersia (kg·m²)
B = 0.1;       % Koefisien redaman (Nm·s/rad)
Km = 0.5;      % Konstanta motor (rad/V·s)

% Parameter PID
Kp = 2.5;      % Proportional gain
Ki = 1.0;      % Integral gain
Kd = 0.5;      % Derivative gain

% Model transfer function motor
num = [Km];    % Numerator
den = [J, B];  % Denominator
motor_tf = tf(num, den);

% PID controller
pid_controller = pid(Kp, Ki, Kd);

% Sistem loop tertutup
closed_loop_system = feedback(pid_controller * motor_tf, 1);

% Simulasi
time = 0:0.01:10;                   % Waktu simulasi (10 detik)
set_point = 100 * ones(size(time)); % Set-point (kecepatan target 100 rad/s)
[y, t] = lsim(closed_loop_system, set_point, time);

% Plot hasil
figure;
plot(t, y, 'b', 'LineWidth', 1.5); hold on;
plot(t, set_point, 'r--', 'LineWidth', 1.2);
xlabel('Waktu (s)');
ylabel('Kecepatan (rad/s)');
title('Respons Sistem Kendali Kecepatan Drone');
legend('Kecepatan Aktual', 'Set-point');
grid on;
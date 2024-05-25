C=[17 21 22 18 24 15 20 18 19 18 16 22 24 24 16;
 23 16 21 16 17 16 19 25 18 21 17 15 25 17 24;
 16 20 16 25 24 16 17 19 19 18 20 16 17 21 24;
 19 19 22 22 20 16 19 17 21 19 25 23 25 25 25;
 18 19 15 15 21 25 16 16 23 15 22 17 19 22 24;];

r=[8 15 14 23 8 16 8 25 9 17 25 15 10 8 24;
 15 7 23 22 11 11 12 10 17 16 7 16 10 18 22;
 21 20 6 22 24 10 24 9 21 14 11 14 11 19 16;
 20 11 8 14 9 5 6 19 19 7 6 6 13 9 18;
 8 13 13 13 10 20 25 16 16 17 10 10 5 12 23;];


X = zeros(5, 15); % Genera una matriz X de ceros de tamaÃ±o 5x15

for j = 1:15
    fila = randi([1 5]);
    X(fila, j) = 1; % Para cada columna de X, selecciona aleatoriamente una fila y coloca un 1 en esa posiciÃ³n
end

b=[36; 
    34; 
    38; 
    27; 
    33;];

tic; % Inicia el cronÃ³metro
% ParÃ¡metros del algoritmo
n1 = 10; % NÃºmero de iteraciones con diferente temperatura
n2 = 5; % NÃºmero de iteraciones con igual temperatura
T = 1000; % Temperatura inicial
T_min = 0.01; % Temperatura mÃ­nima
alfa = 0.9; % Factor de enfriamiento
% Valor de la funciÃ³n objetivo para la soluciÃ³n inicial
z = funcobj(C, X, r, b);
iteraciones = 0; % Inicializa el contador de iteraciones
zetas = [];


while T > T_min
    % Realiza n1 ciclos de bÃºsqueda
    for i = 1:n1
        % Realiza n2 bÃºsquedas en cada ciclo
        for j = 1:n2
            % Genera una nueva soluciÃ³n vecina
            X_nuevo = X; % Crea una copia de la soluciÃ³n actual
            columna = randi([1 15]); % Selecciona aleatoriamente una columna
            fila_actual = find(X(:, columna) == 1); % Encuentra la posiciÃ³n del 1 en la columna seleccionada
            
            % Genera una nueva posiciÃ³n aleatoria para el 1 en la misma columna
            fila_nueva = fila_actual;
            while fila_nueva == fila_actual
                fila_nueva = randi([1 5]); % Asegurarce que la nueva posiciÃ³n no sea la misma que la posiciÃ³n actual
            end
            
            % Mueve el 1 a la nueva posiciÃ³n
            X_nuevo(fila_actual, columna) = 0; % Coloca un 0 en la posiciÃ³n actual del 1
            X_nuevo(fila_nueva, columna) = 1; % Coloca un 1 en la nueva posiciÃ³n
            
            % Calcula el valor de la funciÃ³n objetivo para la nueva soluciÃ³n
            z_nuevo = funcobj(C, X_nuevo, r, b);
            
            % Decide si acepta la nueva soluciÃ³n o no
            if z_nuevo > z || rand < exp((z_nuevo - z) / T)
                X = X_nuevo; % Actualiza la soluciÃ³n actual con la nueva soluciÃ³n
                z = z_nuevo; % Actualiza el valor de la funciÃ³n objetivo
                % Imprime la nueva soluciÃ³n y su valor de la funciÃ³n objetivo
                disp(X_nuevo);
                fprintf('z_nuevo = %d\n', z_nuevo);
                zetas = [zetas,z];
            end
            % Incrementa el contador de iteraciones
            iteraciones = iteraciones + 1;
        end
    end
    % Reduce la temperatura
    T = alfa * T;
end



%{
while T > T_min
    for i = 1:n1
        % Genera una nueva soluciÃ³n vecina
        X_nuevo = X; % Copia la matriz actual X
        columna = randi([1 15]); % Selecciona aleatoriamente una columna
        fila_actual = find(X(:, columna) == 1); % Encuentra la posiciÃ³n del 1 en la columna seleccionada
        fila_nueva = fila_actual;
        while fila_nueva == fila_actual
            fila_nueva = randi([1 5]);
        end
        X_nuevo(fila_actual, columna) = 0; %donde estaba el 1 se coloca el 0
        X_nuevo(fila_nueva, columna) = 1 %se repocisiona el 1

        for j = 1:n2
            % Calcula el valor de la funciÃ³n objetivo para la nueva soluciÃ³n
            z_nuevo = funcobj(C, X_nuevo, r, b);
            
            % Decide si acepta la nueva soluciÃ³n o no
            if z_nuevo > z || rand < exp((z_nuevo - z) / T)
                X = X_nuevo;
                z = z_nuevo;
                % Imprime X_nuevo y z_nuevo solo si z_nuevo es mayor que z
                disp(X_nuevo);
                fprintf('z_nuevo = %d\n', z_nuevo);
                zetas = [zetas,z];
            end
            iteraciones = iteraciones + 1; % Incrementa el contador de iteraciones
        end
    end
    
    % Reduce la temperatura
    T = alfa * T;
end
%}
% La soluciÃ³n Ã³ptima
X_optimo = X;
z_optimo = z;
X_optimo
z_optimo

final = funcobj(C, X_optimo, r, b);

iteraciones
toc; % Detiene el cronÃ³metro y muestra el tiempo transcurrido
plot(zetas);
xlabel("Iteracion");
ylabel("Valor de z por iteracion");

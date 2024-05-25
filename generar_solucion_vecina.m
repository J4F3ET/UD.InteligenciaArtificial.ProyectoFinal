function vecino = generar_solucion_vecina(x_actual,maquinas,tareas)

    vecino = x_actual; % Crea una copia de la solucion actual
    columna = randi([1 tareas]); % Selecciona aleatoriamente una columna
    fila_actual = find(x_actual(:, columna) == 1); % Encuentra la posicion del 1 en la columna seleccionada

    % Genera una nueva posicion aleatoria para el 1 en la misma columna
    fila_nueva = fila_actual;
    while fila_nueva == fila_actual
        fila_nueva = randi([1 maquinas]); % Asegurarce que la nueva posicion no sea la misma que la posicion actual
    end

    % Mueve el 1 a la nueva posicion
    vecino(fila_actual, columna) = 0; % Coloca un 0 en la posicion actual del 1
    vecino(fila_nueva, columna) = 1; % Coloca un 1 en la nueva posicion
end
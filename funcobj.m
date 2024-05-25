function z = funcobj(C, X, r, b)
    sumas=C.*X;
    z=0;
    M=1;
    for i=1:5
        for j=1:15
           z=z+sumas(i,j);
        end
    end

    sumasrestr=r.*X;
    dif = zeros(1,5); % Inicializa un vector para almacenar las diferencias

    % Calcula las diferencias para cada restricción
    for i=1:5
        restr = sum(sumasrestr(i,:));
        if (restr <= b(i)) 
            dif(i) = 0;
        else 
            dif(i) = restr - b(i);
        end
    end
    z=z-M*sum(dif); % Actualiza z restando las diferencias ponderadas
    % Imprime las diferencias y z en una sola línea
    fprintf('dif = [%d %d %d %d %d], z = %d\n', dif(1), dif(2), dif(3), dif(4), dif(5), z);
end


clear;
%Importa los datos C,X,b,r
load("data.mat")
T=input('Temperatura inicial: ');
%Conocer el numero de Maquinas(filas) y el numero de Tareas(columnas)
[maquinas, tareas] = size(C);
solucion_actual=X;%INICIALIZA SOLUCION ACTUAL
T_min = 0.01; %TEMPERATURA MINIMA
alfa = 0.9; %FACTOR DE ENFRIAMIENTO
nivel_aspiracion=funcion_objetivo(C,solucion_actual,r,b);%INICIALIZA NIVEL DE ASPIRACION
mejor_solucion=solucion_actual;
iteraciones_iguales_temperatura=50;
%Una lista de misma cantidad de vecinos(5)
lista_tabu=zeros(maquinas,tareas,3);%INICIALIZA LISTA TABU
%Nivel de calidad de la solucion (1 a 5)
calificacion = verificar_solucion(maquinas,tareas,mejor_solucion,r,b);
%Remplaza los valores 1 de la matriz solucion_actual por los valores en r en su
%mismo indice
lista_soluciones=[];%INICIALIZA LISTA SOLUCIONES
lista_test=[];%INICIALIZA LISTA TEST

while T>T_min%CICLO PARA DIFERENTES TEMPERATURAS
    for iteracion_igual_temp = 1:iteraciones_iguales_temperatura%CICLO PARA IGUAL TEMPERATURA
        solucion_nueva = generar_solucion_vecina(solucion_actual,maquinas,tareas);%GENERA SOLUCION NUEVA VECINA A SOLUCION ACTUAL
        es_tabu=verifica_es_tabu(solucion_nueva,lista_tabu);
        if(es_tabu==1)%SI MOVIMIENTO PARA GENERAR SOLUCION NUEVA NO ES TABU ENTONCES
            calcula_delta = funcion_objetivo(C,solucion_nueva,r,b)-funcion_objetivo(C,solucion_actual,r,b);
            if(calcula_delta>0)%SI DELTA ES MAYOR A 0 ENTONCES
                solucion_actual=solucion_nueva;%SOLUCION ACTUAL ES IGUAL A SOLUCION NUEVA
                lista_tabu=actualizar_lista_tabu(solucion_actual,lista_tabu,es_tabu);%ACTUALIZA LISTA TABU
            else%SINO
                if(probabilidad(calcula_delta,T))%SOLUCION ACTUAL ASIGNALER A SOLUCION NUEVA CON PROBABILIDAD
                    solucion_actual=solucion_nueva;
                    lista_tabu=actualizar_lista_tabu(solucion_actual,lista_tabu,es_tabu);
                end
            end%FIN SI
            mejor_solucion=solucion_actual;%ACTUALIZA MEJOR SOLUCION
            nivel_aspiracion=funcion_objetivo(C,solucion_actual,r,b);%ACTUALIZA NIVEL DE ASPIRACION
        else%SINO(EL MOVIMIENTO ES TABU) ENTONCES
            if(funcion_objetivo(C,solucion_nueva,r,b)>nivel_aspiracion)%SI VALOR DE LA FUNCION EN "SOLUCION NUEVA" ES MAYOR A NIVEL DE ASPIRACION ENTONCES
                nivel_aspiracion=funcion_objetivo(C,solucion_nueva,r,b);%ACTUALIZA NIVEL DE ASPIRACION
                mejor_solucion=solucion_nueva;%ACTUALIZA MEJOR SOLUCION
                solucion_actual=solucion_nueva;%ACTUALIZA SOLUCION ACTUAL
                lista_tabu=actualizar_lista_tabu(solucion_nueva,lista_tabu,es_tabu);%ACTUALIZA LISTA TABU
            end%FIN SI
        end%FIN SI
    end%FIN CICLO PARA IGUAL TEMPERATURA
    lista_soluciones = [lista_soluciones,funcion_objetivo(C,solucion_actual,r,b)];%GUARDA SOLUCIONES
    nueva_calificacion = verificar_solucion(maquinas,tareas,solucion_actual,r,b);%CALIFICA SOLUCION
    lista_test = [lista_test,nueva_calificacion];%GUARDA CALIFICACION
    T = alfa * T;%DISMINUIR TEMPERATURA
end%FIN CICLO PARA DIFERENTES TEMPERATURAS
solucion = remplazar_con_r(maquinas,tareas,mejor_solucion,r);%REMPLAZA LOS VALORES 1 DE LA MATRIZ MEJOR SOLUCION POR LOS VALORES EN R EN SU MISMO INDICE
figure;
plot(lista_soluciones);
title('Maximizacion del funcion objetivo');
figure;
plot(lista_test);
title('Calificacion de soluciones');
disp(solucion);
disp("Comparacion de b con la suma de la solucion")
disp("b---solucion")
for i=1:maquinas
    disp([b(i),sum(solucion(i,:))])
end


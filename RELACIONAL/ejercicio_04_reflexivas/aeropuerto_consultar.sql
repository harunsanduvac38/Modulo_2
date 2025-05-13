select ori.aeropuerto, ori.ciudad, des.aeropuerto, 
des.ciudad, ori.id_aeropuerto, des.id_aeropuerto from aeropuertos ori
join conexiones co
on ori.id_aeropuerto = co.fk_aeropuerto_origen
join aeropuertos des
on des.id_aeropuerto = co.fk_aeropuerto_destino
order by ori.id_aeropuerto;



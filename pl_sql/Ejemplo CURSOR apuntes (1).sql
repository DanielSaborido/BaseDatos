DROP TABLE HOTEL CASCADE CONSTRAINT;

CREATE TABLE HOTEL (
HotelID NUMBER(4) PRIMARY KEY,
NHABS NUMBER(4),
PRECIOHAB NUMBER(4),
TIENEPISCINA VARCHAR2(1));

INSERT INTO HOTEL VALUES (1,23,60,'S');
INSERT INTO HOTEL VALUES (2,95,40,'N');
INSERT INTO HOTEL VALUES (3,55,70,'S');
INSERT INTO HOTEL VALUES (4,12,65,'S');


-----------------------------------
-- Con bucle LOOP
-----------------------------------
DECLARE
	NumHabitaciones Hotel.Nhabs%TYPE;
	UnHotel 		Hotel%ROWTYPE;
	CURSOR HotelesGrandes IS SELECT * FROM Hotel
					WHERE Nhabs>NumHabitaciones;
BEGIN
	NumHabitaciones:=50;
	OPEN HotelesGrandes;
	-- Bucle para procesar todos los Hoteles Grandes:
	LOOP
		FETCH HotelesGrandes INTO UnHotel;
		EXIT WHEN HotelesGrandes%NOTFOUND;
		-- Procesamiento del hotel almacenado en UnHotel:
		IF UnHotel.TienePiscina = 'S' THEN
			UPDATE Hotel SET PrecioHab=PrecioHab + 10
			WHERE HotelID=UnHotel.HotelID;
		ELSE
			UPDATE Hotel SET PrecioHab=PrecioHab + 5
			WHERE HotelID=UnHotel.HotelID;
		END IF;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('Hoteles Procesados: '
	|| HotelesGrandes%ROWCOUNT);
	CLOSE HotelesGrandes;
	COMMIT;
END;
/

-----------------------------------
-- Con bucle WHILE
-----------------------------------
DECLARE
	NumHabitaciones Hotel.Nhabs%TYPE;
	UnHotel 		Hotel%ROWTYPE;
	CURSOR HotelesGrandes IS SELECT * FROM Hotel
					WHERE Nhabs>NumHabitaciones;
BEGIN
	NumHabitaciones:=50;
	OPEN HotelesGrandes;
	-- Bucle para procesar todos los Hoteles Grandes:
	FETCH HotelesGrandes INTO UnHotel;
	WHILE HotelesGrandes%FOUND LOOP
		-- Procesamiento del hotel almacenado en UnHotel:
		IF UnHotel.TienePiscina = 'S' THEN
			UPDATE Hotel SET PrecioHab=PrecioHab + 10
			WHERE HotelID=UnHotel.HotelID;
		ELSE
			UPDATE Hotel SET PrecioHab=PrecioHab + 5
			WHERE HotelID=UnHotel.HotelID;
		END IF;
		FETCH HotelesGrandes INTO UnHotel;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('Hoteles Procesados: '
	|| HotelesGrandes%ROWCOUNT);
	CLOSE HotelesGrandes;
	COMMIT;
END;
/

-----------------------------------
-- Con bucle FOR de cursor
-----------------------------------
-- En este caso la variable registro (UnHotel)
-- se declara implícitamente
-----------------------------------
-- De igual manera, la apertura (OPEN), lectura de datos (FETCH)
-- y cierre (CLOSE) del cursor se hacen implícitamente
-----------------------------------
DECLARE
	NumHabitaciones Hotel.Nhabs%TYPE;
	CURSOR HotelesGrandes IS SELECT * FROM Hotel
					WHERE Nhabs>NumHabitaciones;
	Cont 	number := 0;
BEGIN
	NumHabitaciones:=50;
	FOR UnHotel IN HotelesGrandes LOOP
		IF UnHotel.TienePiscina = 'S' THEN
			UPDATE Hotel SET PrecioHab=PrecioHab + 10
			WHERE HotelID=UnHotel.HotelID;
		ELSE
			UPDATE Hotel SET PrecioHab=PrecioHab + 5
			WHERE HotelID=UnHotel.HotelID;
		END IF;
		Cont := Cont + 1;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE('Hoteles Procesados: '	|| Cont);
	COMMIT;
END;
/
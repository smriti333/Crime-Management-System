--CRIME MANAGEMENT SYSTEM
--LOGIN : USERNAME:test , PASSWORD:testt767

--TABLES
CREATE TABLE Person(

    Person_ID NUMBER(4) PRIMARY KEY,
    Full_Name VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(200)
    

);

CREATE TABLE Police_Personnel(

    Police_ID NUMBER(4) PRIMARY KEY,
    Police_Name VARCHAR2(100),
    Phone VARCHAR2(20)

);

CREATE TABLE Crime(

    Crime_ID NUMBER(4) PRIMARY KEY,
    Crime_Code VARCHAR2(20),
    Crime_Type VARCHAR2(50),
    Crime_Date DATE,
    Crime_Location VARCHAR2(100),
    Severity_Level VARCHAR2(20),
    Recorded_By NUMBER(4),
    Inspector_ID NUMBER(4),
    Detective_ID NUMBER(4),
    Crime_Status VARCHAR2(10) CHECK (Crime_Status IN ('Open', 'Closed')),
    Date_Solved DATE,

    FOREIGN KEY (Recorded_By)  REFERENCES Officer(Police_ID),
    FOREIGN KEY (Inspector_ID) REFERENCES Inspector(Police_ID),
    FOREIGN KEY (Detective_ID) REFERENCES Detective(Police_ID)
);


CREATE TABLE Investigation(
    Investigation_ID NUMBER(4) PRIMARY KEY,
    Crime_ID NUMBER(4),
    Police_ID NUMBER(4),
    Start_Date DATE,
    End_Date DATE,
    Status VARCHAR2(50) CHECK (Status IN ('Ongoing', 'Completed', 'Suspended')),
    FOREIGN KEY (Crime_ID) REFERENCES Crime(Crime_ID),
    FOREIGN KEY (Police_ID) REFERENCES Police_Personnel(Police_ID)
);


CREATE TABLE Evidence (

    Evidence_ID NUMBER(4) PRIMARY KEY,
    Crime_ID NUMBER,
    Description VARCHAR(255),
    Evidence_Type VARCHAR(50),
    FOREIGN KEY (Crime_ID) REFERENCES Crime(Crime_ID)

);


CREATE TABLE Crime_Person (
    
    Crime_ID NUMBER(4),
    Person_ID NUMBER(4),
    Role VARCHAR2(20) CHECK (Role IN ('Offender', 'Witness', 'Victim')),
    Criminal_Record VARCHAR2(500),
    Witness_Statement VARCHAR2(100),
    Injury_Details VARCHAR2(200),
    PRIMARY KEY (Crime_ID, Person_ID),
    FOREIGN KEY (Crime_ID) REFERENCES Crime(Crime_ID),
    FOREIGN KEY (Person_ID) REFERENCES Person(Person_ID)
);

CREATE TABLE Officer(
    Police_ID NUMBER(4) PRIMARY KEY,
    FOREIGN KEY (Police_ID) REFERENCES Police_Personnel(Police_ID)
);

CREATE TABLE Inspector(
    Police_ID NUMBER(4) PRIMARY KEY,
    FOREIGN KEY (Police_ID) REFERENCES Police_Personnel(Police_ID)
);

CREATE TABLE Detective(
    Police_ID NUMBER(4) PRIMARY KEY,
    FOREIGN KEY (Police_ID) REFERENCES Police_Personnel(Police_ID)
);


-- SEQUENCES 


--for crime code and crime id

CREATE SEQUENCE crime_seq
START WITH 206
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE crimecode_seq
START WITH 17
INCREMENT BY 1
NOCACHE;

--For investigation:

CREATE SEQUENCE investigation_seq
START WITH 6
INCREMENT BY 1
NOCACHE;

-- for evidence id

CREATE SEQUENCE seq_evidence_id
START WITH 8
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- for the person_id
CREATE SEQUENCE person_seq
START WITH 21
INCREMENT BY 1
NOCACHE;

--DATA 

INSERT INTO Police_Personnel (Police_ID, Police_Name,Phone)VALUES (1, 'Steve Dune', '9800000001');
INSERT INTO Police_Personnel (Police_ID, Police_Name, Phone)VALUES (2, 'Henry Miller', '9800000002');
INSERT INTO Police_Personnel (Police_ID, Police_Name, Phone)VALUES (3, 'Clover Jake', '9800000003');
INSERT INTO Police_Personnel (Police_ID, Police_Name, Phone)VALUES (4, 'Millie Rose', '9800000004');
INSERT INTO Police_Personnel (Police_ID, Police_Name, Phone)VALUES (5, 'Johnas Ben', '9800000005');
INSERT INTO Police_Personnel (Police_ID, Police_Name, Phone)VALUES (6, 'Saira Cole','9800000006');
INSERT INTO Police_Personnel (Police_ID, Police_Name, Phone)VALUES (7, 'Groot Cole', '9800000007');


ALTER TABLE Police_Personnel ADD Role VARCHAR2(20);

UPDATE Police_Personnel SET Role = 'Inspector' WHERE Police_ID IN (1,6,7);
UPDATE Police_Personnel SET Role = 'Officer' WHERE Police_ID IN (3,5);
UPDATE Police_Personnel SET Role = 'Detective' WHERE Police_ID IN (2,4);


INSERT INTO Person (Person_ID, Full_Name, Phone, Address)VALUES(1, 'Ben Simmons', '9811111111', 'Leeds');
INSERT INTO Person (Person_ID, Full_Name, Phone, Address)VALUES(2, 'Emily Wilson', '9811119870', 'Soho');
INSERT INTO Person (Person_ID, Full_Name, Phone, Address)VALUES(3, 'Noah Smith', '9811114356', 'Brixton');
INSERT INTO Person (Person_ID, Full_Name, Phone, Address)VALUES(4, 'Bobby Brown', '9815689111', 'Mayfair');
INSERT INTO Person (Person_ID, Full_Name, Phone, Address)VALUES(5, 'Carl Carter', '9823461111', 'Kensington');
INSERT INTO Person (Person_ID, Full_Name, Phone, Address)VALUES(6, 'Davis Brown', '9811170931', 'Clapham');
INSERT INTO Person (Person_ID, Full_Name, Phone, Address)VALUES(7, 'Oscar Taylor', '9811457811', 'Westminster');

INSERT INTO Crime(Crime_ID, Crime_Code, Crime_Type, Crime_Date, Crime_Location,Severity_Level, Recorded_By, Inspector_ID, Detective_ID, Crime_Status, Date_Solved) VALUES(101, 'C001', 'Burglary', TO_DATE('08-12-2025','MM-DD-YYYY'), 'Leeds', 'High', 3, 1, 2, 'Open', NULL);
INSERT INTO Crime(Crime_ID, Crime_Code, Crime_Type, Crime_Date, Crime_Location,Severity_Level, Recorded_By, Inspector_ID, Detective_ID, Crime_Status, Date_Solved)VALUES(102, 'C002', 'Fraud', TO_DATE('07-16-2025','MM-DD-YYYY'), 'Westminster', 'Medium', 3, 6, 4, 'Closed', TO_DATE('07-20-2025','MM-DD-YYYY'));
INSERT INTO Crime(Crime_ID, Crime_Code, Crime_Type, Crime_Date, Crime_Location,Severity_Level, Recorded_By, Inspector_ID, Detective_ID, Crime_Status, Date_Solved) VALUES(103, 'C003', 'Arson', TO_DATE('03-11-2025','MM-DD-YYYY'), 'Soho', 'High', 5, 7, 2, 'Open', NULL);
INSERT INTO Crime(Crime_ID, Crime_Code, Crime_Type, Crime_Date, Crime_Location,Severity_Level, Recorded_By, Inspector_ID, Detective_ID, Crime_Status, Date_Solved) VALUES(104, 'C004', 'Cybercrime', TO_DATE('08-03-2025','MM-DD-YYYY'), 'Leeds', 'Medium', 3, 7, 4, 'Closed', TO_DATE('08-10-2025','MM-DD-YYYY'));
INSERT INTO Crime(Crime_ID, Crime_Code, Crime_Type, Crime_Date, Crime_Location,Severity_Level, Recorded_By, Inspector_ID, Detective_ID, Crime_Status, Date_Solved)VALUES(105, 'C005', 'Robbery', TO_DATE('01-01-2025','MM-DD-YYYY'), 'Kensington', 'High', 5, 6, 4, 'Open', NULL);
INSERT INTO Crime(Crime_ID, Crime_Code, Crime_Type, Crime_Date, Crime_Location,Severity_Level, Recorded_By, Inspector_ID, Detective_ID, Crime_Status, Date_Solved) VALUES(106, 'C006', 'Assault', TO_DATE('05-23-2025','MM-DD-YYYY'), 'Brixton', 'Medium', 3, 1, 2, 'Closed', TO_DATE('05-25-2025','MM-DD-YYYY'));
INSERT INTO Crime(Crime_ID, Crime_Code, Crime_Type, Crime_Date, Crime_Location, Severity_Level, Recorded_By, Inspector_ID, Detective_ID, Crime_Status, Date_Solved) VALUES(107, 'C007', 'Burglary', TO_DATE('09-08-2025','MM-DD-YYYY'), 'Clapham', 'High', 5, 6, 2, 'Open', NULL);
INSERT INTO Crime(Crime_ID, Crime_Code, Crime_Type, Crime_Date, Crime_Location, Severity_Level, Recorded_By, Inspector_ID, Detective_ID, Crime_Status, Date_Solved)VALUES (201, 'C008', 'Burglary', TO_DATE('03-15-2024','MM-DD-YYYY'), 'Leeds', 'High', 3, 1, 2, 'Closed', TO_DATE('03-20-2024','MM-DD-YYYY'));
INSERT INTO Crime(Crime_ID, Crime_Code, Crime_Type, Crime_Date, Crime_Location, Severity_Level, Recorded_By, Inspector_ID, Detective_ID, Crime_Status, Date_Solved)VALUES (202, 'C008', 'Burglary', TO_DATE('07-10-2024','MM-DD-YYYY'), 'Birmingham', 'Medium', 3, 6, 4, 'Closed', TO_DATE('07-15-2024','MM-DD-YYYY'));
INSERT INTO Crime(Crime_ID, Crime_Code, Crime_Type, Crime_Date, Crime_Location,Severity_Level, Recorded_By, Inspector_ID, Detective_ID, Crime_Status, Date_Solved) VALUES(203, 'C010', 'Fraud', TO_DATE('03-12-2025','MM-DD-YYYY'), 'Leeds', 'High', 3, 1, 2, 'Open', NULL);
INSERT INTO Crime(Crime_ID, Crime_Code, Crime_Type, Crime_Date, Crime_Location,Severity_Level, Recorded_By, Inspector_ID, Detective_ID, Crime_Status, Date_Solved) VALUES(204, 'C011', 'Cybercrime', TO_DATE('08-11-2025','MM-DD-YYYY'), 'Leeds', 'High', 3, 1, 2, 'Open', NULL);
INSERT INTO Crime(Crime_ID, Crime_Code, Crime_Type, Crime_Date, Crime_Location,Severity_Level, Recorded_By, Inspector_ID, Detective_ID, Crime_Status, Date_Solved) VALUES(205, 'C012', 'Robbery', TO_DATE('01-08-2025','MM-DD-YYYY'), 'Birmingham', 'High', 3, 1, 2, 'Open', NULL);

INSERT INTO Investigation (Investigation_ID, Crime_ID, Police_ID, Start_Date, End_Date, Status)VALUES (1, 101, 2, TO_DATE('2025-08-13','YYYY-MM-DD'), TO_DATE('2025-08-20','YYYY-MM-DD'), 'Completed');
INSERT INTO Investigation (Investigation_ID, Crime_ID, Police_ID, Start_Date, End_Date, Status)VALUES (2, 102, 4, TO_DATE('2025-07-17','YYYY-MM-DD'), TO_DATE('2025-07-25','YYYY-MM-DD'), 'Completed');
INSERT INTO Investigation (Investigation_ID, Crime_ID, Police_ID, Start_Date, End_Date, Status)VALUES (3, 103, 1, TO_DATE('2025-03-12','YYYY-MM-DD'), NULL, 'Ongoing');
INSERT INTO Investigation (Investigation_ID, Crime_ID, Police_ID, Start_Date, End_Date, Status)VALUES (4, 104, 6, TO_DATE('2025-08-04','YYYY-MM-DD'), TO_DATE('2025-08-12','YYYY-MM-DD'), 'Completed');
INSERT INTO Investigation (Investigation_ID, Crime_ID, Police_ID, Start_Date, End_Date, Status)VALUES (5, 105, 7, TO_DATE('2025-01-02','YYYY-MM-DD'), NULL, 'Ongoing');
INSERT INTO Investigation (Investigation_ID, Crime_ID, Police_ID, Start_Date, End_Date, Status)VALUES (6, 106, 2, TO_DATE('2025-05-24','YYYY-MM-DD'), TO_DATE('2025-05-30','YYYY-MM-DD'), 'Completed');
INSERT INTO Investigation (Investigation_ID, Crime_ID, Police_ID, Start_Date, End_Date, Status)VALUES (7, 107, 4, TO_DATE('2025-09-09','YYYY-MM-DD'), NULL, 'Ongoing');

INSERT INTO Evidence (Evidence_ID, Crime_ID, Description, Evidence_Type) VALUES (1, 101, 'Broken window', 'Physical');
INSERT INTO Evidence (Evidence_ID, Crime_ID, Description, Evidence_Type) VALUES (2, 102, 'Fingerprint on glass', 'Forensic');
INSERT INTO Evidence (Evidence_ID, Crime_ID, Description, Evidence_Type) VALUES (3, 103, 'Burn patterns report', 'Forensic');
INSERT INTO Evidence (Evidence_ID, Crime_ID, Description, Evidence_Type) VALUES (4, 104, 'Fake documents', 'Digital');
INSERT INTO Evidence (Evidence_ID, Crime_ID, Description, Evidence_Type) VALUES (5, 105, 'Footprints avalible ', 'Forensic');
INSERT INTO Evidence (Evidence_ID, Crime_ID, Description, Evidence_Type) VALUES (6, 106, 'Audio recording', 'Audio');
INSERT INTO Evidence (Evidence_ID, Crime_ID, Description, Evidence_Type) VALUES (7, 107, 'CCTV footage', 'Video');


INSERT INTO Crime_Person (Crime_ID, Person_ID, Role,Criminal_Record)VALUES (101, 1, 'Offender', 'Repeat Offender');
INSERT INTO Crime_Person (Crime_ID, Person_ID, Role,Witness_Statement)VALUES (102, 2, 'Witness', 'Saw the suspect near the shop');
INSERT INTO Crime_Person (Crime_ID,Person_ID,Role,Injury_Details) VALUES ( 103, 3, 'Victim','Second degree burns in hands and legs' );
INSERT INTO Crime_Person (Crime_ID,Person_ID,Role,Witness_Statement) VALUES ( 104, 4, 'Witness','Heard screaming and noises near crime scene');
INSERT INTO Crime_Person (Crime_ID,Person_ID,Role,Injury_Details) VALUES ( 105, 5, 'Victim','No injury');
INSERT INTO Crime_Person (Crime_ID,Person_ID,Role,Criminal_Record) VALUES ( 106, 6, 'Offender','First Time Offender');
INSERT INTO Crime_Person (Crime_ID,Person_ID,Role,Injury_Details) VALUES ( 107, 7, 'Victim','Cut in arms');
INSERT INTO Crime_Person (Crime_ID, Person_ID, Role,Witness_Statement) VALUES (102, 3, 'Witness','Present in the crime area and saw the face of offender');
INSERT INTO Crime_Person (Crime_ID, Person_ID, Role,Witness_Statement) VALUES (104, 5, 'Witness','Saw the online scam while checking system');
INSERT INTO Crime_Person (Crime_ID, Person_ID, Role,Witness_Statement) VALUES (105, 2, 'Witness','saw masked man entering the house');

-- TRIGGERS

--Then trigger for the crime id 

CREATE OR REPLACE TRIGGER trig_crime_bi
BEFORE INSERT ON crime
FOR EACH ROW
BEGIN
  IF :NEW.crime_id IS NULL THEN
    :NEW.crime_id := crime_seq.NEXTVAL;
  END IF;
END;



--for crime code


CREATE OR REPLACE TRIGGER trig_crime_code
BEFORE INSERT ON crime
FOR EACH ROW
BEGIN
   IF :NEW.crime_code IS NULL THEN
      :NEW.crime_code :=
         'C' || LPAD(crimecode_seq.NEXTVAL, 3, '0');
   END IF;
END;



--For investigation:

CREATE OR REPLACE TRIGGER trig_investigation_bi
BEFORE INSERT ON investigation
FOR EACH ROW
BEGIN
  IF :NEW.investigation_id IS NULL THEN
    :NEW.investigation_id := investigation_seq.NEXTVAL;
  END IF;
END;



--trigger for evidence id

CREATE OR REPLACE TRIGGER trig_auto_evidence_id
BEFORE INSERT ON evidence
FOR EACH ROW
BEGIN
  IF :NEW.evidence_id IS NULL THEN
    SELECT seq_evidence_id.NEXTVAL
    INTO :NEW.evidence_id
    FROM dual;
  END IF;
END;


ALTER TABLE evidence
MODIFY evidence_id NOT NULL;



--trigger for crime date cannot be in future

CREATE OR REPLACE TRIGGER trig_check_crimedate
BEFORE INSERT OR UPDATE ON crime
FOR EACH ROW
BEGIN
  IF :NEW.crime_date > TRUNC(SYSDATE) THEN
    RAISE_APPLICATION_ERROR(
      -20001,
      'Crime date cannot be in the future.'
    );
  END IF;
END;

--trigger for the person_id

CREATE OR REPLACE TRIGGER trig_person_bi
BEFORE INSERT ON person
FOR EACH ROW
BEGIN
  IF :NEW.person_id IS NULL THEN
    :NEW.person_id := person_seq.NEXTVAL;
  END IF;
END;





--Trigger 1: To auto start investigation afetr inserting the data in crime.

DROP TRIGGER trig_auto_start_investigation;
CREATE OR REPLACE TRIGGER trig_auto_start_investigation
AFTER INSERT ON crime
FOR EACH ROW
DECLARE
  v_new_investigation_id NUMBER;
  v_police_id NUMBER;
BEGIN
  -- severity levels
  IF :NEW.severity_level IN ('High', 'Low', 'Medium') THEN
    
    -- Get the next unique investigation_id from the sequence
    v_new_investigation_id := investigation_seq.NEXTVAL;

    -- Assign a (Detective) randomly or in sequence , the police id reference
    -- Example: randomly pick 2 or 4
    v_police_id := CASE
                      WHEN DBMS_RANDOM.VALUE(0,1) < 0.5 THEN 2
                      ELSE 4
                   END;
    
    -- Insert a new investigation linked to this crime
    INSERT INTO investigation (
      investigation_id,
      crime_id,
      police_id,
      status,
      start_date
    ) VALUES (
      v_new_investigation_id,
      :NEW.crime_id,   
      v_police_id,       -- assigned Detective
      'Ongoing',       
      SYSDATE
    );
    
  END IF;

EXCEPTION
  WHEN OTHERS THEN
    -- Catch any error and show meaningful message
    RAISE_APPLICATION_ERROR(
      -20001,
      'Error in trig_auto_start_investigation: ' || SQLERRM
    );
END;


--testing trigger 

INSERT INTO Crime( Crime_Code, Crime_Type, Crime_Date, Crime_Location,Severity_Level, Recorded_By, Inspector_ID, Crime_Status, Date_Solved)
VALUES( 'C014', 'Fraud', TO_DATE('12-16-2024','MM-DD-YYYY'), 'Leeds', 'Medium', 3, 1, 'Open', NULL);

SELECT *
FROM investigation
WHERE crime_id = (SELECT crime_id FROM crime WHERE crime_code = 'C014');






--Trigger 2 :Crime status management 

DROP TRIGGER trig_update_investigation_status;
CREATE OR REPLACE TRIGGER trig_update_investigation_status
AFTER UPDATE OF crime_status ON crime
FOR EACH ROW
BEGIN
  IF TRIM(UPPER(:OLD.crime_status)) = 'OPEN' AND TRIM(UPPER(:NEW.crime_status)) = 'CLOSED' THEN
    UPDATE investigation
    SET status = 'Completed',
        end_date = SYSDATE
    WHERE crime_id = :NEW.crime_id
      AND (status <> 'Completed' OR end_date IS NULL);
  END IF;
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(
      -20002,
      'Error in trig_update_investigation_status: ' || SQLERRM
    );
END;


--testing trigger 
UPDATE crime
SET Crime_Status = 'Closed'  
WHERE crime_code= 'C014';


SELECT investigation_id, status, end_date
FROM investigation
WHERE crime_ID = 212;

SELECT* FROM CRIME;
DESC investigation;

SELECT * FROM CRIME;



--Trigger 3: Prevent Closing Investigation Without Evidence
--Ensures at least one evidence exists before closing investigation.

CREATE OR REPLACE TRIGGER trig_no_close_without_evidence
BEFORE UPDATE OF status ON investigation
FOR EACH ROW
WHEN (NEW.status = 'Closed')
DECLARE
    v_evidence_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_evidence_count
    FROM evidence
    WHERE crime_id = :NEW.crime_id;

    IF v_evidence_count = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20003,
            'Investigation cannot be closed without recorded evidence.'
        );
    END IF;
END;

--testing trigger 
UPDATE investigation
SET status = 'Closed'
WHERE investigation_id = 9;








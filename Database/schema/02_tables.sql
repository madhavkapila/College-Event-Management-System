-- Create all tables for the College Event Management System

-- ORGANISER Table
CREATE TABLE ORGANISER (
    id VARCHAR2(10) PRIMARY KEY,
    organiser_name VARCHAR2(100) NOT NULL,
    contact VARCHAR2(15) UNIQUE NOT NULL,
    faculty_representative VARCHAR2(50),
    CONSTRAINT chk_contact CHECK (REGEXP_LIKE(contact, '^[0-9]{10,15}$'))
);

-- EVENT Table
CREATE TABLE EVENT (
    id VARCHAR2(10) PRIMARY KEY,
    event_name VARCHAR2(100) NOT NULL,
    event_type VARCHAR2(25),
    start_date DATE,
    end_date DATE,
    starting_time TIMESTAMP,
    ending_time TIMESTAMP,
    CONSTRAINT chk_dates CHECK (end_date >= start_date),
    CONSTRAINT chk_times CHECK (ending_time >= starting_time)
);

-- ORGANISED_BY Table
CREATE TABLE ORGANISED_BY (
    o_id VARCHAR2(10) NOT NULL,
    e_id VARCHAR2(10) NOT NULL,
    event_description VARCHAR2(1000),
    PRIMARY KEY (o_id, e_id),
    FOREIGN KEY (o_id) REFERENCES ORGANISER(id) ON DELETE CASCADE, 
    FOREIGN KEY (e_id) REFERENCES EVENT(id) ON DELETE CASCADE
);

-- BUDGET Table
CREATE TABLE BUDGET (
    o_id VARCHAR2(10) NOT NULL,
    e_id VARCHAR2(10) NOT NULL,
    left_available NUMBER(10,2) NOT NULL,
    needed NUMBER(10,2),
    marketing_fund NUMBER(10,2),
    donation_college NUMBER(10,2),
    PRIMARY KEY (o_id, e_id),
    FOREIGN KEY (o_id) REFERENCES ORGANISER(id) ON DELETE CASCADE,
    FOREIGN KEY (e_id) REFERENCES EVENT(id) ON DELETE CASCADE,
    CONSTRAINT chk_budget_positive CHECK (left_available >= 0 AND needed >= 0 AND marketing_fund >= 0 AND donation_college >= 0)
);

-- PERMISSION_SCHEDULE Table
CREATE TABLE PERMISSION_SCHEDULE (
    venue VARCHAR2(50) NOT NULL,
    starting_time TIMESTAMP NOT NULL,
    ending_time TIMESTAMP NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    headcount NUMBER,
    representative_name VARCHAR2(50),
    representative_id VARCHAR2(25) NOT NULL,
    o_id VARCHAR2(10),
    PRIMARY KEY (venue, starting_time, ending_time, start_date, end_date),
    FOREIGN KEY (o_id) REFERENCES ORGANISER(id) ON DELETE SET NULL,
    CONSTRAINT chk_perm_dates CHECK (end_date >= start_date),
    CONSTRAINT chk_perm_times CHECK (ending_time >= starting_time),
    CONSTRAINT chk_headcount CHECK (headcount >= 0)
);

-- PERMISSION Table
CREATE TABLE PERMISSION (
    pid VARCHAR2(10) PRIMARY KEY,
    venue VARCHAR2(50) NOT NULL,
    starting_time TIMESTAMP NOT NULL,
    ending_time TIMESTAMP NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (venue, starting_time, ending_time, start_date, end_date)
        REFERENCES PERMISSION_SCHEDULE(venue, starting_time, ending_time, start_date, end_date)
        ON DELETE CASCADE
);

PROMPT Tables created successfully.

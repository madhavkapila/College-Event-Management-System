-- PL/SQL Package Body Implementation for the College Event Management System

CREATE OR REPLACE PACKAGE BODY event_management_pkg AS
    
    -- Add a new organiser
    PROCEDURE add_organiser(p_name IN VARCHAR2, p_contact IN VARCHAR2, p_faculty_rep IN VARCHAR2) AS
    BEGIN
        INSERT INTO ORGANISER (organiser_name, contact, faculty_representative)
        VALUES (p_name, p_contact, p_faculty_rep);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20003, 'Error adding organiser: ' || SQLERRM);
    END;

    -- Add a new event
    PROCEDURE add_event(p_event_name IN VARCHAR2, p_event_type IN VARCHAR2, p_start_date IN DATE, p_end_date IN DATE, p_starting_time IN TIMESTAMP, p_ending_time IN TIMESTAMP) AS
    BEGIN
        INSERT INTO EVENT (event_name, event_type, start_date, end_date, starting_time, ending_time)
        VALUES (p_event_name, p_event_type, p_start_date, p_end_date, p_starting_time, p_ending_time);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20004, 'Error adding event: ' || SQLERRM);
    END;

    -- Link organiser to event
    PROCEDURE link_organiser_event(p_o_id IN VARCHAR2, p_e_id IN VARCHAR2, p_description IN VARCHAR2) AS
    BEGIN
        INSERT INTO ORGANISED_BY (o_id, e_id, event_description)
        VALUES (p_o_id, p_e_id, p_description);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20005, 'Error linking organiser and event: ' || SQLERRM);
    END;

    -- Add budget information
    PROCEDURE add_budget(p_o_id IN VARCHAR2, p_e_id IN VARCHAR2, p_left_available IN NUMBER, p_needed IN NUMBER, p_marketing_fund IN NUMBER, p_donation_college IN NUMBER) AS
    BEGIN
        INSERT INTO BUDGET (o_id, e_id, left_available, needed, marketing_fund, donation_college)
        VALUES (p_o_id, p_e_id, p_left_available, p_needed, p_marketing_fund, p_donation_college);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20006, 'Error adding budget: ' || SQLERRM);
    END;

    -- Request permission for venue
    PROCEDURE request_permission(p_venue IN VARCHAR2, p_starting_time IN TIMESTAMP, p_ending_time IN TIMESTAMP, p_start_date IN DATE, 
                                 p_end_date IN DATE, p_headcount IN NUMBER, p_rep_name IN VARCHAR2, p_rep_id IN VARCHAR2, p_o_id IN VARCHAR2) AS
    BEGIN
        INSERT INTO PERMISSION_SCHEDULE (venue, starting_time, ending_time, start_date, end_date, headcount, representative_name, representative_id, o_id)
        VALUES (p_venue, p_starting_time, p_ending_time, p_start_date, p_end_date, p_headcount, p_rep_name, p_rep_id, p_o_id);
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20007, 'Error requesting permission: ' || SQLERRM);
    END;

    -- Get budget status for an event
    FUNCTION get_budget_status(p_e_id IN VARCHAR2) RETURN VARCHAR2 AS
        v_left NUMBER(10,2);
        v_needed NUMBER(10,2);
    BEGIN
        SELECT left_available, needed INTO v_left, v_needed
        FROM BUDGET
        WHERE e_id = p_e_id;

        IF v_left >= v_needed THEN
            RETURN 'Sufficient';
        ELSE
            RETURN 'Insufficient';
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 'Budget not found';
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20009, 'Error retrieving budget status: ' || SQLERRM);
    END;
    
END event_management_pkg;
/

SHOW ERRORS PACKAGE BODY event_management_pkg;

PROMPT Package body created successfully.

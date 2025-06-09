-- Standalone procedures for the College Event Management System

-- Search organisers by name (utility procedure)
CREATE OR REPLACE PROCEDURE search_organisers_by_name (
    p_search_text IN VARCHAR2
) AS
    CURSOR organiser_cursor IS
        SELECT id, organiser_name
        FROM ORGANISER
        WHERE LOWER(organiser_name) LIKE '%' || LOWER(p_search_text) || '%';

    v_id   ORGANISER.id%TYPE;
    v_name ORGANISER.organiser_name%TYPE;
BEGIN
    OPEN organiser_cursor;
    LOOP
        FETCH organiser_cursor INTO v_id, v_name;
        EXIT WHEN organiser_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ' | Name: ' || v_name);
    END LOOP;
    CLOSE organiser_cursor;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20010, 'Error in search_organisers_by_name: ' || SQLERRM);
END;
/

-- Search events by name (utility procedure)
CREATE OR REPLACE PROCEDURE search_events_by_name (
    p_search_text IN VARCHAR2
) AS
    CURSOR event_cursor IS
        SELECT id, event_name, event_type 
        FROM EVENT
        WHERE LOWER(event_name) LIKE '%' || LOWER(p_search_text) || '%';

    v_id   EVENT.id%TYPE;
    v_name EVENT.event_name%TYPE;
    v_type EVENT.event_type%TYPE;
BEGIN
    OPEN event_cursor;
    LOOP
        FETCH event_cursor INTO v_id, v_name, v_type;
        EXIT WHEN event_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ' | Name: ' || v_name || ' | Type: ' || v_type);
    END LOOP;
    CLOSE event_cursor;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20011, 'Error in search_events_by_name: ' || SQLERRM);
END;
/

PROMPT Standalone procedures created successfully.

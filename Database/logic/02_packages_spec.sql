-- PL/SQL Package Specifications for the College Event Management System

-- Main event management package specification
CREATE OR REPLACE PACKAGE event_management_pkg AS
    -- Core event management procedures
    PROCEDURE add_organiser(p_name IN VARCHAR2, p_contact IN VARCHAR2, p_faculty_rep IN VARCHAR2);
    PROCEDURE add_event(p_event_name IN VARCHAR2, p_event_type IN VARCHAR2, p_start_date IN DATE, p_end_date IN DATE, p_starting_time IN TIMESTAMP, p_ending_time IN TIMESTAMP);
    PROCEDURE link_organiser_event(p_o_id IN VARCHAR2, p_e_id IN VARCHAR2, p_description IN VARCHAR2);
    
    -- Budget management procedures
    PROCEDURE add_budget(p_o_id IN VARCHAR2, p_e_id IN VARCHAR2, p_left_available IN NUMBER, p_needed IN NUMBER, p_marketing_fund IN NUMBER, p_donation_college IN NUMBER);
    
    -- Permission management procedures
    PROCEDURE request_permission(p_venue IN VARCHAR2, p_starting_time IN TIMESTAMP, 
                                p_ending_time IN TIMESTAMP, p_start_date IN DATE, p_end_date IN DATE, 
                                p_headcount IN NUMBER, p_rep_name IN VARCHAR2, p_rep_id IN VARCHAR2, p_o_id IN VARCHAR2);
    
    -- Utility functions
    FUNCTION get_budget_status(p_e_id IN VARCHAR2) RETURN VARCHAR2;
END event_management_pkg;
/

PROMPT Package specifications created successfully.

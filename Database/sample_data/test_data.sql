-- Sample test data for the College Event Management System

-- Enable DBMS_OUTPUT for testing
SET SERVEROUTPUT ON;

-- Test Execution Block 1: Add Organisers
BEGIN
  event_management_pkg.add_organiser('Microsoft Learn Student Chapter MLSC', '9988776655', 'Dr. Rana');
  event_management_pkg.add_organiser('ACM', '9998776655', 'Dr. Kumar');
  event_management_pkg.add_organiser('Creative Computing Society CCS', '9988776665', 'Dr. Bala');
  event_management_pkg.add_organiser('Google Developer Students Club TIET GDSC', '9988777655', 'Dr. Singh');
END;
/

SELECT * FROM ORGANISER;

-- Test Execution Block 2: Add Events
BEGIN
  event_management_pkg.add_event(
    p_event_name => 'Helix',
    p_event_type => 'Techfest TIET',
    p_start_date => DATE '2025-02-01',
    p_end_date => DATE '2025-02-15',
    p_starting_time => TO_TIMESTAMP('2025-01-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
    p_ending_time => TO_TIMESTAMP('2025-03-15 23:59:59', 'YYYY-MM-DD HH24:MI:SS')
  );

  event_management_pkg.add_event(
    p_event_name => 'Hackspire',
    p_event_type => 'Hackathon',
    p_start_date => DATE '2025-04-23',
    p_end_date => DATE '2025-04-28',
    p_starting_time => TO_TIMESTAMP('2025-04-23 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
    p_ending_time => TO_TIMESTAMP('2025-04-28 17:30:00', 'YYYY-MM-DD HH24:MI:SS')
  );
END;
/

SELECT * FROM EVENT;

-- Search functionality tests
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Searching Organisers ---');
    search_organisers_by_name('Microsoft');
    search_organisers_by_name('ACM');
    search_organisers_by_name('CCS');
    search_organisers_by_name('Google');
    
    DBMS_OUTPUT.PUT_LINE('--- Searching Events ---');
    search_events_by_name('Helix');
    search_events_by_name('Hackspire');
END;
/

-- Test Execution Block 3: Link Organiser and Event
-- Note: You may need to adjust the IDs based on actual generated values
BEGIN
  event_management_pkg.link_organiser_event(
    p_o_id => 'ORG0004',
    p_e_id => 'EVT0001',
    p_description => 'Main Coordinator for TechFest'
  );

  event_management_pkg.link_organiser_event(
    p_o_id => 'ORG0001',
    p_e_id => 'EVT0001',
    p_description => 'Joint Organiser for TechFest'
  );

  event_management_pkg.link_organiser_event(
    p_o_id => 'ORG0001',
    p_e_id => 'EVT0002',
    p_description => 'Joint Organiser for Hackspire'
  );
  
  event_management_pkg.link_organiser_event(
    p_o_id => 'ORG0003',
    p_e_id => 'EVT0002',
    p_description => 'Joint Organiser for Hackspire'
  );
END;
/

SELECT * FROM ORGANISED_BY;

-- Test Execution Block 4: Add Budget for Events
BEGIN
  event_management_pkg.add_budget(
    p_o_id => 'ORG0004',
    p_e_id => 'EVT0001',
    p_left_available => 600000,
    p_needed => 500000,
    p_marketing_fund => 700000,
    p_donation_college => 300000
  );

  event_management_pkg.add_budget(
    p_o_id => 'ORG0001',
    p_e_id => 'EVT0002',
    p_left_available => 150000,
    p_needed => 100000,
    p_marketing_fund => 175000,
    p_donation_college => 25000
  );
END;
/

SELECT * FROM BUDGET;

-- Test Execution Block 5: Request Permissions for Both Events
BEGIN
  event_management_pkg.request_permission(
    p_venue => 'Auditorium',
    p_starting_time => TO_TIMESTAMP('2025-09-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),
    p_ending_time   => TO_TIMESTAMP('2025-09-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'),
    p_start_date => DATE '2025-09-10',
    p_end_date   => DATE '2025-09-12',
    p_headcount => 300,
    p_rep_name => 'Ram Sharma',
    p_rep_id => 'REP001',
    p_o_id => 'ORG0004'
  );

  event_management_pkg.request_permission(
    p_venue => 'Lab 101',
    p_starting_time => TO_TIMESTAMP('2025-09-15 14:00:00', 'YYYY-MM-DD HH24:MI:SS'),
    p_ending_time   => TO_TIMESTAMP('2025-09-15 16:30:00', 'YYYY-MM-DD HH24:MI:SS'),
    p_start_date => DATE '2025-09-15',
    p_end_date   => DATE '2025-09-15',
    p_headcount => 80,
    p_rep_name => 'John Doe',
    p_rep_id => 'REP002',
    p_o_id => 'ORG0001'
  );
END;
/

SELECT * FROM PERMISSION_SCHEDULE;
SELECT * FROM PERMISSION;

-- Test Execution Block 6: Check Budget Status
DECLARE
  result VARCHAR2(100);
BEGIN
  result := event_management_pkg.get_budget_status('EVT0001');
  DBMS_OUTPUT.PUT_LINE('Tech Fest Budget Status: ' || result);

  result := event_management_pkg.get_budget_status('EVT0002');
  DBMS_OUTPUT.PUT_LINE('AI Workshop Budget Status: ' || result);
END;
/

PROMPT Test data insertion completed.

-- File: Database/tools/event_mgmt_cli.sql
-- Interactive CLI for event_management_pkg (SQL*Plus / SQLcl)
-- Run through sql your_user/your_pass@//host:1521/your_service @Database/tools/event_mgmt_cli.sql

SET SERVEROUTPUT ON
SET ECHO OFF
SET VERIFY OFF

PROMPT
PROMPT === College Event Management CLI ===
PROMPT 1) Add Organiser
PROMPT 2) Search Organiser by Name
PROMPT 3) Add Event
PROMPT 4) Search Event by Name
PROMPT 5) Link Organiser & Event
PROMPT 6) Add Budget
PROMPT 7) Request Permission
PROMPT 8) Check Budget Status
PROMPT 9) Bulk‑Load Sample Data
PROMPT 0) Exit
PROMPT

ACCEPT choice PROMPT 'Choose> '
EXIT WHEN '&choice' = '0'

-- 1) Add Organiser
ACCEPT p_name    CHAR PROMPT 'Enter organiser name: '
ACCEPT p_contact CHAR PROMPT 'Enter contact       : '
ACCEPT p_faculty CHAR PROMPT 'Enter faculty rep  : '
BEGIN
  IF '&choice' = '1' THEN
    event_management_pkg.add_organiser(
      p_name        => '&p_name',
      p_contact     => '&p_contact',
      p_faculty_rep => '&p_faculty'
    );
    DBMS_OUTPUT.PUT_LINE('>> Organiser added.');
  END IF;
END;
/

-- 2) Search Organiser by Name
ACCEPT s_txt CHAR PROMPT 'Search organiser (text): '
BEGIN
  IF '&choice' = '2' THEN
    FOR r IN (
      SELECT id, organiser_name
        FROM organiser
       WHERE LOWER(organiser_name) LIKE LOWER('%&s_txt%')
    ) LOOP
      DBMS_OUTPUT.PUT_LINE(r.id || ' | ' || r.organiser_name);
    END LOOP;
  END IF;
END;
/

-- 3) Add Event
ACCEPT e_name CHAR PROMPT 'Event name              : '
ACCEPT e_type CHAR PROMPT 'Event type              : '
ACCEPT s_date CHAR PROMPT 'Start date (YYYY‑MM‑DD) : '
ACCEPT e_date CHAR PROMPT 'End   date (YYYY‑MM‑DD) : '
ACCEPT s_ts   CHAR PROMPT 'Start ts (YYYY‑MM‑DD HH24:MI:SS): '
ACCEPT e_ts   CHAR PROMPT 'End   ts (YYYY‑MM‑DD HH24:MI:SS): '
BEGIN
  IF '&choice' = '3' THEN
    event_management_pkg.add_event(
      p_event_name    => '&e_name',
      p_event_type    => '&e_type',
      p_start_date    => TO_DATE('&s_date','YYYY-MM-DD'),
      p_end_date      => TO_DATE('&e_date','YYYY-MM-DD'),
      p_starting_time => TO_TIMESTAMP('&s_ts','YYYY-MM-DD HH24:MI:SS'),
      p_ending_time   => TO_TIMESTAMP('&e_ts','YYYY-MM-DD HH24:MI:SS')
    );
    DBMS_OUTPUT.PUT_LINE('>> Event added.');
  END IF;
END;
/

-- 4) Search Event by Name
ACCEPT t_txt CHAR PROMPT 'Search event (text): '
BEGIN
  IF '&choice' = '4' THEN
    FOR r IN (
      SELECT id, event_name, event_type
        FROM event
       WHERE LOWER(event_name) LIKE LOWER('%&t_txt%')
    ) LOOP
      DBMS_OUTPUT.PUT_LINE(r.id || ' | ' || r.event_name || ' | ' || r.event_type);
    END LOOP;
  END IF;
END;
/

-- 5) Link Organiser & Event
ACCEPT lo_o CHAR PROMPT 'Organiser ID : '
ACCEPT lo_e CHAR PROMPT 'Event ID     : '
ACCEPT lo_d CHAR PROMPT 'Description  : '
BEGIN
  IF '&choice' = '5' THEN
    event_management_pkg.link_organiser_event(
      p_o_id        => '&lo_o',
      p_e_id        => '&lo_e',
      p_description => '&lo_d'
    );
    DBMS_OUTPUT.PUT_LINE('>> Linked.');
  END IF;
END;
/

-- 6) Add Budget
ACCEPT b_o  CHAR PROMPT 'Org ID           : '
ACCEPT b_e  CHAR PROMPT 'Event ID         : '
ACCEPT b_la CHAR PROMPT 'Left Available   : '
ACCEPT b_nd CHAR PROMPT 'Needed           : '
ACCEPT b_mf CHAR PROMPT 'Marketing Fund   : '
ACCEPT b_dc CHAR PROMPT 'Donation College : '
BEGIN
  IF '&choice' = '6' THEN
    event_management_pkg.add_budget(
      p_o_id           => '&b_o',
      p_e_id           => '&b_e',
      p_left_available => TO_NUMBER('&b_la'),
      p_needed         => TO_NUMBER('&b_nd'),
      p_marketing_fund => TO_NUMBER('&b_mf'),
      p_donation_college=>TO_NUMBER('&b_dc')
    );
    DBMS_OUTPUT.PUT_LINE('>> Budget added.');
  END IF;
END;
/

-- 7) Request Permission
ACCEPT r_v  CHAR PROMPT 'Venue                        : '
ACCEPT r_st CHAR PROMPT 'Start ts (YYYY‑MM‑DD HH24:MI:SS): '
ACCEPT r_et CHAR PROMPT 'End   ts (YYYY‑MM‑DD HH24:MI:SS): '
ACCEPT r_sd CHAR PROMPT 'Start date (YYYY‑MM‑DD)      : '
ACCEPT r_ed CHAR PROMPT 'End   date (YYYY‑MM‑DD)      : '
ACCEPT r_hc CHAR PROMPT 'Headcount                    : '
ACCEPT r_rn CHAR PROMPT 'Rep Name                     : '
ACCEPT r_ri CHAR PROMPT 'Rep ID                       : '
ACCEPT r_oi CHAR PROMPT 'Organiser ID                 : '
BEGIN
  IF '&choice' = '7' THEN
    event_management_pkg.request_permission(
      p_venue         => '&r_v',
      p_starting_time => TO_TIMESTAMP('&r_st','YYYY-MM-DD HH24:MI:SS'),
      p_ending_time   => TO_TIMESTAMP('&r_et','YYYY-MM-DD HH24:MI:SS'),
      p_start_date    => TO_DATE('&r_sd','YYYY-MM-DD'),
      p_end_date      => TO_DATE('&r_ed','YYYY-MM-DD'),
      p_headcount     => TO_NUMBER('&r_hc'),
      p_rep_name      => '&r_rn',
      p_rep_id        => '&r_ri',
      p_o_id          => '&r_oi'
    );
    DBMS_OUTPUT.PUT_LINE('>> Permission requested.');
  END IF;
END;
/

-- 8) Check Budget Status
ACCEPT cb_e CHAR PROMPT 'Event ID to check budget: '
BEGIN
  IF '&choice' = '8' THEN
    DECLARE
      v_status VARCHAR2(20);
    BEGIN
      v_status := event_management_pkg.get_budget_status('&cb_e');
      DBMS_OUTPUT.PUT_LINE('>> Status: ' || v_status);
    END;
  END IF;
END;
/

-- 9) Bulk‑Load Sample Data
BEGIN
  IF '&choice' = '9' THEN
    DBMS_OUTPUT.PUT_LINE('Loading sample organisers…');
    event_management_pkg.add_organiser('Microsoft Learn Student Chapter MLSC','9988776655','Dr. Rana');
    event_management_pkg.add_organiser('ACM','9998776655','Dr. Kumar');
    event_management_pkg.add_organiser('Creative Computing Society CCS','9988776665','Dr. Bala');
    event_management_pkg.add_organiser('Google Developer Students Club TIET GDSC','9988777655','Dr. Singh');
    DBMS_OUTPUT.PUT_LINE('Loading sample events…');
    event_management_pkg.add_event(
      'Helix','Techfest TIET',
      DATE '2025-02-01', DATE '2025-02-15',
      TO_TIMESTAMP('2025-01-10 10:00:00','YYYY-MM-DD HH24:MI:SS'),
      TO_TIMESTAMP('2025-03-15 23:59:59','YYYY-MM-DD HH24:MI:SS')
    );
    event_management_pkg.add_event(
      'Hackspire','Hackathon',
      DATE '2025-04-23', DATE '2025-04-28',
      TO_TIMESTAMP('2025-04-23 10:00:00','YYYY-MM-DD HH24:MI:SS'),
      TO_TIMESTAMP('2025-04-28 17:30:00','YYYY-MM-DD HH24:MI:SS')
    );
    DBMS_OUTPUT.PUT_LINE('>> Sample data loaded.');
  END IF;
END;
/

PROMPT
PROMPT ==== Done — rerun this script to perform another action ====

-- Database triggers for the College Event Management System

-- Trigger for auto-generating organiser IDs
CREATE OR REPLACE TRIGGER organiser_id_trg
BEFORE INSERT ON ORGANISER
FOR EACH ROW
BEGIN
    :NEW.id := 'ORG' || TO_CHAR(organiser_seq.NEXTVAL, 'FM0000');
END;
/

-- Trigger for auto-generating event IDs
CREATE OR REPLACE TRIGGER event_id_trg
BEFORE INSERT ON EVENT
FOR EACH ROW
BEGIN
    :NEW.id := 'EVT' || TO_CHAR(event_seq.NEXTVAL, 'FM0000');
END;
/

-- Trigger for auto-generating permission IDs
CREATE OR REPLACE TRIGGER permission_id_trg
BEFORE INSERT ON PERMISSION
FOR EACH ROW
BEGIN
  :NEW.pid := 'PERM' || TO_CHAR(permission_seq.NEXTVAL, 'FM0000');
END;
/

-- Trigger to automatically create permission records when permission schedule is created
CREATE OR REPLACE TRIGGER permission_link
AFTER INSERT ON PERMISSION_SCHEDULE
FOR EACH ROW
BEGIN
  INSERT INTO PERMISSION (
    venue,
    starting_time,
    ending_time,
    start_date,
    end_date
  )
  VALUES (
    :NEW.venue,
    :NEW.starting_time,
    :NEW.ending_time,
    :NEW.start_date,
    :NEW.end_date
  );
  -- NO COMMIT here!
END;
/

-- Trigger for budget validation on updates
CREATE OR REPLACE TRIGGER budget_update_trg
BEFORE UPDATE ON BUDGET
FOR EACH ROW
BEGIN
    IF :NEW.left_available < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Budget left cannot be negative.');
    END IF;
END;
/

PROMPT Triggers created successfully.

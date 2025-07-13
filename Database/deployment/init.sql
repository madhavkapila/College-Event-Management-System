-- Master initialization script for College Event Management System
-- This script runs all components in the correct order

-- Set environment
WHENEVER SQLERROR EXIT SQL.SQLCODE;
SET SERVEROUTPUT ON;

PROMPT =============================================
PROMPT College Event Management System - Database Setup
PROMPT =============================================

-- 1. Cleanup existing schema
PROMPT 1. Cleaning up existing schema...
@@../schema/00_cleanup.sql

-- 2. Create sequences
PROMPT 2. Creating sequences...
@@../schema/01_sequences.sql

-- 3. Create tables
PROMPT 3. Creating tables...
@@../schema/02_tables.sql

-- 4. Create triggers
PROMPT 4. Creating triggers...
@@../logic/01_triggers.sql

-- 5. Create package specifications
PROMPT 5. Creating package specifications...
@@../logic/02_packages_spec.sql

-- 6. Create package bodies
PROMPT 6. Creating package bodies...
@@../logic/03_packages_body.sql

-- 7. Create standalone procedures
PROMPT 7. Creating standalone procedures...
@@../logic/04_procedures.sql

PROMPT =============================================
PROMPT Database schema installation completed successfully!
PROMPT =============================================

-- Optional: Load sample data (uncomment if needed)
-- PROMPT 8. Loading sample data...
-- @@../sample_data/test_data.sql

PROMPT To load sample data, run: @../sample_data/test_data.sql

PROMPT To launch the interactive CLI, run:
PROMPT    SQL> @../tools/event_mgmt_cli.sql

-- If you’d prefer it to run automatically at the end of init:
-- @@../tools/event_mgmt_cli.sql

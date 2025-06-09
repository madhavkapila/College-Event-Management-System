# College Event Management System - Database Module

This directory contains the modularized database schema and logic for the College Event Management System.

## Directory Structure

```
Database/
├── schema/                 # Database structure
│   ├── 00_cleanup.sql     # Cleanup existing objects
│   ├── 01_sequences.sql   # Sequence definitions
│   └── 02_tables.sql      # Table definitions
├── logic/                 # Business logic
│   ├── 01_triggers.sql    # Database triggers
│   ├── 02_packages_spec.sql   # Package specifications
│   ├── 03_packages_body.sql   # Package implementations
│   └── 04_procedures.sql  # Standalone procedures
├── deployment/            # Deployment scripts
│   └── init.sql          # Master installation script
├── sample_data/          # Test data
│   └── test_data.sql     # Sample data insertion
└── College_Event_Management_System_PLSQL.sql  # Original monolithic file (deprecated)
```

## Installation

### Complete Installation
To install the complete database system:

```sql
-- Connect to your Oracle database as appropriate user
-- Run the master installation script
@deployment/init.sql
```

### Individual Component Installation
You can also install components individually in the following order:

1. **Cleanup** (optional, if reinstalling):
   ```sql
   @schema/00_cleanup.sql
   ```

2. **Schema Components**:
   ```sql
   @schema/01_sequences.sql
   @schema/02_tables.sql
   ```

3. **Business Logic**:
   ```sql
   @logic/01_triggers.sql
   @logic/02_packages_spec.sql
   @logic/03_packages_body.sql
   @logic/04_procedures.sql
   ```

4. **Sample Data** (optional):
   ```sql
   @sample_data/test_data.sql
   ```

## Usage

### Core Package Functions

The main business logic is encapsulated in the `event_management_pkg` package:

- `add_organiser(name, contact, faculty_rep)` - Add a new organiser
- `add_event(name, type, start_date, end_date, start_time, end_time)` - Add a new event
- `link_organiser_event(organiser_id, event_id, description)` - Link organiser to event
- `add_budget(organiser_id, event_id, left_available, needed, marketing_fund, donation_college)` - Add budget info
- `request_permission(venue, start_time, end_time, start_date, end_date, headcount, rep_name, rep_id, organiser_id)` - Request venue permission
- `get_budget_status(event_id)` - Get budget status for an event

### Utility Procedures

- `search_organisers_by_name(search_text)` - Search organisers by name
- `search_events_by_name(search_text)` - Search events by name

## Database Schema

### Main Tables

1. **ORGANISER** - Student organizations and clubs
2. **EVENT** - Events organized by the organizations
3. **ORGANISED_BY** - Many-to-many relationship between organisers and events
4. **BUDGET** - Budget information for events
5. **PERMISSION_SCHEDULE** - Permission requests for venues
6. **PERMISSION** - Approved permissions

### Key Features

- Auto-generated IDs using sequences and triggers
- Comprehensive constraint checking
- Foreign key relationships with appropriate cascade rules
- Business logic encapsulated in PL/SQL packages

## Benefits of Modularization

1. **Maintainability** - Each component can be modified independently
2. **Reusability** - Individual components can be reused in other projects
3. **Deployment Flexibility** - Install only what you need
4. **Version Control** - Better tracking of changes to specific components
5. **Team Development** - Multiple developers can work on different modules
6. **Testing** - Individual components can be tested in isolation

## Migration from Monolithic File

The original `College_Event_Management_System_PLSQL.sql` file has been preserved for reference but is now deprecated. Use the modular approach for all future development and deployment.

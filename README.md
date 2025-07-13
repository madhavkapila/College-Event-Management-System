<!DOCTYPE html>
<body>
  <h1>College Event Management System</h1>
  <p><em>Robust PL/SQL database module for managing student society events at Thapar Institute of Engineering and Technology with a clear path to full-stack integration.</em></p>

  <div class="section">
    <h2>🚀 Key Features</h2>
    <ul>
      <li><strong>Centralized Data Management</strong>: Organizers, events, budgets, and permissions maintained in a unified schema.</li>
      <li><strong>Modular Architecture</strong>: Schema, business logic, deployment scripts, and sample data clearly separated.</li>
      <li><strong>All-in-One Script</strong>: Monolithic <code>College_Event_Management_System_PLSQL.sql</code> for instant deployment on Live SQL.</li>
      <li><strong>Automated ID Generation</strong>: Oracle sequences & triggers for consistent primary keys.</li>
      <li><strong>Referential Integrity</strong>: Foreign keys with cascade rules to safeguard data relationships.</li>
      <li><strong>Encapsulated Workflows</strong>: Core logic in <code>event_management_pkg</code> package (add organizer, schedule event, request permission).</li>
      <li><strong>Sample Data</strong>: Preloaded test records for quick validation.</li>
    </ul>
  </div>

  <div class="section">
    <h2>📁 Directory Structure</h2>
    <pre><code>Database/
├── schema/                 # Schema definitions
│   ├── 00_cleanup.sql       # Drop existing objects
│   ├── 01_sequences.sql     # Sequences for ID generation
│   └── 02_tables.sql        # Table definitions & constraints
├── logic/                  # PL/SQL business logic
│   ├── 01_triggers.sql      # Audit & validation triggers
│   ├── 02_packages_spec.sql # Package specs
│   ├── 03_packages_body.sql # Package implementations
│   └── 04_procedures.sql    # Utility procedures
├── deployment/             # Deployment orchestrator
│   └── init.sql            # Runs schema & logic scripts
├── sample_data/            # Sample inserts for testing
│   └── test_data.sql       # Test data
├── tools/                  # Tools to run and manage system
│   └── event_mgmt_cli.sql  #CLI script
└── College_Event_Management_System_PLSQL.sql  # Monolithic script
</code></pre>
  </div>

  <div class="section">
    <h2>⚙️ Installation & Setup</h2>
    <h3>Prerequisites</h3>
    <ul>
      <li>Oracle Database 12c (or above)</li>
      <li>SQL*Plus, SQL Developer, or Live SQL account</li>
    </ul>
    <h3>Steps</h3>
    <ol>
      <li><code>git clone https://github.com/madhavkapila/College-Event-Management-System.git</code></li>
      <li><code>cd College-Event-Management-System/Database</code></li>
      <li><strong>Full Deploy:</strong> <code>@deployment/init.sql</code></li>
      <li><strong>Component Deploy:</strong>
        <ul>
          <li><code>@schema/00_cleanup.sql</code></li>
          <li><code>@schema/01_sequences.sql</code></li>
          <li><code>@schema/02_tables.sql</code></li>
          <li><code>@logic/01_triggers.sql</code></li>
          <li><code>@logic/02_packages_spec.sql</code></li>
          <li><code>@logic/03_packages_body.sql</code></li>
          <li><code>@logic/04_procedures.sql</code></li>
          <li>(Optional) <code>@sample_data/test_data.sql</code></li>
        </ul>
        <li><code>Run @../tools/event_mgmt_cli.sql</code></li>
      </li>
    </ol>
 

   <h3>🔹 Running on Oracle Live SQL</h3>
   <ol>
   <li><strong>Login</strong> at <a href="https://livesql.oracle.com/">https://livesql.oracle.com/</a> (create a free account if needed).</li>
     <li><strong>Create a New Script:</strong>
     <ul>
       <li>Click <strong>Your Scripts</strong> → <strong>Create Script</strong>.</li>
       <li>Name it (e.g., <code>event_mgmt_setup</code>).</li>
     </ul>
  </li>

  <li><strong>Upload or Paste Code:</strong>
    <ul>
      <li><strong>Option A:</strong> Copy the entire contents of <code>College_Event_Management_System_PLSQL.sql</code> and paste into the editor.</li>
      <li><strong>Option B:</strong> Paste individual files in order:
        <pre><code>-- Schema setup
@schema/01_sequences.sql;
@schema/02_tables.sql;

<br>
-- Business logic
@logic/01_triggers.sql;
@logic/02_packages_spec.sql;
@logic/03_packages_body.sql;
@logic/04_procedures.sql;
<br>
-- (Optional) sample data
@sample_data/test_data.sql;
        </code></pre>
      </li>
    </ul>
  </li>

  <li><strong>Run the Script:</strong> Click <strong>Run (▶️)</strong> to execute. Live SQL will process each block.</li>
</ol>

<p><strong>Note:</strong> Live SQL requires each PL/SQL block to end with a semicolon (;) or forward slash (/). The monolithic script already includes the necessary separators.</p>
 </div>


  <div class="section">
    <h2>📝 Usage Overview</h2>
    <p>All database operations are encapsulated in the <code>event_management_pkg</code> PL/SQL package. Key actions include:</p>
    <ul>
      <li><strong>Adding Organizers</strong> via <code>add_organiser</code></li>
      <li><strong>Scheduling Events</strong> via <code>add_event</code></li>
      <li><strong>Allocating Budgets</strong> via <code>add_budget</code></li>
      <li><strong>Requesting Permissions</strong> via <code>request_permission</code></li>
    </ul>
    <p>For full details, see the <code>logic/</code> folder or the monolithic script.</p>
  </div>

  <div class="section">
    <h2>🎯 Future Roadmap</h2>
    <ul>
      <li>Web Frontend (React/Angular)</li>
      <li>REST API (Node.js / Python Flask)</li>
      <li>Authentication & RBAC</li>
      <li>Analytics Dashboard</li>
      <li>CI/CD & Cloud Deployment (Oracle Cloud/AWS)</li>
    </ul>
  </div>

  <div class="section">
    <h2>👥 Contributors</h2>
    <ul>
      <li><strong>Madhav Kapila</strong> – Lead designer & implementer of full codebase, Database design, PL/SQL logic and deployment scripts</li>
      <li>Aditya Pandey – ER modelling & normalization</li>
      <li>Sneha Goswami – Testing & sample data setup</li>
      <li>Stuti Gupta – Documentation & requirements analysis</li>
    </ul>
  </div>

  <div class="section">
    <h2>📄 License</h2>
    <p>This project is licensed under the <a href="LICENSE">GNU GPL v3.0</a>.</p>
  </div>

  <div class="footer">
    <p>Crafted to highlight a complete, modular PL/SQL implementation and inspire confidence in full-stack evolution.</p>
  </div>
</body>
</html>

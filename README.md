## File Structure

```text
lib/
├── csv/
│   ├── reader.rb
│   └── writer.rb
│
├── tasks/
│   └── secret_santa.rake

app/
└── services/
    └── secret_santa/
        ├── models/
        │   ├── assignment.rb
        │   └── employee.rb
        │
        ├── rules/
        │   ├── base_rule.rb
        │   ├── no_previous_year_rule.rb
        │   └── no_self_assignment_rule.rb
        │
        ├── assignment_engine.rb
        └── generator.rb
```

### Overview

* **lib/csv/**: CSV input/output handling
* **lib/tasks/**: Rake task entry point
* **models/**: Core domain objects
* **rules/**: Business rules for assignment validation
* **assignment_engine.rb**: Orchestrates rule evaluation and assignment logic
* **generator.rb**: Coordinates the overall Secret Santa generation process

## Usage Examples

### With multiple previous years CSV files

```bash
bin/rails secret_santa:generate[employees.csv,output.csv,prev_24.csv,prev_25.csv]
```

### With one previous year CSV file

```bash
bin/rails secret_santa:generate[employees.csv,output.csv,prev25.csv]
```

### With no previous year CSV file

```bash
bin/rails secret_santa:generate[employees.csv,output.csv]
```

### Notes

* `employees.csv` → Current year employee list
* `output.csv` → Generated Secret Santa assignments
* `prev_*.csv` → One or more previous year assignment files (optional)
* You can pass **zero, one, or multiple** previous-year CSV files

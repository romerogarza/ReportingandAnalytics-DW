# Enterprise Data Warehouse
* See [SQL Server Jobs](https://github.com/romerogarza/ReportingandAnalytics-DW/tree/main/Stored%20Procedures) to view details around job structure.

### What is a Data Warehouse?

The Reporting & Analytics Data Warehouse is a central repository of information that can be analyzed to make more informed decisions. Data flows into our data warehouse from transactional systems, relational databases, and other sources, typically on a regular cadence.

### How is a Data Warehouse architected?

The Reporting & Analytics Data Warehouse architecture is made up of tiers. The top tier is the front-end KPI that presents results through reporting and analysis. The middle tier consists of the analytics engine that is used to access and analyze the data. The bottom tier of the architecture is the database server, where data is loaded and stored from our vendors.

### How does a Data Warehouse work?

The Data Warehouse will gather RAW data on a regular cadence from various North Kansas City Hospital vendors and load it into the Enterprise Database within our Librarian Server. This is considered the bottom tier of the architecture. Each vendor will have a dedicated schema to separate, consolidate, and organize table structure within the Enterprise Database. Once the raw data is extracted, transformation will begin and stored into views creating the various Models. These Models will be the foundation to the KPI’s needed and are considered to be the middle tier of the architecture. The final tier will focus on individual KPI’s, rolled up from each Model to display a single number or percentage to serve to leadership and stakeholders within a front-end application (PowerBi)

### What are the benefits of using a data warehouse?

Benefits of a data warehouse include the following:
* Informed decision making
* Consolidated data from many sources
* Historical data analysis
* Data quality, consistency, flexibility and accuracy
* Separation of analytics processing from transactional databases, which improves performance of both systems

# Enterprise Naming Convention

## Schema’s

Each North Kansas City Hospital Vendor will have a designated Schema. If no Schema is presented, one will be created with an owner of dbo. Naming convention is as follows: `<vendor>.<table>` Example: `cerner.table_name`

The idea is to mirror the data being captured within the vendor database and store it within the Enterprise Database. This allows our data to be flexible and easily grow.

### Stored Procedures

Stored Procedures will have three approaches to their names, the vendor, table name and action. Stored Procedures should start with the following `p_` Naming convention is as follows: `p_<vendor>_<table_name>_<action_name>`	Example: `p_cerner_encounter_insert`

### Tables

Tables will have two approaches to their names, the vendor, table name. Naming convention is as follows: `<vendor>.<table>` Example: `cerner.encounter`

### Views

Tables will have two approaches to their names, the vendor, table name. Views should start with the following v_ Naming convention is as follows: `v_<vendor>_<table_name>` Example: `p_cerner_encounter_insert`

# Enterprise Data Warehouse

## What is a Data Warehouse?

The Reporting & Analytics Data Warehouse is a central repository of information that can be analyzed to make more informed decisions. Data flows into our data warehouse from transactional systems, relational databases, and other sources, typically on a regular cadence.

## How is a Data Warehouse architected?

The Reporting & Analytics Data Warehouse architecture is made up of tiers. The top tier is the front-end KPI that presents results through reporting and analysis. The middle tier consists of the analytics engine that is used to access and analyze the data. The bottom tier of the architecture is the database server, where data is loaded and stored from our vendors.

##How does a Data Warehouse work?

The Data Warehouse will gather RAW data on a regular cadence from various North Kansas City Hospital vendors and load it into the Enterprise Database within our Librarian Server. This is considered the bottom tier of the architecture. Each vendor will have a dedicated schema to separate, consolidate, and organize table structure within the Enterprise Database. Once the raw data is extracted, transformation will begin and stored into views creating the various Models. These Models will be the foundation to the KPI’s needed and are considered to be the middle tier of the architecture. The final tier will focus on individual KPI’s, rolled up from each Model to display a single number or percentage to serve to leadership and stakeholders within a front-end application (PowerBi)


If you are unsure of whether your contribution should be implemented as a
module or part of Puppet Core, you may visit [#puppet-dev on slack](https://puppetcommunity.slack.com/), or ask on
the [puppet-dev mailing list](https://groups.google.com/forum/#!forum/puppet-dev) for advice.
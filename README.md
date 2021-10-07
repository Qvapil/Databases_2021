# Databases_2021
Database and UI for a hotel service.

Exercises for Databases course, 6th Semester 2021 of the Electrical and Computer Engineering School at the National Technical University of Athens.

In this project my partner and I created a database for a hotel service, ran some queries on it, and developed a simple UI to interact with it. 

**Relational diagram**

![Screenshot (1682)](https://user-images.githubusercontent.com/54019381/136377239-8ebb3d98-8397-4bb6-a914-db906d79a338.png)

### Project details

We used Microsoft SQL Server to create our database. Code for creation of tables and constraints is in the file *hoteltables.sql*, while code for each table specifically
is in the tables folder.

Mock data for the database can be added by running the file *insertEverything.sql*.

The files *createViewCustomers.sql* and *createViewService.sql* create two views for the database as instructed.

To connect with the database we use sql authentication so creating a user is necessary. The connection is done by XAMPP with included mssql-php configuration files.

The website is hosted locally, and its code is in file *index.php*. In lines 34-35 the details of the user created earlier must be added.

### Website
![Screenshot (1684)](https://user-images.githubusercontent.com/54019381/136379413-35fe82b5-6e0e-48a0-8213-5499a0b28221.png)
### Example of use
![Screenshot (1687)](https://user-images.githubusercontent.com/54019381/136380074-f1448841-0844-494c-a41e-a8b334f3e8e4.png)

# Hospital Management System

A web-based application for managing hospital operations, including patient registration, doctor management, department organization, and appointment booking.

## Features

### Patient Module
*   **User Registration & Login**: Secure account creation and authentication.
*   **Dashboard**: View personal details and appointment history.
*   **View Doctors**: Browse doctors by city, department, or specialization.
*   **Book Appointments**: Schedule appointments with doctors.
*   **Appointment Status**: Track the status of booked appointments.

### Admin Module
*   **Admin Dashboard**: Overview of hospital statistics.
*   **Manage Departments**: Add and view hospital departments.
*   **Manage Doctors**: Add new doctors with details (specialization, fees, availability).
*   **View Patients**: Access patient records.
*   **View Appointments**: Monitor all appointments and update their status.

## Technology Stack

*   **Frontend**: JSP (JavaServer Pages), HTML, CSS, JavaScript, Bootstrap (inferred from class names like `container`, `card`).
*   **Backend**: Java Servlets
*   **Database**: MySQL
*   **Build Tool**: Maven
*   **Server**: Apache Tomcat (Recommended)

## Prerequisites

*   Java Development Kit (JDK) 8 or higher
*   Apache Maven
*   MySQL Server
*   Apache Tomcat Server (v9.0 or higher recommended)

## Database Setup

1.  **Create Database**:
    Execute the following command in your MySQL client to create the database:
    ```sql
    CREATE DATABASE hospital_management_system;
    USE hospital_management_system;
    ```

2.  **Create Tables**:
    Run the following SQL scripts to create the necessary tables:

    ```sql
    -- Users Table
    CREATE TABLE users (
        user_id INT PRIMARY KEY AUTO_INCREMENT,
        full_name VARCHAR(100) NOT NULL,
        email VARCHAR(100) UNIQUE NOT NULL,
        password VARCHAR(255) NOT NULL,
        phone VARCHAR(20),
        address TEXT,
        city VARCHAR(50)
    );

    -- Departments Table
    CREATE TABLE departments (
        dept_id INT PRIMARY KEY AUTO_INCREMENT,
        dept_name VARCHAR(100) NOT NULL,
        description TEXT,
        icon VARCHAR(50) -- CSS class for icon usually
    );

    -- Doctors Table
    CREATE TABLE doctors (
        doctor_id INT PRIMARY KEY AUTO_INCREMENT,
        doctor_name VARCHAR(100) NOT NULL,
        specialization VARCHAR(100),
        dept_id INT,
        city VARCHAR(50),
        phone VARCHAR(20),
        email VARCHAR(100),
        qualification VARCHAR(100),
        experience INT,
        consultation_fee DOUBLE,
        available_days VARCHAR(100),
        available_time VARCHAR(50),
        FOREIGN KEY (dept_id) REFERENCES departments(dept_id) ON DELETE SET NULL
    );

    -- Appointments Table
    CREATE TABLE appointments (
        appointment_id INT PRIMARY KEY AUTO_INCREMENT,
        user_id INT,
        doctor_id INT,
        appointment_date DATE, -- or VARCHAR if stored as string
        appointment_time VARCHAR(20),
        status VARCHAR(20) DEFAULT 'Pending',
        FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
        FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE
    );
    
    -- Admin User (Optional, insert manually if needed or create logical admin check)
    -- Example: INSERT INTO users (full_name, email, password, ...) VALUES ('Admin', 'admin@hospital.com', 'admin123', ...);
    ```

3.  **Configure Connection**:
    Open `src/main/java/com/hospital/dao/DatabaseConnection.java` and update the database credentials:
    ```java
    private static final String USERNAME = "your_mysql_username"; // e.g., root
    private static final String PASSWORD = "your_mysql_password"; 
    ```

## Installation & Running

1.  **Clone the Repository**:
    ```bash
    git clone <repository-url>
    cd HospitalManagementSystem
    ```

2.  **Build the Project**:
    ```bash
    mvn clean install
    ```

3.  **Deploy to Tomcat**:
    *   Copy the generated `.war` file from the `target` directory to the `webapps` folder of your Tomcat installation.
    *   Start the Tomcat server.

4.  **Access the Application**:
    Open your web browser and navigate to:
    `http://localhost:8080/HospitalManagementSystem`

## Running in Eclipse (Step-by-Step)

If you are using the Eclipse IDE, follow these steps to run the project:

1.  **Import Project**:
    *   Open Eclipse.
    *   Go to **File** > **Import**.
    *   Select **Maven** > **Existing Maven Projects** and click **Next**.
    *   Click **Browse** and select the `HospitalManagementSystem` folder.
    *   Click **Finish**.

2.  **Update Dependencies**:
    *   Right-click on the project in "Project Explorer".
    *   Go to **Maven** > **Update Project**.
    *   Check **Force Update of Snapshots/Releases** and click **OK**.
    *   Wait for the update to complete (check the progress bar at the bottom right).

3.  **Run on Server**:
    *   Right-click on the project -> **Run As** -> **Run on Server**.
    *   Select **Apache Tomcat v9.0** (or your installed version).
    *   Click **Finish**.

## Troubleshooting & Common Errors

Here are solutions to common errors you might face when running on a new machine:

### 1. `java.lang.ClassNotFoundException: com.mysql.cj.jdbc.Driver`
*   **Problem**: This means the MySQL Connector JAR (library) is not being copied to the server when running.
*   **Solution**:
    1.  Right-click the project -> **Properties**.
    2.  Select **Deployment Assembly**.
    3.  Click **Add...** -> **Java Build Path Entries**.
    4.  Select **Maven Dependencies** -> Click **Finish**.
    5.  Click **Apply and Close**, then restart the server.

### 2. `java.sql.SQLException: Access denied for user 'root'@'localhost'`
*   **Problem**: The password in the Java code does not match your local MySQL password.
*   **Solution**:
    1.  Open `src/main/java/com/hospital/dao/DatabaseConnection.java`.
    2.  Change the `PASSWORD` variable (line 16) to your actual MySQL root password.

### 3. "Port 8080 required by Tomcat v9.0 Server at localhost is already in use"
*   **Problem**: Another application (or a previous instance of Tomcat) is already running on port 8080.
*   **Solution**:
    1.  Go to the **Servers** tab in Eclipse (usually at the bottom).
    2.  Double-click on your Tomcat server.
    3.  On the "Overview" page, find the **Ports** section.
    4.  Change the **HTTP/1.1** port from `8080` to `8081` or `8090`.
    5.  Save the file (`Ctrl+S`) and restart the server.
    6.  Access the app at `http://localhost:8081/HospitalManagementSystem` (if you changed to 8081).

### 4. HTTP Status 404 – Not Found
*   **Problem**: The server cannot find the project files, often due to a build path issue.
*   **Solution**:
    1.  Right-click Project -> **Build Path** -> **Configure Build Path**.
    2.  Check if there are any errors (red X) in the libraries.
    3.  Go to **Maven** -> **Update Project** to refresh dependencies.
    4.  Ensure your `deployment descriptor` (web.xml) is in the correct location (`src/main/webapp/WEB-INF/web.xml`).

## Project Structure

```
HospitalManagementSystem/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/hospital/
│   │   │       ├── dao/          # Data Access Objects (Database Logic)
│   │   │       ├── model/        # Java Models (POJOs)
│   │   │       ├── servlet/      # Servlets (Controllers)
│   │   │       └── util/         # Utility Classes
│   │   └── webapp/
│   │       ├── WEB-INF/          # Web Configuration (web.xml)
│   │       ├── css/              # Stylesheets
│   │       ├── js/               # JavaScript files
│   │       ├── *.jsp             # JavaServer Pages (Views)
├── pom.xml                       # Maven Dependencies
└── README.md                     # Project Documentation
```

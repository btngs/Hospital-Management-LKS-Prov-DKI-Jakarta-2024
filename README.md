# LKS_Wilayah

Windows Forms application for managing hospital appointment, built with C# and .NET Framework 4.7.2.

## Features

- Login form with SHA-512 password hashing
- Main dashboard
- Manage meeting data
- Master data for doctors
- Master data for patients

## Tech Stack

- C#
- Windows Forms
- .NET Framework 4.7.2
- SQL Server LocalDB

## Project Structure

- `LKS_Wilayah.slnx` - solution file
- `LKS_Wilayah/Program.cs` - application entry point
- `LKS_Wilayah/LoginForm.cs` - login screen
- `LKS_Wilayah/MainForm.cs` - main application window
- `LKS_Wilayah/ManageMeeting.cs` - meeting management form
- `LKS_Wilayah/MasterDoctor.cs` - doctor master data form
- `LKS_Wilayah/MasterPatient.cs` - patient master data form
- `LKS_Wilayah/koneksi.cs` - database connection helper

## Database Configuration

The application now creates its LocalDB database automatically on first run.

Connection details are defined in `LKS_Wilayah/koneksi.cs`:

- database name: `LKS_Wilayah`
- SQL Server instance: `(localdb)\MSSQLLocalDB`

On startup, the app will:

1. Create the database if it does not exist
2. Load and execute `LKS_Wilayah/database_mssql.sql`
3. Populate the app with the same tables and data from your local SQL Server export

Default login:

- username: `john_doe`
- password: `john_doe`

## Running the App

1. Open `LKS_Wilayah.slnx` in Visual Studio.
2. Restore/build the solution.
3. Run the project.
4. Use the default login above to get into the app.

## Login Behavior

- Username and password are checked against the `[user]` table.
- Passwords are hashed with SHA-512 before comparison.
- `Program.cs` now starts at `LoginForm`, so the login flow is active.

## Important

- The SQL script is treated as the source of truth for database contents.
- If you update `database_mssql.sql`, the app will use that version on a fresh install.
- If the script already created the database on the machine, first-run import will be skipped.

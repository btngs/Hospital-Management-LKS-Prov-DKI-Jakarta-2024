using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace LKS_Wilayah
{
    public static class DatabaseInitializer
    {
        public static void EnsureCreated()
        {
            CreateDatabaseIfMissing();
            CreateTablesIfMissing();
            SeedInitialData();
        }

        private static void CreateDatabaseIfMissing()
        {
            using (SqlConnection connection = new SqlConnection(koneksi.MasterConnString))
            {
                connection.Open();
                string query = @"
IF DB_ID(@dbName) IS NULL
BEGIN
    DECLARE @sql NVARCHAR(MAX) = N'CREATE DATABASE [' + @dbName + N']';
    EXEC sp_executesql @sql;
END";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@dbName", koneksi.DatabaseName);
                    command.ExecuteNonQuery();
                }
            }
        }

        private static void CreateTablesIfMissing()
        {
            using (SqlConnection connection = koneksi.GetConn())
            {
                connection.Open();
                string query = @"
IF OBJECT_ID('dbo.[user]', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.[user] (
        id INT IDENTITY(1,1) PRIMARY KEY,
        username NVARCHAR(100) NOT NULL UNIQUE,
        password NVARCHAR(128) NOT NULL
    );
END

IF OBJECT_ID('dbo.doctor_category', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.doctor_category (
        id INT IDENTITY(1,1) PRIMARY KEY,
        category NVARCHAR(100) NOT NULL UNIQUE
    );
END

IF OBJECT_ID('dbo.doctor', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.doctor (
        id INT IDENTITY(1,1) PRIMARY KEY,
        name NVARCHAR(150) NOT NULL,
        phone_number NVARCHAR(50) NULL,
        email NVARCHAR(150) NULL,
        city_of_birth NVARCHAR(100) NULL,
        date_of_birth DATE NULL,
        address NVARCHAR(255) NULL,
        gender NVARCHAR(20) NULL,
        assigned_room NVARCHAR(50) NULL,
        doctor_category_id INT NULL,
        CONSTRAINT FK_doctor_doctor_category
            FOREIGN KEY (doctor_category_id) REFERENCES dbo.doctor_category(id)
    );
END

IF OBJECT_ID('dbo.patient', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.patient (
        id INT IDENTITY(1,1) PRIMARY KEY,
        name NVARCHAR(150) NOT NULL,
        phone_number NVARCHAR(50) NULL,
        email NVARCHAR(150) NULL,
        date_of_birth DATE NULL,
        address NVARCHAR(255) NULL,
        gender NVARCHAR(20) NULL,
        blood_type NVARCHAR(10) NULL
    );
END

IF OBJECT_ID('dbo.meeting', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.meeting (
        id INT IDENTITY(1,1) PRIMARY KEY,
        [date] DATETIME NOT NULL,
        patient_id INT NOT NULL,
        doctor_id INT NOT NULL,
        queue_number INT NOT NULL,
        CONSTRAINT FK_meeting_patient
            FOREIGN KEY (patient_id) REFERENCES dbo.patient(id),
        CONSTRAINT FK_meeting_doctor
            FOREIGN KEY (doctor_id) REFERENCES dbo.doctor(id)
    );
END

IF OBJECT_ID('dbo.patient_record', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.patient_record (
        id INT IDENTITY(1,1) PRIMARY KEY,
        patient_id INT NOT NULL,
        notes NVARCHAR(MAX) NULL,
        record_date DATETIME NOT NULL DEFAULT GETDATE(),
        CONSTRAINT FK_patient_record_patient
            FOREIGN KEY (patient_id) REFERENCES dbo.patient(id)
    );
END";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.ExecuteNonQuery();
                }
            }
        }

        private static void SeedInitialData()
        {
            using (SqlConnection connection = koneksi.GetConn())
            {
                connection.Open();

                string seedCategory = @"
IF NOT EXISTS (SELECT 1 FROM dbo.doctor_category)
BEGIN
    INSERT INTO dbo.doctor_category (category)
    VALUES (N'General'), (N'Pediatric'), (N'Cardiology');
END";

                string seedUser = @"
IF NOT EXISTS (SELECT 1 FROM dbo.[user])
BEGIN
    INSERT INTO dbo.[user] (username, password)
    VALUES (@username, @password);
END";

                using (SqlCommand command = new SqlCommand(seedCategory, connection))
                {
                    command.ExecuteNonQuery();
                }

                using (SqlCommand command = new SqlCommand(seedUser, connection))
                {
                    command.Parameters.AddWithValue("@username", "john_doe");
                    command.Parameters.AddWithValue("@password", HashPassword("password"));
                    command.ExecuteNonQuery();
                }
            }
        }

        private static string HashPassword(string password)
        {
            using (SHA512 sha512 = SHA512.Create())
            {
                byte[] bytes = sha512.ComputeHash(Encoding.UTF8.GetBytes(password));
                return BitConverter.ToString(bytes).Replace("-", "").ToLowerInvariant();
            }
        }
    }
}

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;

namespace LKS_Wilayah
{
    public static class DatabaseInitializer
    {
        private const string SqlScriptFileName = "database_mssql.sql";

        public static void EnsureCreated()
        {
            if (DatabaseExists())
            {
                return;
            }

            CreateDatabase();
            ExecuteScriptFile();
        }

        private static bool DatabaseExists()
        {
            using (SqlConnection connection = new SqlConnection(koneksi.MasterConnString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand("SELECT CASE WHEN DB_ID(@dbName) IS NULL THEN 0 ELSE 1 END", connection))
                {
                    command.Parameters.AddWithValue("@dbName", koneksi.DatabaseName);
                    return Convert.ToInt32(command.ExecuteScalar()) == 1;
                }
            }
        }

        private static void CreateDatabase()
        {
            using (SqlConnection connection = new SqlConnection(koneksi.MasterConnString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(
                    $"IF DB_ID(@dbName) IS NULL EXEC('CREATE DATABASE [{koneksi.DatabaseName}]')",
                    connection))
                {
                    command.Parameters.AddWithValue("@dbName", koneksi.DatabaseName);
                    command.ExecuteNonQuery();
                }
            }
        }

        private static void ExecuteScriptFile()
        {
            string scriptPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, SqlScriptFileName);
            if (!File.Exists(scriptPath))
            {
                throw new FileNotFoundException($"Database seed file not found: {scriptPath}");
            }

            string script = File.ReadAllText(scriptPath, Encoding.UTF8);
            script = NormalizeScript(script);

            using (SqlConnection connection = koneksi.GetConn())
            {
                connection.Open();
                foreach (string batch in SplitBatches(script))
                {
                    string trimmed = batch.Trim();
                    if (trimmed.Length == 0)
                    {
                        continue;
                    }

                    using (SqlCommand command = new SqlCommand(trimmed, connection))
                    {
                        command.CommandTimeout = 0;
                        command.ExecuteNonQuery();
                    }
                }
            }
        }

        private static string NormalizeScript(string script)
        {
            script = script.Replace("CREATE DATABASE DESKTOP_XX", $"CREATE DATABASE {koneksi.DatabaseName}");
            script = script.Replace("USE DESKTOP_XX", $"USE {koneksi.DatabaseName}");
            script = script.Replace("USE [DESKTOP_XX]", $"USE [{koneksi.DatabaseName}]");
            script = script.Replace("CREATE DATABASE [DESKTOP_XX]", $"CREATE DATABASE [{koneksi.DatabaseName}]");
            script = script.Replace("USE [DESKTOP_XX]", $"USE [{koneksi.DatabaseName}]");
            return script;
        }

        private static IEnumerable<string> SplitBatches(string script)
        {
            StringBuilder current = new StringBuilder();
            using (StringReader reader = new StringReader(script))
            {
                string line;
                while ((line = reader.ReadLine()) != null)
                {
                    if (string.Equals(line.Trim(), "GO", StringComparison.OrdinalIgnoreCase))
                    {
                        yield return current.ToString();
                        current.Clear();
                        continue;
                    }

                    current.AppendLine(line);
                }
            }

            if (current.Length > 0)
            {
                yield return current.ToString();
            }
        }
    }
}
